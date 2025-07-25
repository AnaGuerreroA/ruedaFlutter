import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/circulo_emociones.dart';

/// Servicio de almacenamiento que funciona tanto en web como en desktop
/// En web usa localStorage, en desktop usaría SQLite
class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  final Logger _logger = Logger();
  final String _key = 'selecciones_emociones';

  /// Guardar una selección de emoción
  Future<void> guardarSeleccion(SeleccionEmocion seleccion) async {
    try {
      _logger.i('Guardando selección: ${seleccion.nombreOriginal}');
      
      final selecciones = await obtenerTodasLasSelecciones();
      
      // Agregar nueva selección con ID incremental
      final nuevoId = selecciones.isNotEmpty 
          ? (selecciones.map((s) => s.id ?? 0).reduce((a, b) => a > b ? a : b)) + 1
          : 1;
      
      final nuevaSeleccion = SeleccionEmocion(
        id: nuevoId,
        idEmocion: seleccion.idEmocion,
        nombreOriginal: seleccion.nombreOriginal,
        intensidad: seleccion.intensidad,
        comentarios: seleccion.comentarios,
        fechaSeleccion: seleccion.fechaSeleccion,
        idioma: seleccion.idioma,
      );
      
      selecciones.add(nuevaSeleccion);
      await _guardarEnStorage(selecciones);
      
      _logger.i('Selección guardada con ID: $nuevoId');
    } catch (e) {
      _logger.e('Error guardando selección: $e');
      rethrow;
    }
  }

  /// Obtener todas las selecciones
  Future<List<SeleccionEmocion>> obtenerTodasLasSelecciones() async {
    try {
      if (kIsWeb) {
        return await _obtenerDeWebStorage();
      } else {
        // En el futuro, aquí iría la lógica de SQLite para desktop
        return await _obtenerDeWebStorage(); // Por ahora usamos storage simple
      }
    } catch (e) {
      _logger.w('Error obteniendo selecciones: $e');
      return [];
    }
  }

  /// Obtener selecciones recientes
  Future<List<SeleccionEmocion>> obtenerSeleccionesRecientes({int limit = 10}) async {
    final selecciones = await obtenerTodasLasSelecciones();
    selecciones.sort((a, b) => b.fechaSeleccion.compareTo(a.fechaSeleccion));
    return selecciones.take(limit).toList();
  }

  /// Obtener estadísticas básicas
  Future<Map<String, dynamic>> obtenerEstadisticas() async {
    final selecciones = await obtenerTodasLasSelecciones();
    
    if (selecciones.isEmpty) {
      return {
        'totalSelecciones': 0,
        'intensidadPromedio': 0.0,
        'emocionMasFrecuente': null,
      };
    }

    // Calcular estadísticas
    final intensidadPromedio = selecciones
        .map((s) => s.intensidad)
        .reduce((a, b) => a + b) / selecciones.length;

    // Emoción más frecuente
    final frecuencias = <String, int>{};
    for (final seleccion in selecciones) {
      frecuencias[seleccion.nombreOriginal] = 
          (frecuencias[seleccion.nombreOriginal] ?? 0) + 1;
    }

    final emocionMasFrecuente = frecuencias.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;

    return {
      'totalSelecciones': selecciones.length,
      'intensidadPromedio': intensidadPromedio,
      'emocionMasFrecuente': emocionMasFrecuente,
      'frecuencias': frecuencias,
    };
  }

  /// Limpiar todas las selecciones (para testing)
  Future<void> limpiarSelecciones() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
      _logger.i('Selecciones limpiadas del almacenamiento persistente');
    } catch (e) {
      _logger.e('Error limpiando selecciones: $e');
    }
  }

  /// Verificar si hay datos guardados
  Future<bool> tieneDatosGuardados() async {
    try {
      final selecciones = await obtenerTodasLasSelecciones();
      return selecciones.isNotEmpty;
    } catch (e) {
      _logger.w('Error verificando datos guardados: $e');
      return false;
    }
  }

  /// Obtener información de debug sobre el almacenamiento
  Future<Map<String, dynamic>> obtenerInfoDebug() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final selecciones = await obtenerTodasLasSelecciones();
      
      return {
        'totalSelecciones': selecciones.length,
        'tamañoDatos': prefs.getString(_key)?.length ?? 0,
        'ultimaSeleccion': selecciones.isNotEmpty 
            ? selecciones.last.fechaSeleccion.toIso8601String()
            : null,
        'primeraSeleccion': selecciones.isNotEmpty 
            ? selecciones.first.fechaSeleccion.toIso8601String()
            : null,
      };
    } catch (e) {
      _logger.e('Error obteniendo info de debug: $e');
      return {'error': e.toString()};
    }
  }

  /// Generar datos de prueba para demostración de gráficos
  Future<void> generarDatosPrueba() async {
    try {
      final datosPrueba = <SeleccionEmocion>[];
      final emociones = ['Alegría', 'Tristeza', 'Ira', 'Miedo', 'Sorpresa', 'Asco', 'Amor', 'Ansiedad'];
      final random = DateTime.now().millisecondsSinceEpoch;
      
      // Generar datos para los últimos 30 días
      for (int i = 0; i < 30; i++) {
        final fecha = DateTime.now().subtract(Duration(days: i));
        
        // Generar 1-5 registros por día
        final registrosPorDia = (random % 5) + 1;
        
        for (int j = 0; j < registrosPorDia; j++) {
          final emocionIndex = (random + i + j) % emociones.length;
          final intensidad = ((random + i * j) % 10) + 1;
          final hora = (random + i + j) % 24;
          
          final fechaConHora = DateTime(
            fecha.year,
            fecha.month,
            fecha.day,
            hora,
            (random + j) % 60,
          );
          
          datosPrueba.add(SeleccionEmocion(
            id: i * 10 + j + 1,
            idEmocion: emocionIndex + 1,
            nombreOriginal: emociones[emocionIndex],
            intensidad: intensidad,
            comentarios: 'Comentario de prueba ${i * 10 + j + 1}',
            fechaSeleccion: fechaConHora,
            idioma: 'es',
          ));
        }
      }
      
      await _guardarEnStorage(datosPrueba);
      _logger.i('Generados ${datosPrueba.length} datos de prueba');
    } catch (e) {
      _logger.e('Error generando datos de prueba: $e');
    }
  }

  // Métodos privados para manejo de storage

  Future<List<SeleccionEmocion>> _obtenerDeWebStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(_key);
      if (data == null) return [];
      
      final List<dynamic> jsonList = jsonDecode(data);
      return jsonList.map((json) => SeleccionEmocion.fromJson(json)).toList();
    } catch (e) {
      _logger.w('Error leyendo de storage: $e');
      return [];
    }
  }

  Future<void> _guardarEnStorage(List<SeleccionEmocion> selecciones) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonData = jsonEncode(selecciones.map((s) => s.toJson()).toList());
      await prefs.setString(_key, jsonData);
      _logger.i('Datos guardados persistentemente');
    } catch (e) {
      _logger.e('Error guardando en storage: $e');
      rethrow;
    }
  }
}
