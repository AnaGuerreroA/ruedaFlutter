import 'dart:async';

// Servicio de ejemplo para manejar datos
class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  // Simulación de una base de datos en memoria
  final List<Map<String, dynamic>> _database = [];

  // Método para obtener todos los elementos
  Future<List<Map<String, dynamic>>> getAll() async {
    // Simular latencia de red
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_database);
  }

  // Método para obtener un elemento por ID
  Future<Map<String, dynamic>?> getById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _database.firstWhere((item) => item['id'] == id);
    } catch (e) {
      return null;
    }
  }

  // Método para crear un nuevo elemento
  Future<Map<String, dynamic>> create(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final newItem = {
      ...data,
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'createdAt': DateTime.now().toIso8601String(),
    };
    _database.add(newItem);
    return newItem;
  }

  // Método para actualizar un elemento
  Future<Map<String, dynamic>?> update(String id, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final index = _database.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      _database[index] = {
        ..._database[index],
        ...data,
        'updatedAt': DateTime.now().toIso8601String(),
      };
      return _database[index];
    }
    return null;
  }

  // Método para eliminar un elemento
  Future<bool> delete(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _database.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      _database.removeAt(index);
      return true;
    }
    return false;
  }

  // Método para limpiar todos los datos
  Future<void> clear() async {
    _database.clear();
  }
}
