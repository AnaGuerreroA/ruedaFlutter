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
  final int? idSeleccionado;
  final String nombre;
  final int intensidad;
  final String comentarios;
  final DateTime fechaSeleccion;

  SeleccionEmocion({
    this.idSeleccionado,
    required this.nombre,
    required this.intensidad,
    required this.comentarios,
    DateTime? fechaSeleccion,
  }) : fechaSeleccion = fechaSeleccion ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'idSeleccionado': idSeleccionado,
      'nombre': nombre,
      'intensidad': intensidad,
      'comentarios': comentarios,
      'fechaSeleccion': fechaSeleccion.toIso8601String(),
    };
  }

  factory SeleccionEmocion.fromJson(Map<String, dynamic> json) {
    return SeleccionEmocion(
      idSeleccionado: json['idSeleccionado'],
      nombre: json['nombre'] ?? '',
      intensidad: json['intensidad'] ?? 5,
      comentarios: json['comentarios'] ?? '',
      fechaSeleccion: json['fechaSeleccion'] != null 
          ? DateTime.parse(json['fechaSeleccion'])
          : DateTime.now(),
    );
  }
}
