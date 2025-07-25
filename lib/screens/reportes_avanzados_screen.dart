import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import '../services/analisis_emocional_service.dart';
import '../services/storage_service.dart';

class ReportesAvanzadosScreen extends StatefulWidget {
  const ReportesAvanzadosScreen({super.key});

  @override
  State<ReportesAvanzadosScreen> createState() => _ReportesAvanzadosScreenState();
}

class _ReportesAvanzadosScreenState extends State<ReportesAvanzadosScreen>
    with TickerProviderStateMixin {
  final AnalisisEmocionalService _analisisService = AnalisisEmocionalService();
  final StorageService _storageService = StorageService();
  
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
    _cargarDatos();
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
            Tab(icon: Icon(Icons.trending_up), text: 'Tendencias'),
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
                        _buildTendenciasTab(),
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

  // Tab 1: Tendencias de Intensidad
  Widget _buildTendenciasTab() {
    final tendencias = _resumen!.tendenciaIntensidad;
    
    if (tendencias.isEmpty) {
      return const Center(child: Text('No hay datos de tendencias disponibles'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Tendencia de Intensidad Emocional'),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 1,
                  verticalInterval: 1,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: tendencias.length / 7,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < tendencias.length) {
                          final fecha = tendencias[index].fecha;
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              DateFormat('dd/MM').format(fecha),
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return Text('${value.toInt()}', 
                            style: const TextStyle(fontSize: 12));
                      },
                      reservedSize: 42,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: const Color(0xff37434d)),
                ),
                minX: 0,
                maxX: tendencias.length.toDouble() - 1,
                minY: 0,
                maxY: 10,
                lineBarsData: [
                  LineChartBarData(
                    spots: tendencias.asMap().entries.map((entry) {
                      return FlSpot(
                        entry.key.toDouble(),
                        entry.value.intensidadPromedio,
                      );
                    }).toList(),
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withValues(alpha: 0.3),
                      ],
                    ),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor.withValues(alpha: 0.3),
                          Theme.of(context).primaryColor.withValues(alpha: 0.1),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildEstadisticasResumen(),
        ],
      ),
    );
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
          SizedBox(
            height: 300,
            child: PieChart(
              PieChartData(
                sections: distribucion.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  final color = _getColorForIndex(index);
                  
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

  Widget _buildEstadisticasResumen() {
    final tendencias = _resumen!.tendenciaIntensidad;
    final intensidadPromedio = tendencias.isEmpty 
        ? 0.0
        : tendencias.map((t) => t.intensidadPromedio).reduce((a, b) => a + b) / tendencias.length;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('Intensidad\nPromedio', intensidadPromedio.toStringAsFixed(1)),
            _buildStatItem('Días\nAnalizados', '${_resumen!.diasAnalisis}'),
            _buildStatItem('Total\nRegistros', '${tendencias.fold(0, (sum, t) => sum + t.cantidadSelecciones)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
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
