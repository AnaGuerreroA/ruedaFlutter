import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/circulo_emociones.dart';
import '../services/emociones_service.dart';
import '../widgets/circulo_emociones_widget.dart';
import '../widgets/language_selector.dart';

class CirculoEmocionesScreen extends StatefulWidget {
  const CirculoEmocionesScreen({super.key});

  @override
  State<CirculoEmocionesScreen> createState() => _CirculoEmocionesScreenState();
}

class _CirculoEmocionesScreenState extends State<CirculoEmocionesScreen> {
  final EmocionesService _emocionesService = EmocionesService();
  final List<CirculoEmociones> _navigationStack = [];
  
  List<CirculoEmociones> _currentEmociones = [];
  CirculoEmociones? _emocionSeleccionada;
  double _intensidad = 5.0;
  final TextEditingController _comentariosController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _currentEmociones = _emocionesService.emocionesData;
  }

  @override
  void dispose() {
    _comentariosController.dispose();
    super.dispose();
  }

  void _onEmocionTapped(CirculoEmociones emocion) {
    if (emocion.tieneHijos) {
      // Navegar al siguiente nivel
      setState(() {
        _navigationStack.add(emocion);
        _currentEmociones = emocion.children;
        _emocionSeleccionada = null; // Limpiar selección al navegar
      });
    } else {
      // Es una emoción del tercer nivel, seleccionarla directamente
      setState(() {
        _emocionSeleccionada = emocion;
      });
    }
  }

  void _goBack() {
    if (_navigationStack.isNotEmpty) {
      setState(() {
        _navigationStack.removeLast();
        if (_navigationStack.isEmpty) {
          _currentEmociones = _emocionesService.emocionesData;
        } else {
          _currentEmociones = _navigationStack.last.children;
        }
        _emocionSeleccionada = null;
      });
    }
  }

  Future<void> _guardarEmocion() async {
    if (_emocionSeleccionada == null) return;

    final localizations = AppLocalizations.of(context)!;

    setState(() {
      _isLoading = true;
    });

    final seleccion = SeleccionEmocion(
      idEmocion: _emocionSeleccionada!.id,
      nombreOriginal: _emocionSeleccionada!.descripcion,
      intensidad: _intensidad.round(),
      comentarios: _comentariosController.text,
      idioma: Localizations.localeOf(context).languageCode,
    );

    try {
      final resultado = await _emocionesService.guardarSeleccion(seleccion);
      
      if (mounted) {
        if (resultado['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(resultado['mensaje'] ?? localizations.emotionSavedSuccess),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );
          
          // Limpiar formulario
          setState(() {
            _emocionSeleccionada = null;
            _intensidad = 5.0;
            _comentariosController.clear();
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(resultado['mensaje'] ?? localizations.emotionSavedError),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(localizations.networkError),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _getTituloNivel() {
    final localizations = AppLocalizations.of(context)!;
    
    if (_navigationStack.isEmpty) {
      return localizations.mainEmotions;
    } else if (_navigationStack.length == 1) {
      return _navigationStack.first.descripcion;
    } else {
      return '${_navigationStack.first.descripcion} > ${_navigationStack.last.descripcion}';
    }
  }

  String _getTextoBotonRetroceso() {
    final localizations = AppLocalizations.of(context)!;
    
    if (_navigationStack.length == 1) {
      return localizations.backToMain;
    } else if (_navigationStack.length == 2) {
      return localizations.backTo(_navigationStack.first.descripcion);
    } else {
      return localizations.backToPrevious;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.emotionCircle),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (_navigationStack.isNotEmpty)
            IconButton(
              onPressed: _goBack,
              icon: const Icon(Icons.arrow_back),
              tooltip: localizations.backToPrevious,
            ),
          const LanguageSelector(),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Título del nivel actual
            Text(
              _getTituloNivel(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            // Indicador de nivel
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 4),
                Text(
                  localizations.level(_navigationStack.length + 1, 3),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Círculo de emociones
            Center(
              child: CirculoEmocionesWidget(
                emociones: _currentEmociones,
                onEmocionSeleccionada: _onEmocionTapped,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Botón de retroceso (solo visible en niveles 2 y 3)
            if (_navigationStack.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _goBack,
                  icon: const Icon(Icons.arrow_back_ios),
                  label: Text(_getTextoBotonRetroceso()),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                    foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
            
            const SizedBox(height: 10),
            
            // Información de la emoción seleccionada
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.selectedEmotion,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _emocionSeleccionada?.descripcion ?? localizations.selectedEmotionNone,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: _emocionSeleccionada != null 
                            ? Theme.of(context).primaryColor 
                            : Colors.grey,
                      ),
                    ),
                    
                    // Mostrar descripción corta para emociones de nivel 3
                    if (_emocionSeleccionada?.esTercerNivel == true) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          EmocionesService.getDescripcionCorta(
                            _emocionSeleccionada!.descripcion,
                            Localizations.localeOf(context).languageCode,
                          ),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: Theme.of(context).primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    
                    if (_emocionSeleccionada?.esTercerNivel == true) ...[
                      const SizedBox(height: 20),
                      
                      // Slider de intensidad
                      Text(
                        localizations.intensity(_intensidad.round()),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Slider(
                        value: _intensidad,
                        min: 1,
                        max: 10,
                        divisions: 9,
                        label: _intensidad.round().toString(),
                        onChanged: (value) {
                          setState(() {
                            _intensidad = value;
                          });
                        },
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Campo de comentarios
                      TextField(
                        controller: _comentariosController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: localizations.comments,
                          hintText: localizations.commentsHint,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Botón guardar
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _guardarEmocion,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: _isLoading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(localizations.saving),
                                  ],
                                )
                              : Text(
                                  localizations.saveEmotion,
                                  style: const TextStyle(fontSize: 16),
                                ),
                        ),
                      ),
                    ] else if (_emocionSeleccionada != null && !_emocionSeleccionada!.esTercerNivel) ...[
                      const SizedBox(height: 10),
                      Text(
                        localizations.selectMoreSpecific,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
