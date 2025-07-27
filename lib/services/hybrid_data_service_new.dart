import 'package:logger/logger.dart';
import '../models/circulo_emociones.dart';
import 'storage_service.dart';
import 'api_service.dart';

/// Servicio híbrido simplificado que maneja Storage local + API REST
/// Funciona offline y sincroniza cuando hay conexión
class HybridDataService {
  static final HybridDataService _instance = HybridDataService._internal();
  factory HybridDataService() => _instance;
  HybridDataService._internal();

  final StorageService _localStorage = StorageService();
  final ApiService _apiService = ApiService();
  final Logger _logger = Logger();

  bool _isOnline = false;
  bool get isOnline => _isOnline;

  /// Inicializar el servicio
  Future<void> initialize() async {
    await verificarConectividad();
    _logger.i('HybridDataService inicializado');
  }

  /// Verificar conectividad
  Future<void> verificarConectividad() async {
    try {
      _isOnline = await _apiService.verificarConectividad();
      _logger.i('Estado de conectividad: ${_isOnline ? "Online" : "Offline"}');
    } catch (e) {
      _isOnline = false;
      _logger.w('Error verificando conectividad: $e');
    }
  }

  /// Guardar selección de emoción
  Future<Map<String, dynamic>> guardarSeleccionEmocion(SeleccionEmocion seleccion) async {
    try {
      // Siempre guardar localmente primero
      await _localStorage.guardarSeleccion(seleccion);
      _logger.i('Selección guardada localmente: ${seleccion.nombreOriginal}');

      await verificarConectividad();

      // Si hay conexión, intentar sincronizar inmediatamente
      if (_isOnline) {
        try {
          final apiResponse = await _apiService.guardarSeleccionEmocion(seleccion);
          if (apiResponse.success) {
            _logger.i('Selección sincronizada con servidor ID: ${apiResponse.data}');
            return {
              'success': true,
              'syncStatus': 'synced',
              'serverId': apiResponse.data,
              'message': 'Guardado y sincronizado correctamente'
            };
          } else {
            _logger.w('Error en API: ${apiResponse.error}');
          }
        } catch (e) {
          _logger.w('Error sincronizando: $e');
        }
      }

      // Si no se pudo sincronizar, está guardado localmente
      return {
        'success': true,
        'syncStatus': _isOnline ? 'pending' : 'offline',
        'message': _isOnline 
            ? 'Guardado localmente, pendiente de sincronización'
            : 'Guardado localmente (modo offline)'
      };

    } catch (e) {
      _logger.e('Error guardando selección: $e');
      return {
        'success': false,
        'error': e.toString()
      };
    }
  }

  /// Obtener selecciones de emociones
  Future<List<SeleccionEmocion>> obtenerSelecciones({
    int? limit,
    String? idioma,
    DateTime? fechaDesde,
    DateTime? fechaHasta,
  }) async {
    try {
      // Siempre obtener de storage local para respuesta inmediata
      var selecciones = await _localStorage.obtenerTodasLasSelecciones();

      // Aplicar filtros
      if (idioma != null) {
        selecciones = selecciones.where((s) => s.idioma == idioma).toList();
      }

      if (fechaDesde != null) {
        selecciones = selecciones.where((s) => 
            s.fechaSeleccion.isAfter(fechaDesde.subtract(const Duration(days: 1)))).toList();
      }

      if (fechaHasta != null) {
        selecciones = selecciones.where((s) => 
            s.fechaSeleccion.isBefore(fechaHasta.add(const Duration(days: 1)))).toList();
      }

      // Ordenar por fecha (más recientes primero)
      selecciones.sort((a, b) => b.fechaSeleccion.compareTo(a.fechaSeleccion));

      // Aplicar límite
      if (limit != null && limit > 0) {
        selecciones = selecciones.take(limit).toList();
      }

      _logger.i('Obtenidas ${selecciones.length} selecciones');
      return selecciones;

    } catch (e) {
      _logger.e('Error obteniendo selecciones: $e');
      return [];
    }
  }

  /// Obtener estadísticas de emociones
  Future<Map<String, dynamic>> obtenerEstadisticas({String? idioma}) async {
    try {
      await verificarConectividad();

      // Si estamos online, intentar obtener del servidor
      if (_isOnline) {
        try {
          final apiResponse = await _apiService.obtenerEstadisticas(idioma: idioma);
          if (apiResponse.success) {
            _logger.i('Estadísticas obtenidas del servidor');
            return apiResponse.data!;
          }
        } catch (e) {
          _logger.w('Error obteniendo estadísticas del servidor: $e');
        }
      }

      // Fallback a estadísticas locales
      _logger.i('Obteniendo estadísticas locales');
      return await _localStorage.obtenerEstadisticas();

    } catch (e) {
      _logger.e('Error obteniendo estadísticas: $e');
      return {
        'totalSelecciones': 0,
        'intensidadPromedio': 0.0,
        'emocionMasFrecuente': null,
      };
    }
  }

  /// Sincronizar datos pendientes (método simplificado)
  Future<Map<String, dynamic>> sincronizarDatosPendientes() async {
    try {
      await verificarConectividad();

      if (!_isOnline) {
        return {
          'success': false,
          'message': 'Sin conexión a internet'
        };
      }

      // Obtener todas las selecciones locales
      final seleccionesLocales = await _localStorage.obtenerTodasLasSelecciones();

      if (seleccionesLocales.isEmpty) {
        return {
          'success': true,
          'message': 'No hay datos para sincronizar',
          'sincronizadas': 0
        };
      }

      int exitosas = 0;
      int fallidas = 0;

      // Intentar sincronizar cada selección
      for (final seleccion in seleccionesLocales) {
        try {
          final response = await _apiService.guardarSeleccionEmocion(seleccion);
          if (response.success) {
            exitosas++;
          } else {
            fallidas++;
          }
        } catch (e) {
          _logger.w('Error sincronizando selección: $e');
          fallidas++;
        }
      }

      _logger.i('Sincronización completada: $exitosas exitosas, $fallidas fallidas');

      return {
        'success': true,
        'message': 'Sincronización completada',
        'sincronizadas': exitosas,
        'fallidas': fallidas,
        'total': seleccionesLocales.length
      };

    } catch (e) {
      _logger.e('Error en sincronización: $e');
      return {
        'success': false,
        'error': e.toString()
      };
    }
  }

  /// Limpiar datos de prueba
  Future<void> limpiarDatosPrueba() async {
    try {
      await _localStorage.limpiarSelecciones();
      _logger.i('Datos de prueba limpiados');
    } catch (e) {
      _logger.e('Error limpiando datos: $e');
    }
  }
}
