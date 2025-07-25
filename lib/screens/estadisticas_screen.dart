import 'package:flutter/material.dart';
import '../services/hybrid_data_service.dart';
import '../models/circulo_emociones.dart';

class EstadisticasScreen extends StatefulWidget {
  const EstadisticasScreen({super.key});

  @override
  State<EstadisticasScreen> createState() => _EstadisticasScreenState();
}

class _EstadisticasScreenState extends State<EstadisticasScreen> {
  final HybridDataService _dataService = HybridDataService();
  bool _isLoading = true;
  Map<String, dynamic>? _estadisticas;
  List<SeleccionEmocion> _recentSelections = [];
  bool _isOnline = false;

  @override
  void initState() {
    super.initState();
    _cargarEstadisticas();
  }

  Future<void> _cargarEstadisticas() async {
    try {
      final idioma = Localizations.localeOf(context).languageCode;
      
      // Inicializar el servicio híbrido
      await _dataService.initialize();
      _isOnline = _dataService.isOnline;
      
      final estadisticas = await _dataService.obtenerEstadisticas(idioma: idioma);
      final recientes = await _dataService.obtenerSelecciones(
        limit: 10, 
        idioma: idioma
      );

      if (mounted) {
        setState(() {
          _estadisticas = estadisticas;
          _recentSelections = recientes;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error cargando estadísticas: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          // Indicador de conectividad
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _isOnline ? Icons.cloud_done : Icons.cloud_off,
                  color: _isOnline ? Colors.green : Colors.orange,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  _isOnline ? 'Online' : 'Offline',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Resumen general
                  _buildResumenCard(),
                  const SizedBox(height: 16),
                  
                  // Emociones más frecuentes
                  _buildTopEmocionesCard(),
                  const SizedBox(height: 16),
                  
                  // Selecciones recientes
                  _buildSeleccionesRecientesCard(),
                ],
              ),
            ),
    );
  }

  Widget _buildResumenCard() {
    if (_estadisticas == null) return const SizedBox();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumen General',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  'Total Registros',
                  '${_estadisticas!['total_selecciones']}',
                  Icons.analytics,
                  Colors.blue,
                ),
                _buildStatItem(
                  'Este Mes',
                  '${_recentSelections.length}', // Simplificado
                  Icons.calendar_month,
                  Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTopEmocionesCard() {
    if (_estadisticas == null || _estadisticas!['top_emociones'] == null) {
      return const SizedBox();
    }

    final topEmociones = _estadisticas!['top_emociones'] as List;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Emociones Más Frecuentes',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...topEmociones.take(5).map((emocion) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      emocion['descripcion'] ?? 'Desconocida',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: LinearProgressIndicator(
                      value: (emocion['cantidad'] as int) / 
                             (topEmociones.first['cantidad'] as int),
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${emocion['cantidad']}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildSeleccionesRecientesCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selecciones Recientes',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (_recentSelections.isEmpty)
              const Center(
                child: Text('No hay selecciones recientes'),
              )
            else
              ...(_recentSelections.take(5).map((seleccion) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  child: Text(
                    '${seleccion.intensidad}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(seleccion.nombreOriginal),
                subtitle: Text(
                  '${seleccion.fechaSeleccion.day}/${seleccion.fechaSeleccion.month}/${seleccion.fechaSeleccion.year}',
                ),
                trailing: Icon(
                  Icons.favorite,
                  color: _getColorByIntensity(seleccion.intensidad),
                ),
              ))),
          ],
        ),
      ),
    );
  }

  Color _getColorByIntensity(int intensity) {
    if (intensity >= 8) return Colors.red;
    if (intensity >= 6) return Colors.orange;
    if (intensity >= 4) return Colors.yellow;
    return Colors.green;
  }
}
