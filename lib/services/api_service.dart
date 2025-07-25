import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../models/circulo_emociones.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final Logger _logger = Logger();
  
  // URL base de tu API - cambia esto por tu servidor real
  // IMPORTANTE: Actualiza esta URL según tu configuración:
  // - Desarrollo local: 'http://192.168.1.100:5000/api' (tu IP local)
  // - Desarrollo HTTPS: 'https://localhost:7001/api'
  // - Producción: 'https://tu-dominio.com/api'
  static const String _baseUrl = 'https://localhost:7001/api'; // ⚠️ CAMBIAR ESTA URL
  
  // Headers comunes
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Timeout para las peticiones
  static const Duration _timeout = Duration(seconds: 30);

  /// Guardar una selección de emoción en el servidor
  Future<ApiResponse<int>> guardarSeleccionEmocion(SeleccionEmocion seleccion) async {
    try {
      _logger.i('Guardando selección: ${seleccion.nombreOriginal}');
      
      final response = await http.post(
        Uri.parse('$_baseUrl/selecciones-emociones'),
        headers: _headers,
        body: jsonEncode(seleccion.toJson()),
      ).timeout(_timeout);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        _logger.i('Selección guardada exitosamente. ID: ${data['id']}');
        
        return ApiResponse.success(data['id'] as int);
      } else {
        _logger.e('Error del servidor: ${response.statusCode} - ${response.body}');
        return ApiResponse.error('Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      _logger.e('Error de conexión: $e');
      if (e.toString().contains('TimeoutException')) {
        return ApiResponse.error('Tiempo de espera agotado. Verifica tu conexión.');
      }
      return ApiResponse.error('Error de conexión: $e');
    }
  }

  /// Obtener selecciones del servidor
  Future<ApiResponse<List<SeleccionEmocion>>> obtenerSelecciones({
    int? limit,
    String? idioma,
    DateTime? fechaDesde,
    DateTime? fechaHasta,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (limit != null) queryParams['limit'] = limit.toString();
      if (idioma != null) queryParams['idioma'] = idioma;
      if (fechaDesde != null) queryParams['fechaDesde'] = fechaDesde.toIso8601String();
      if (fechaHasta != null) queryParams['fechaHasta'] = fechaHasta.toIso8601String();

      final uri = Uri.parse('$_baseUrl/selecciones-emociones').replace(
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      _logger.i('Obteniendo selecciones: $uri');

      final response = await http.get(uri, headers: _headers).timeout(_timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final selecciones = data.map((json) => SeleccionEmocion.fromJson(json)).toList();
        
        _logger.i('${selecciones.length} selecciones obtenidas');
        return ApiResponse.success(selecciones);
      } else {
        _logger.e('Error obteniendo selecciones: ${response.statusCode}');
        return ApiResponse.error('Error obteniendo datos: ${response.statusCode}');
      }
    } catch (e) {
      _logger.e('Error obteniendo selecciones: $e');
      return ApiResponse.error('Error de conexión: $e');
    }
  }

  /// Obtener estadísticas del servidor
  Future<ApiResponse<Map<String, dynamic>>> obtenerEstadisticas({String? idioma}) async {
    try {
      final queryParams = <String, String>{};
      if (idioma != null) queryParams['idioma'] = idioma;

      final uri = Uri.parse('$_baseUrl/estadisticas').replace(
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      _logger.i('Obteniendo estadísticas: $uri');

      final response = await http.get(uri, headers: _headers).timeout(_timeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _logger.i('Estadísticas obtenidas exitosamente');
        return ApiResponse.success(data);
      } else {
        _logger.e('Error obteniendo estadísticas: ${response.statusCode}');
        return ApiResponse.error('Error obteniendo estadísticas: ${response.statusCode}');
      }
    } catch (e) {
      _logger.e('Error obteniendo estadísticas: $e');
      return ApiResponse.error('Error de conexión: $e');
    }
  }

  /// Sincronizar datos pendientes (para modo offline)
  Future<ApiResponse<SyncResult>> sincronizarDatos(List<SeleccionEmocion> seleccionesPendientes) async {
    try {
      _logger.i('Sincronizando ${seleccionesPendientes.length} selecciones pendientes');

      final response = await http.post(
        Uri.parse('$_baseUrl/sincronizar'),
        headers: _headers,
        body: jsonEncode({
          'selecciones': seleccionesPendientes.map((s) => s.toJson()).toList(),
        }),
      ).timeout(_timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final result = SyncResult.fromJson(data);
        
        _logger.i('Sincronización completada: ${result.exitosas} exitosas, ${result.fallidas} fallidas');
        return ApiResponse.success(result);
      } else {
        _logger.e('Error en sincronización: ${response.statusCode}');
        return ApiResponse.error('Error en sincronización: ${response.statusCode}');
      }
    } catch (e) {
      _logger.e('Error sincronizando: $e');
      return ApiResponse.error('Error de sincronización: $e');
    }
  }

  /// Verificar conectividad con el servidor
  Future<bool> verificarConectividad() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/health'),
        headers: _headers,
      ).timeout(const Duration(seconds: 10));

      return response.statusCode == 200;
    } catch (e) {
      _logger.w('Sin conectividad con el servidor: $e');
      return false;
    }
  }
}

/// Clase para manejar respuestas de la API
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? error;
  final int? statusCode;

  ApiResponse._({
    required this.success,
    this.data,
    this.error,
    this.statusCode,
  });

  factory ApiResponse.success(T data) {
    return ApiResponse._(success: true, data: data);
  }

  factory ApiResponse.error(String error, [int? statusCode]) {
    return ApiResponse._(success: false, error: error, statusCode: statusCode);
  }
}

/// Resultado de sincronización
class SyncResult {
  final int exitosas;
  final int fallidas;
  final List<String> errores;

  SyncResult({
    required this.exitosas,
    required this.fallidas,
    required this.errores,
  });

  factory SyncResult.fromJson(Map<String, dynamic> json) {
    return SyncResult(
      exitosas: json['exitosas'] ?? 0,
      fallidas: json['fallidas'] ?? 0,
      errores: List<String>.from(json['errores'] ?? []),
    );
  }
}
