import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import '../l10n/app_localizations.dart';
import '../models/circulo_emociones.dart';
import '../services/analisis_emocional_service.dart';
import '../services/storage_service.dart';
import '../services/hybrid_data_service.dart';
import '../services/emociones_service.dart';

class ReportesAvanzadosScreen extends StatefulWidget {
  const ReportesAvanzadosScreen({super.key});

  @override
  State<ReportesAvanzadosScreen> createState() => _ReportesAvanzadosScreenState();
}

class _ReportesAvanzadosScreenState extends State<ReportesAvanzadosScreen>
    with TickerProviderStateMixin {
  final AnalisisEmocionalService _analisisService = AnalisisEmocionalService();
  final StorageService _storageService = StorageService();
  final HybridDataService _dataService = HybridDataService();
  final EmocionesService _emocionesService = EmocionesService();
  final Logger _logger = Logger();
  
  TabController? _tabController;
  ResumenEstadisticasAvanzadas? _resumen;
  bool _isLoading = true;
  String? _error;
  
  int _diasAnalisis = 30;
  String? _idiomaSeleccionado;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _initializeServices();
    _cargarDatos();
  }

  Future<void> _initializeServices() async {
    await _dataService.initialize();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Future<void> _cargarDatos() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final resumen = await _analisisService.obtenerResumenAvanzado(
        dias: _diasAnalisis,
        idioma: _idiomaSeleccionado,
      );
      
      setState(() {
        _resumen = resumen;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _generarDatosPrueba() async {
    try {
      await _storageService.generarDatosPrueba();
      
      // Mostrar snackbar de confirmación
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Datos de prueba generados. Actualizando reportes...'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      
      // Recargar datos
      await _cargarDatos();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generando datos: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.reports), // Necesitaremos agregar esta traducción
        actions: [
          // Selector de período
          PopupMenuButton<int>(
            icon: const Icon(Icons.date_range),
            onSelected: (dias) {
              setState(() {
                _diasAnalisis = dias;
              });
              _cargarDatos();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 7, child: Text('Última semana')),
              const PopupMenuItem(value: 30, child: Text('Último mes')),
              const PopupMenuItem(value: 90, child: Text('Últimos 3 meses')),
              const PopupMenuItem(value: 365, child: Text('Último año')),
            ],
          ),
          // Botón de actualizar
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _cargarDatos,
          ),
          // Botón de datos de prueba
          IconButton(
            icon: const Icon(Icons.science),
            onPressed: _generarDatosPrueba,
            tooltip: 'Generar datos de prueba',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.list_alt), text: 'Registro'),
            Tab(icon: Icon(Icons.pie_chart), text: 'Distribución'),
            Tab(icon: Icon(Icons.schedule), text: 'Patrones'),
            Tab(icon: Icon(Icons.compare), text: 'Comparar'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _buildErrorWidget()
              : _resumen != null
                  ? TabBarView(
                      controller: _tabController,
                      children: [
                        _buildRegistroTab(), // Cambiado de _buildTendenciasTab
                        _buildDistribucionTab(),
                        _buildPatronesTab(),
                        _buildComparativaTab(),
                      ],
                    )
                  : const Center(child: Text('No hay datos disponibles')),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text('Error cargando datos: $_error'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _cargarDatos,
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  // Tab 1: Registro de Emociones
  Widget _buildRegistroTab() {
    return FutureBuilder<List<SeleccionEmocion>>(
      future: _obtenerSeleccionesRecientes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        
        final selecciones = snapshot.data ?? [];
        
        if (selecciones.isEmpty) {
          return const Center(child: Text('No hay emociones registradas'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Registro de Emociones'),
              const SizedBox(height: 8),
              Text(
                'Últimas 50 emociones registradas con sus niveles e intensidad',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const SizedBox(height: 16),
              ...selecciones.map((seleccion) => _buildRegistroEmocionCard(seleccion)),
            ],
          ),
        );
      },
    );
  }

  Future<List<SeleccionEmocion>> _obtenerSeleccionesRecientes() async {
    try {
      final selecciones = await _dataService.obtenerSelecciones(
        limit: 50,
        idioma: _idiomaSeleccionado,
      );
      return selecciones;
    } catch (e) {
      _logger.e('Error obteniendo selecciones recientes: $e');
      return [];
    }
  }

  Widget _buildRegistroEmocionCard(SeleccionEmocion seleccion) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: _buildIntensidadIndicator(seleccion.intensidad),
        title: FutureBuilder<Map<String, String>>(
          future: _obtenerJerarquiaEmocion(seleccion.idEmocion),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final jerarquia = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (jerarquia['nivel1'] != null && jerarquia['nivel1']!.isNotEmpty)
                    Text(
                      '${jerarquia['nivel1']}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w400),
                    ),
                  if (jerarquia['nivel2'] != null && jerarquia['nivel2']!.isNotEmpty)
                    Text(
                      '${jerarquia['nivel2']}',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
                    ),
                  Text(
                    jerarquia['nivel3'] ?? seleccion.nombreOriginal,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              );
            }
            return Text(seleccion.nombreOriginal);
          },
        ),
        subtitle: Row(
          children: [
            Icon(Icons.access_time, size: 12, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              DateFormat('dd/MM/yyyy HH:mm').format(seleccion.fechaSeleccion),
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(width: 16),
            Icon(Icons.speed, size: 12, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              'Intensidad: ${seleccion.intensidad}/10',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        trailing: seleccion.comentarios.isNotEmpty 
            ? const Icon(Icons.comment, size: 16, color: Colors.blue)
            : const Icon(Icons.expand_more, size: 16, color: Colors.grey),
        children: [
          if (seleccion.comentarios.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.comment, size: 16, color: Colors.blue[700]),
                        const SizedBox(width: 4),
                        Text(
                          'Comentario:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold, 
                            fontSize: 12,
                            color: Colors.blue[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      seleccion.comentarios,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIntensidadIndicator(int intensidad) {
    Color color;
    if (intensidad <= 3) {
      color = Colors.green;
    } else if (intensidad <= 6) {
      color = Colors.orange;
    } else {
      color = Colors.red;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$intensidad',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Future<Map<String, String>> _obtenerJerarquiaEmocion(int idEmocion) async {
    try {
      // Obtener todas las emociones desde EmocionesService
      final emociones = _emocionesService.emocionesData;
      
      // Buscar la emoción y construir su jerarquía
      return _construirJerarquia(emociones, idEmocion);
    } catch (e) {
      return {'nivel3': 'Emoción no encontrada'};
    }
  }

  Map<String, String> _construirJerarquia(List<CirculoEmociones> emociones, int idEmocion) {
    Map<String, String> jerarquia = {};
    
    // Función recursiva para buscar la emoción y construir la jerarquía
    bool buscarEmocion(List<CirculoEmociones> lista, String nivelPadre, String nombrePadre) {
      for (final emocion in lista) {
        if (emocion.id == idEmocion) {
          // Encontramos la emoción
          jerarquia['nivel${emocion.idNivel}'] = emocion.descripcion;
          if (nivelPadre.isNotEmpty) {
            jerarquia[nivelPadre] = nombrePadre;
          }
          return true;
        }
        
        // Buscar en los hijos
        if (emocion.children.isNotEmpty) {
          if (buscarEmocion(emocion.children, 'nivel${emocion.idNivel}', emocion.descripcion)) {
            jerarquia['nivel${emocion.idNivel}'] = emocion.descripcion;
            if (nivelPadre.isNotEmpty) {
              jerarquia[nivelPadre] = nombrePadre;
            }
            return true;
          }
        }
      }
      return false;
    }
    
    buscarEmocion(emociones, '', '');
    return jerarquia;
  }

  Future<List<DistribucionEmocion>> _obtenerDistribucionPrimerNivel() async {
    try {
      // Obtener todas las selecciones
      final selecciones = await _dataService.obtenerSelecciones(
        idioma: _idiomaSeleccionado,
      );
      
      if (selecciones.isEmpty) {
        return [];
      }

      // Obtener todas las emociones para mapear a sus categorías de primer nivel
      final emociones = _emocionesService.emocionesData;
      
      // Crear un mapa para contar las selecciones por categoría de primer nivel
      final Map<String, List<int>> seleccionesPorCategoria = {};
      
      for (final seleccion in selecciones) {
        final categoria = _obtenerCategoriaPrimerNivel(emociones, seleccion.idEmocion);
        if (categoria.isNotEmpty) {
          seleccionesPorCategoria.putIfAbsent(categoria, () => []).add(seleccion.intensidad);
        }
      }
      
      // Convertir a lista de DistribucionEmocion
      final List<DistribucionEmocion> distribucion = [];
      seleccionesPorCategoria.forEach((categoria, intensidades) {
        final frecuencia = intensidades.length;
        final intensidadPromedio = intensidades.isEmpty ? 0.0 : intensidades.reduce((a, b) => a + b) / intensidades.length;
        final porcentaje = (frecuencia / selecciones.length) * 100;
        
        distribucion.add(DistribucionEmocion(
          emocion: categoria,
          frecuencia: frecuencia,
          intensidadPromedio: intensidadPromedio,
          porcentaje: porcentaje,
        ));
      });
      
      // Ordenar por frecuencia
      distribucion.sort((a, b) => b.frecuencia.compareTo(a.frecuencia));
      return distribucion;
      
    } catch (e) {
      _logger.e('Error obteniendo distribución primer nivel: $e');
      return [];
    }
  }

  String _obtenerCategoriaPrimerNivel(List<CirculoEmociones> emociones, int idEmocion) {
    // Función recursiva para encontrar la categoría de primer nivel
    String buscarCategoria(List<CirculoEmociones> lista, String categoriaActual) {
      for (final emocion in lista) {
        if (emocion.id == idEmocion) {
          return categoriaActual.isEmpty ? emocion.descripcion : categoriaActual;
        }
        
        // Buscar en los hijos
        if (emocion.children.isNotEmpty) {
          final resultado = buscarCategoria(emocion.children, 
              categoriaActual.isEmpty ? emocion.descripcion : categoriaActual);
          if (resultado.isNotEmpty) {
            return resultado;
          }
        }
      }
      return '';
    }
    
    return buscarCategoria(emociones, '');
  }

  // Tab 2: Distribución de Emociones
  Widget _buildDistribucionTab() {
    final distribucion = _resumen!.distribucionEmociones;
    
    if (distribucion.isEmpty) {
      return const Center(child: Text('No hay datos de distribución disponibles'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Distribución de Emociones'),
          const SizedBox(height: 16),
          
          // Gráfico de primer nivel
          FutureBuilder<List<DistribucionEmocion>>(
            future: _obtenerDistribucionPrimerNivel(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final distribucionNivel1 = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Distribución por Categorías Principales',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 250,
                      child: PieChart(
                        PieChartData(
                          sections: distribucionNivel1.asMap().entries.map((entry) {
                            final index = entry.key;
                            final data = entry.value;
                            final color = _getColorForIndex(index);
                            
                            return PieChartSectionData(
                              color: color,
                              value: data.porcentaje,
                              title: '${data.porcentaje.toStringAsFixed(1)}%',
                              radius: 80,
                              titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          }).toList(),
                          sectionsSpace: 2,
                          centerSpaceRadius: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildLeyendaDistribucion(distribucionNivel1),
                    const SizedBox(height: 32),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
          
          // Gráfico de distribución detallada (actual)
          Text(
            'Distribución Detallada por Emociones Específicas',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 300,
            child: PieChart(
              PieChartData(
                sections: distribucion.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  final color = _getColorForIndex(index + 10); // Offset para colores diferentes
                  
                  return PieChartSectionData(
                    color: color,
                    value: data.porcentaje,
                    title: '${data.porcentaje.toStringAsFixed(1)}%',
                    radius: 100,
                    titleStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
                sectionsSpace: 2,
                centerSpaceRadius: 40,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildLeyendaDistribucion(distribucion),
          const SizedBox(height: 24),
          _buildTopEmociones(distribucion),
        ],
      ),
    );
  }

  // Tab 3: Patrones Horarios
  Widget _buildPatronesTab() {
    final patrones = _resumen!.patronesHorarios;
    
    if (patrones.isEmpty) {
      return const Center(child: Text('No hay datos de patrones disponibles'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Patrones por Hora del Día'),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 10,
                barTouchData: BarTouchData(enabled: true),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final hora = value.toInt();
                        if (hora % 4 == 0) { // Mostrar cada 4 horas
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text('${hora}h', style: const TextStyle(fontSize: 12)),
                          );
                        }
                        return const Text('');
                      },
                      reservedSize: 30,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text('${value.toInt()}', 
                            style: const TextStyle(fontSize: 12));
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: patrones.map((patron) {
                  return BarChartGroupData(
                    x: patron.hora,
                    barRods: [
                      BarChartRodData(
                        toY: patron.intensidadPromedio,
                        color: _getColorForIntensity(patron.intensidadPromedio),
                        width: 8,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildInsightsHorarios(patrones),
        ],
      ),
    );
  }

  // Tab 4: Comparativa de Períodos
  Widget _buildComparativaTab() {
    final comparativa = _resumen!.comparativaPeriodos;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Comparativa de Períodos'),
          const SizedBox(height: 16),
          _buildTarjetasComparativa(comparativa),
          const SizedBox(height: 24),
          _buildGraficoComparativo(comparativa),
        ],
      ),
    );
  }

  // Widgets auxiliares
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildLeyendaDistribucion(List<DistribucionEmocion> distribucion) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Leyenda:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: distribucion.asMap().entries.map((entry) {
            final index = entry.key;
            final data = entry.value;
            final color = _getColorForIndex(index);
            
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(data.emocion),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTopEmociones(List<DistribucionEmocion> distribucion) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Top Emociones', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...distribucion.take(5).map((data) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(flex: 2, child: Text(data.emocion)),
                  Expanded(
                    flex: 3,
                    child: LinearProgressIndicator(
                      value: data.porcentaje / 100,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('${data.frecuencia}'),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightsHorarios(List<PatronHorario> patrones) {
    // Encontrar las horas con mayor y menor intensidad
    final horaMaxima = patrones.reduce((a, b) => 
        a.intensidadPromedio > b.intensidadPromedio ? a : b);
    final horaMinima = patrones.reduce((a, b) => 
        a.intensidadPromedio < b.intensidadPromedio ? a : b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Insights Horarios', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.trending_up, color: Colors.green),
              title: Text('Hora de mayor intensidad: ${horaMaxima.hora}:00h'),
              subtitle: Text('Intensidad promedio: ${horaMaxima.intensidadPromedio.toStringAsFixed(1)}'),
            ),
            ListTile(
              leading: const Icon(Icons.trending_down, color: Colors.orange),
              title: Text('Hora de menor intensidad: ${horaMinima.hora}:00h'),
              subtitle: Text('Intensidad promedio: ${horaMinima.intensidadPromedio.toStringAsFixed(1)}'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTarjetasComparativa(ComparativaPeriodos comparativa) {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('Período Actual', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('${comparativa.periodoActual.selecciones} registros'),
                  Text('Intensidad: ${comparativa.periodoActual.intensidadPromedio.toStringAsFixed(1)}'),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('Período Anterior', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('${comparativa.periodoAnterior.selecciones} registros'),
                  Text('Intensidad: ${comparativa.periodoAnterior.intensidadPromedio.toStringAsFixed(1)}'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGraficoComparativo(ComparativaPeriodos comparativa) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Cambios', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              leading: Icon(
                comparativa.cambioIntensidad >= 0 ? Icons.trending_up : Icons.trending_down,
                color: comparativa.cambioIntensidad >= 0 ? Colors.green : Colors.red,
              ),
              title: Text('Cambio en intensidad: ${comparativa.cambioIntensidad.toStringAsFixed(2)}'),
              subtitle: Text(comparativa.cambioIntensidad >= 0 ? 'Mejora' : 'Disminución'),
            ),
            ListTile(
              leading: Icon(
                comparativa.cambioFrecuencia >= 0 ? Icons.trending_up : Icons.trending_down,
                color: comparativa.cambioFrecuencia >= 0 ? Colors.green : Colors.red,
              ),
              title: Text('Cambio en frecuencia: ${comparativa.cambioFrecuencia}'),
              subtitle: Text(comparativa.cambioFrecuencia >= 0 ? 'Más registros' : 'Menos registros'),
            ),
          ],
        ),
      ),
    );
  }

  // Funciones auxiliares para colores
  Color _getColorForIndex(int index) {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.amber,
      Colors.cyan,
    ];
    return colors[index % colors.length];
  }

  Color _getColorForIntensity(double intensity) {
    if (intensity >= 7) return Colors.red;
    if (intensity >= 5) return Colors.orange;
    if (intensity >= 3) return Colors.yellow;
    return Colors.green;
  }
}
