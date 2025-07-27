// Modelo para representar las emociones en el círculo
class CirculoEmociones {
  final int id;
  final String descripcion;
  final int idNivel;
  final List<CirculoEmociones> children;

  CirculoEmociones({
    required this.id,
    required this.descripcion,
    required this.idNivel,
    this.children = const [],
  });

  factory CirculoEmociones.fromJson(Map<String, dynamic> json) {
    return CirculoEmociones(
      id: json['id'] ?? 0,
      descripcion: json['descripcion'] ?? '',
      idNivel: json['idNivel'] ?? 1,
      children: (json['children'] as List<dynamic>?)
          ?.map((child) => CirculoEmociones.fromJson(child))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descripcion': descripcion,
      'idNivel': idNivel,
      'children': children.map((child) => child.toJson()).toList(),
    };
  }

  bool get esTercerNivel => idNivel == 3;
  bool get tieneHijos => children.isNotEmpty;
  String get name => descripcion; // Mantener compatibilidad con el widget existente
}

// Modelo para la selección de emoción
class SeleccionEmocion {
  final int? id;                  // ID de la selección (auto-increment en BD)
  final int idEmocion;           // ID de la emoción (referencia a tabla emociones)
  final String nombreOriginal;   // Nombre original de la emoción para referencia
  final int intensidad;
  final String comentarios;
  final DateTime fechaSeleccion;
  final String idioma;           // Idioma del usuario ('es', 'en')

  SeleccionEmocion({
    this.id,
    required this.idEmocion,
    required this.nombreOriginal,
    required this.intensidad,
    required this.comentarios,
    DateTime? fechaSeleccion,
    required this.idioma,
  }) : fechaSeleccion = fechaSeleccion ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idEmocion': idEmocion,           // Cambiado a camelCase
      'nombreOriginal': nombreOriginal,  // Cambiado a camelCase
      'intensidad': intensidad,
      'comentarios': comentarios,
      'fechaSeleccion': fechaSeleccion.toIso8601String(), // Cambiado a camelCase
      'idioma': idioma,
    };
  }

  factory SeleccionEmocion.fromJson(Map<String, dynamic> json) {
    return SeleccionEmocion(
      id: json['id'],
      idEmocion: json['idEmocion'] ?? json['id_emocion'] ?? 0, // Soporta ambos formatos
      nombreOriginal: json['nombreOriginal'] ?? json['nombre_original'] ?? '',
      intensidad: json['intensidad'] ?? 5,
      comentarios: json['comentarios'] ?? '',
      fechaSeleccion: json['fechaSeleccion'] != null 
          ? DateTime.parse(json['fechaSeleccion'])
          : (json['fecha_seleccion'] != null 
              ? DateTime.parse(json['fecha_seleccion'])
              : DateTime.now()),
      idioma: json['idioma'] ?? 'es',
    );
  }
}
