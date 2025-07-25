import 'package:collection/collection.dart';
import 'package:logger/logger.dart';
import '../models/circulo_emociones.dart';
import 'hybrid_data_service.dart';

/// Servicio especializado para análisis y reportes de datos emocionales
class AnalisisEmocionalService {
  static final AnalisisEmocionalService _instance = AnalisisEmocionalService._internal();
  factory AnalisisEmocionalService() => _instance;
  AnalisisEmocionalService._internal();

  final HybridDataService _dataService = HybridDataService();
  final Logger _logger = Logger();

  /// Obtener tendencia de intensidad emocional por día
  Future<List<TendenciaIntensidad>> obtenerTendenciaIntensidad({
    int dias = 30,
    String? idioma,
  }) async {
    try {
      final fechaDesde = DateTime.now().subtract(Duration(days: dias));
      final selecciones = await _dataService.obtenerSelecciones(
        fechaDesde: fechaDesde,
        idioma: idioma,
      );

      // Agrupar por día
      final Map<DateTime, List<SeleccionEmocion>> seleccionesPorDia = {};
      
      for (final seleccion in selecciones) {
        final fecha = DateTime(
          seleccion.fechaSeleccion.year,
          seleccion.fechaSeleccion.month,
          seleccion.fechaSeleccion.day,
        );
        
        seleccionesPorDia.putIfAbsent(fecha, () => []).add(seleccion);
      }

      // Calcular intensidad promedio por día
      final tendencias = <TendenciaIntensidad>[];
      
      for (int i = 0; i < dias; i++) {
        final fecha = DateTime.now().subtract(Duration(days: dias - 1 - i));
        final fechaDia = DateTime(fecha.year, fecha.month, fecha.day);
        
        final seleccionesDia = seleccionesPorDia[fechaDia] ?? [];
        
        final intensidadPromedio = seleccionesDia.isEmpty
            ? 0.0
            : seleccionesDia.map((s) => s.intensidad).average;

        tendencias.add(TendenciaIntensidad(
          fecha: fechaDia,
          intensidadPromedio: intensidadPromedio,
          cantidadSelecciones: seleccionesDia.length,
        ));
      }

      _logger.i('Tendencia de intensidad calculada para ${tendencias.length} días');
      return tendencias;

    } catch (e) {
      _logger.e('Error obteniendo tendencia de intensidad: $e');
      return [];
    }
  }

  /// Obtener distribución de emociones (frecuencia por emoción)
  Future<List<DistribucionEmocion>> obtenerDistribucionEmociones({
    int dias = 30,
    String? idioma,
    int limite = 10,
  }) async {
    try {
      final fechaDesde = DateTime.now().subtract(Duration(days: dias));
      final selecciones = await _dataService.obtenerSelecciones(
        fechaDesde: fechaDesde,
        idioma: idioma,
      );

      // Contar frecuencia por emoción
      final Map<String, int> frecuencias = {};
      final Map<String, List<int>> intensidades = {};

      for (final seleccion in selecciones) {
        final emocion = seleccion.nombreOriginal;
        frecuencias[emocion] = (frecuencias[emocion] ?? 0) + 1;
        intensidades.putIfAbsent(emocion, () => []).add(seleccion.intensidad);
      }

      // Crear lista de distribución
      final distribucion = frecuencias.entries.map((entry) {
        final emocion = entry.key;
        final frecuencia = entry.value;
        final intensidadPromedio = intensidades[emocion]!.average;

        return DistribucionEmocion(
          emocion: emocion,
          frecuencia: frecuencia,
          intensidadPromedio: intensidadPromedio,
          porcentaje: (frecuencia / selecciones.length) * 100,
        );
      }).toList();

      // Ordenar por frecuencia y limitar
      distribucion.sort((a, b) => b.frecuencia.compareTo(a.frecuencia));
      
      final resultado = distribucion.take(limite).toList();
      _logger.i('Distribución de emociones calculada: ${resultado.length} emociones');
      
      return resultado;

    } catch (e) {
      _logger.e('Error obteniendo distribución de emociones: $e');
      return [];
    }
  }

  /// Obtener patrones emocionales por hora del día
  Future<List<PatronHorario>> obtenerPatronesHorarios({
    int dias = 30,
    String? idioma,
  }) async {
    try {
      final fechaDesde = DateTime.now().subtract(Duration(days: dias));
      final selecciones = await _dataService.obtenerSelecciones(
        fechaDesde: fechaDesde,
        idioma: idioma,
      );

      // Agrupar por hora del día
      final Map<int, List<SeleccionEmocion>> seleccionesPorHora = {};
      
      for (final seleccion in selecciones) {
        final hora = seleccion.fechaSeleccion.hour;
        seleccionesPorHora.putIfAbsent(hora, () => []).add(seleccion);
      }

      // Calcular patrones por hora
      final patrones = <PatronHorario>[];
      
      for (int hora = 0; hora < 24; hora++) {
        final seleccionesHora = seleccionesPorHora[hora] ?? [];
        
        final intensidadPromedio = seleccionesHora.isEmpty
            ? 0.0
            : seleccionesHora.map((s) => s.intensidad).average;

        patrones.add(PatronHorario(
          hora: hora,
          intensidadPromedio: intensidadPromedio,
          cantidadSelecciones: seleccionesHora.length,
        ));
      }

      _logger.i('Patrones horarios calculados para 24 horas');
      return patrones;

    } catch (e) {
      _logger.e('Error obteniendo patrones horarios: $e');
      return [];
    }
  }

  /// Obtener comparativa entre períodos
  Future<ComparativaPeriodos> obtenerComparativaPeriodos({
    int diasPeriodo = 7, // Última semana vs semana anterior
    String? idioma,
  }) async {
    try {
      final ahora = DateTime.now();
      
      // Período actual
      final fechaDesdeActual = ahora.subtract(Duration(days: diasPeriodo));
      final seleccionesActuales = await _dataService.obtenerSelecciones(
        fechaDesde: fechaDesdeActual,
        idioma: idioma,
      );

      // Período anterior
      final fechaDesdeAnterior = ahora.subtract(Duration(days: diasPeriodo * 2));
      final fechaHastaAnterior = ahora.subtract(Duration(days: diasPeriodo));
      final seleccionesAnteriores = await _dataService.obtenerSelecciones(
        fechaDesde: fechaDesdeAnterior,
        fechaHasta: fechaHastaAnterior,
        idioma: idioma,
      );

      // Calcular métricas
      final intensidadActual = seleccionesActuales.isEmpty
          ? 0.0
          : seleccionesActuales.map((s) => s.intensidad).average;
          
      final intensidadAnterior = seleccionesAnteriores.isEmpty
          ? 0.0
          : seleccionesAnteriores.map((s) => s.intensidad).average;

      final cambioIntensidad = intensidadActual - intensidadAnterior;
      final cambioFrecuencia = seleccionesActuales.length - seleccionesAnteriores.length;

      final comparativa = ComparativaPeriodos(
        periodoActual: ResumenPeriodo(
          selecciones: seleccionesActuales.length,
          intensidadPromedio: intensidadActual,
          fechaDesde: fechaDesdeActual,
          fechaHasta: ahora,
        ),
        periodoAnterior: ResumenPeriodo(
          selecciones: seleccionesAnteriores.length,
          intensidadPromedio: intensidadAnterior,
          fechaDesde: fechaDesdeAnterior,
          fechaHasta: fechaHastaAnterior,
        ),
        cambioIntensidad: cambioIntensidad,
        cambioFrecuencia: cambioFrecuencia,
      );

      _logger.i('Comparativa de períodos calculada');
      return comparativa;

    } catch (e) {
      _logger.e('Error obteniendo comparativa de períodos: $e');
      return ComparativaPeriodos.vacia();
    }
  }

  /// Obtener resumen de estadísticas avanzadas
  Future<ResumenEstadisticasAvanzadas> obtenerResumenAvanzado({
    int dias = 30,
    String? idioma,
  }) async {
    try {
      final tendenciaIntensidad = await obtenerTendenciaIntensidad(dias: dias, idioma: idioma);
      final distribucionEmociones = await obtenerDistribucionEmociones(dias: dias, idioma: idioma);
      final patronesHorarios = await obtenerPatronesHorarios(dias: dias, idioma: idioma);
      final comparativa = await obtenerComparativaPeriodos(idioma: idioma);

      final resumen = ResumenEstadisticasAvanzadas(
        tendenciaIntensidad: tendenciaIntensidad,
        distribucionEmociones: distribucionEmociones,
        patronesHorarios: patronesHorarios,
        comparativaPeriodos: comparativa,
        fechaGeneracion: DateTime.now(),
        diasAnalisis: dias,
      );

      _logger.i('Resumen avanzado generado correctamente');
      return resumen;

    } catch (e) {
      _logger.e('Error generando resumen avanzado: $e');
      return ResumenEstadisticasAvanzadas.vacio();
    }
  }
}

// Modelos para análisis de datos

class TendenciaIntensidad {
  final DateTime fecha;
  final double intensidadPromedio;
  final int cantidadSelecciones;

  TendenciaIntensidad({
    required this.fecha,
    required this.intensidadPromedio,
    required this.cantidadSelecciones,
  });
}

class DistribucionEmocion {
  final String emocion;
  final int frecuencia;
  final double intensidadPromedio;
  final double porcentaje;

  DistribucionEmocion({
    required this.emocion,
    required this.frecuencia,
    required this.intensidadPromedio,
    required this.porcentaje,
  });
}

class PatronHorario {
  final int hora;
  final double intensidadPromedio;
  final int cantidadSelecciones;

  PatronHorario({
    required this.hora,
    required this.intensidadPromedio,
    required this.cantidadSelecciones,
  });
}

class ResumenPeriodo {
  final int selecciones;
  final double intensidadPromedio;
  final DateTime fechaDesde;
  final DateTime fechaHasta;

  ResumenPeriodo({
    required this.selecciones,
    required this.intensidadPromedio,
    required this.fechaDesde,
    required this.fechaHasta,
  });
}

class ComparativaPeriodos {
  final ResumenPeriodo periodoActual;
  final ResumenPeriodo periodoAnterior;
  final double cambioIntensidad;
  final int cambioFrecuencia;

  ComparativaPeriodos({
    required this.periodoActual,
    required this.periodoAnterior,
    required this.cambioIntensidad,
    required this.cambioFrecuencia,
  });

  factory ComparativaPeriodos.vacia() {
    final ahora = DateTime.now();
    final periodo = ResumenPeriodo(
      selecciones: 0,
      intensidadPromedio: 0.0,
      fechaDesde: ahora,
      fechaHasta: ahora,
    );
    
    return ComparativaPeriodos(
      periodoActual: periodo,
      periodoAnterior: periodo,
      cambioIntensidad: 0.0,
      cambioFrecuencia: 0,
    );
  }
}

class ResumenEstadisticasAvanzadas {
  final List<TendenciaIntensidad> tendenciaIntensidad;
  final List<DistribucionEmocion> distribucionEmociones;
  final List<PatronHorario> patronesHorarios;
  final ComparativaPeriodos comparativaPeriodos;
  final DateTime fechaGeneracion;
  final int diasAnalisis;

  ResumenEstadisticasAvanzadas({
    required this.tendenciaIntensidad,
    required this.distribucionEmociones,
    required this.patronesHorarios,
    required this.comparativaPeriodos,
    required this.fechaGeneracion,
    required this.diasAnalisis,
  });

  factory ResumenEstadisticasAvanzadas.vacio() {
    return ResumenEstadisticasAvanzadas(
      tendenciaIntensidad: [],
      distribucionEmociones: [],
      patronesHorarios: [],
      comparativaPeriodos: ComparativaPeriodos.vacia(),
      fechaGeneracion: DateTime.now(),
      diasAnalisis: 0,
    );
  }
}
