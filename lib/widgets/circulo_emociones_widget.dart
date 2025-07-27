import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/circulo_emociones.dart';
import '../services/emociones_service.dart';

class CirculoEmocionesWidget extends StatefulWidget {
  final List<CirculoEmociones> emociones;
  final Function(CirculoEmociones)? onEmocionSeleccionada;

  const CirculoEmocionesWidget({
    super.key,
    required this.emociones,
    this.onEmocionSeleccionada,
  });

  @override
  State<CirculoEmocionesWidget> createState() => _CirculoEmocionesWidgetState();
}

class _CirculoEmocionesWidgetState extends State<CirculoEmocionesWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  List<SeccionCirculo> _secciones = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Crear una lista de emociones con traducciones
    final emocionesTraducidas = widget.emociones.map((emocion) {
      return CirculoEmociones(
        id: emocion.id,
        descripcion: EmocionesService().getTranslatedEmotion(emocion.descripcion, context),
        idNivel: emocion.idNivel,
        children: emocion.children,
      );
    }).toList();

    return GestureDetector(
      onTapDown: (details) {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final localPosition = renderBox.globalToLocal(details.globalPosition);
        
        // Buscar qué emoción fue tocada
        for (final seccion in _secciones) {
          if (seccion.path.contains(localPosition)) {
            if (widget.onEmocionSeleccionada != null) {
              // Buscar la emoción original usando el id
              final emocionOriginal = widget.emociones.firstWhere((e) => e.id == seccion.emocion.id);
              widget.onEmocionSeleccionada!(emocionOriginal);
            }
            break;
          }
        }
      },
      child: SizedBox(
        width: 400,
        height: 400,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              size: const Size(400, 400),
              painter: CirculoPainter(
                emociones: emocionesTraducidas,
                animation: _animation.value,
                onSeccionesCreated: (secciones) {
                  _secciones = secciones;
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class CirculoPainter extends CustomPainter {
  final List<CirculoEmociones> emociones;
  final double animation;
  final Function(List<SeccionCirculo>)? onSeccionesCreated;
  final List<SeccionCirculo> _secciones = [];

  CirculoPainter({
    required this.emociones,
    required this.animation,
    this.onSeccionesCreated,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 * 0.8;
    
    _secciones.clear();
    
    if (emociones.isEmpty) return;

    final anglePerSection = 2 * math.pi / emociones.length;
    
    for (int i = 0; i < emociones.length; i++) {
      final startAngle = i * anglePerSection - math.pi / 2;
      final endAngle = startAngle + anglePerSection;
      final emocion = emociones[i];
      
      // Obtener color para la emoción con nivel e índice
      final colorData = EmocionesService.getColorForEmotion(emocion.descripcion, nivel: emocion.idNivel, index: i);
      final color = Color.fromRGBO(colorData['r']!, colorData['g']!, colorData['b']!, 1.0);
      
      // Crear el path para la sección
      final path = Path();
      path.moveTo(center.dx, center.dy);
      path.arcTo(
        Rect.fromCircle(center: center, radius: radius * animation),
        startAngle,
        anglePerSection,
        false,
      );
      path.close();
      
      // Dibujar la sección
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      
      canvas.drawPath(path, paint);
      
      // Dibujar el borde
      final borderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      
      canvas.drawPath(path, borderPaint);
      
      // Guardar información de la sección para detección de taps
      _secciones.add(SeccionCirculo(
        path: path,
        emocion: emocion,
        startAngle: startAngle,
        endAngle: endAngle,
        center: center,
        radius: radius * animation,
      ));
      
      // Dibujar el texto
      final middleAngle = startAngle + anglePerSection / 2;
      final textRadius = radius * animation * 0.6;
      final textX = center.dx + math.cos(middleAngle) * textRadius;
      final textY = center.dy + math.sin(middleAngle) * textRadius;
      
      final textPainter = TextPainter(
        text: TextSpan(
          text: emocion.descripcion,
          style: TextStyle(
            color: Colors.white,
            fontSize: _calculateFontSize(emocion.descripcion, anglePerSection),
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: const Offset(1, 1),
                blurRadius: 2,
                color: Colors.black.withValues(alpha: 0.7),
              ),
            ],
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      
      textPainter.layout();
      
      // Centrar el texto
      final textOffset = Offset(
        textX - textPainter.width / 2,
        textY - textPainter.height / 2,
      );
      
      if (animation > 0.5) {
        textPainter.paint(canvas, textOffset);
      }
    }
    
    // Notificar las secciones creadas para detección de taps
    if (onSeccionesCreated != null) {
      onSeccionesCreated!(_secciones);
    }
  }

  double _calculateFontSize(String text, double anglePerSection) {
    // Calcular tamaño de fuente basado en el espacio disponible
    final baseSize = anglePerSection * 50; // Factor de escala
    const maxSize = 16.0;
    const minSize = 10.0;
    
    double fontSize = math.min(baseSize, maxSize);
    if (text.length > 8) {
      fontSize = math.max(fontSize * 0.8, minSize);
    }
    
    return fontSize;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class SeccionCirculo {
  final Path path;
  final CirculoEmociones emocion;
  final double startAngle;
  final double endAngle;
  final Offset center;
  final double radius;

  SeccionCirculo({
    required this.path,
    required this.emocion,
    required this.startAngle,
    required this.endAngle,
    required this.center,
    required this.radius,
  });
}
