import 'dart:math' as math;
import '../models/circulo_emociones.dart';

class EmocionesService {
  static final EmocionesService _instance = EmocionesService._internal();
  factory EmocionesService() => _instance;
  EmocionesService._internal();

  // Datos base de emociones según la nueva estructura
  static final List<Map<String, dynamic>> _emocionesRaw = [
    // Nivel 1 - Emociones principales
    {'id': 1, 'descripcion': 'Fearful', 'idNivel': 1},
    {'id': 2, 'descripcion': 'Angry', 'idNivel': 1},
    {'id': 3, 'descripcion': 'Disgusted', 'idNivel': 1},
    {'id': 4, 'descripcion': 'Sad', 'idNivel': 1},
    {'id': 5, 'descripcion': 'Happy', 'idNivel': 1},
    {'id': 6, 'descripcion': 'Surprised', 'idNivel': 1},
    {'id': 7, 'descripcion': 'Bad', 'idNivel': 1},
    
    // Nivel 2 - Emociones secundarias
    {'id': 8, 'descripcion': 'Scared', 'idNivel': 2},
    {'id': 9, 'descripcion': 'Anxious', 'idNivel': 2},
    {'id': 10, 'descripcion': 'Insecure', 'idNivel': 2},
    {'id': 11, 'descripcion': 'Weak', 'idNivel': 2},
    {'id': 12, 'descripcion': 'Rejected', 'idNivel': 2},
    {'id': 13, 'descripcion': 'Threatened', 'idNivel': 2},
    {'id': 14, 'descripcion': 'Let Down', 'idNivel': 2},
    {'id': 15, 'descripcion': 'Humiliated', 'idNivel': 2},
    {'id': 16, 'descripcion': 'Bitter', 'idNivel': 2},
    {'id': 17, 'descripcion': 'Mad', 'idNivel': 2},
    {'id': 18, 'descripcion': 'Aggressive', 'idNivel': 2},
    {'id': 19, 'descripcion': 'Frustrated', 'idNivel': 2},
    {'id': 20, 'descripcion': 'Distant', 'idNivel': 2},
    {'id': 21, 'descripcion': 'Critical', 'idNivel': 2},
    {'id': 22, 'descripcion': 'Disapproving', 'idNivel': 2},
    {'id': 23, 'descripcion': 'Disappointed', 'idNivel': 2},
    {'id': 24, 'descripcion': 'Awful', 'idNivel': 2},
    {'id': 25, 'descripcion': 'Repelled', 'idNivel': 2},
    {'id': 26, 'descripcion': 'Hurt', 'idNivel': 2},
    {'id': 27, 'descripcion': 'Depressed', 'idNivel': 2},
    {'id': 28, 'descripcion': 'Guilty', 'idNivel': 2},
    {'id': 29, 'descripcion': 'Despair', 'idNivel': 2},
    {'id': 30, 'descripcion': 'Vulnerable', 'idNivel': 2},
    {'id': 31, 'descripcion': 'Lonely', 'idNivel': 2},
    {'id': 32, 'descripcion': 'Optimistic', 'idNivel': 2},
    {'id': 33, 'descripcion': 'Trusting', 'idNivel': 2},
    {'id': 34, 'descripcion': 'Peaceful', 'idNivel': 2},
    {'id': 35, 'descripcion': 'Powerful', 'idNivel': 2},
    {'id': 36, 'descripcion': 'Accepted', 'idNivel': 2},
    {'id': 37, 'descripcion': 'Proud', 'idNivel': 2},
    {'id': 38, 'descripcion': 'Interested', 'idNivel': 2},
    {'id': 39, 'descripcion': 'Content', 'idNivel': 2},
    {'id': 40, 'descripcion': 'Playful', 'idNivel': 2},
    {'id': 41, 'descripcion': 'Excited', 'idNivel': 2},
    {'id': 42, 'descripcion': 'Amazed', 'idNivel': 2},
    {'id': 43, 'descripcion': 'Confused', 'idNivel': 2},
    {'id': 44, 'descripcion': 'Startled', 'idNivel': 2},
    {'id': 45, 'descripcion': 'Tired', 'idNivel': 2},
    {'id': 46, 'descripcion': 'Stressed', 'idNivel': 2},
    {'id': 47, 'descripcion': 'Busy', 'idNivel': 2},
    {'id': 48, 'descripcion': 'Bored', 'idNivel': 2},

    // Nivel 3 - Emociones específicas (primera parte)
    {'id': 49, 'descripcion': 'Helpless', 'idNivel': 3},
    {'id': 50, 'descripcion': 'Frightened', 'idNivel': 3},
    {'id': 51, 'descripcion': 'Overwhelmed', 'idNivel': 3},
    {'id': 52, 'descripcion': 'Worried', 'idNivel': 3},
    {'id': 53, 'descripcion': 'Inadequate', 'idNivel': 3},
    {'id': 54, 'descripcion': 'Inferior', 'idNivel': 3},
    {'id': 55, 'descripcion': 'Worthless', 'idNivel': 3},
    {'id': 56, 'descripcion': 'Insignificant', 'idNivel': 3},
    {'id': 57, 'descripcion': 'Excluded', 'idNivel': 3},
    {'id': 58, 'descripcion': 'Persecuted', 'idNivel': 3},
    {'id': 59, 'descripcion': 'Nervous', 'idNivel': 3},
    {'id': 60, 'descripcion': 'Exposed', 'idNivel': 3},
    {'id': 61, 'descripcion': 'Betrayed', 'idNivel': 3},
    {'id': 62, 'descripcion': 'Resentful', 'idNivel': 3},
    {'id': 63, 'descripcion': 'Disrespected', 'idNivel': 3},
    {'id': 64, 'descripcion': 'Ridiculed', 'idNivel': 3},
    {'id': 65, 'descripcion': 'Indignant', 'idNivel': 3},
    {'id': 66, 'descripcion': 'Violated', 'idNivel': 3},
    {'id': 67, 'descripcion': 'Furious', 'idNivel': 3},
    {'id': 68, 'descripcion': 'Jealous', 'idNivel': 3},
    {'id': 69, 'descripcion': 'Provoked', 'idNivel': 3},
    {'id': 70, 'descripcion': 'Hostile', 'idNivel': 3},
    {'id': 71, 'descripcion': 'Infuriated', 'idNivel': 3},
    {'id': 72, 'descripcion': 'Annoyed', 'idNivel': 3},
    {'id': 73, 'descripcion': 'Withdrawn', 'idNivel': 3},
    {'id': 74, 'descripcion': 'Numb', 'idNivel': 3},
    {'id': 75, 'descripcion': 'Sceptical', 'idNivel': 3},
    {'id': 76, 'descripcion': 'Dismissive', 'idNivel': 3},
    {'id': 77, 'descripcion': 'Judgmental', 'idNivel': 3},
    {'id': 78, 'descripcion': 'Embarrassed', 'idNivel': 3},
    {'id': 79, 'descripcion': 'Appalled', 'idNivel': 3},
    {'id': 80, 'descripcion': 'Revolted', 'idNivel': 3},
    {'id': 81, 'descripcion': 'Nauseated', 'idNivel': 3},
    {'id': 82, 'descripcion': 'Detestable', 'idNivel': 3},
    {'id': 83, 'descripcion': 'Horrified', 'idNivel': 3},
    {'id': 84, 'descripcion': 'Hesitant', 'idNivel': 3},
    {'id': 85, 'descripcion': 'Embarrassed', 'idNivel': 3},
    {'id': 86, 'descripcion': 'Disappointed', 'idNivel': 3},
    {'id': 87, 'descripcion': 'Inferior', 'idNivel': 3},
    {'id': 88, 'descripcion': 'Empty', 'idNivel': 3},
    {'id': 89, 'descripcion': 'Remorseful', 'idNivel': 3},
    {'id': 90, 'descripcion': 'Ashamed', 'idNivel': 3},
    {'id': 91, 'descripcion': 'Powerless', 'idNivel': 3},
    {'id': 92, 'descripcion': 'Grief', 'idNivel': 3},
    {'id': 93, 'descripcion': 'Fragile', 'idNivel': 3},
    {'id': 94, 'descripcion': 'Victimised', 'idNivel': 3},
    {'id': 95, 'descripcion': 'Abandoned', 'idNivel': 3},
    {'id': 96, 'descripcion': 'Isolated', 'idNivel': 3},
    {'id': 97, 'descripcion': 'Inspired', 'idNivel': 3},
    {'id': 98, 'descripcion': 'Hopeful', 'idNivel': 3},
    {'id': 99, 'descripcion': 'Intimate', 'idNivel': 3},
    {'id': 100, 'descripcion': 'Sensitive', 'idNivel': 3},
    {'id': 101, 'descripcion': 'Thankful', 'idNivel': 3},
    {'id': 102, 'descripcion': 'Loving', 'idNivel': 3},
    {'id': 103, 'descripcion': 'Creative', 'idNivel': 3},
    {'id': 104, 'descripcion': 'Courageous', 'idNivel': 3},
    {'id': 105, 'descripcion': 'Valued', 'idNivel': 3},
    {'id': 106, 'descripcion': 'Respected', 'idNivel': 3},
    {'id': 107, 'descripcion': 'Confident', 'idNivel': 3},
    {'id': 108, 'descripcion': 'Successful', 'idNivel': 3},
    {'id': 109, 'descripcion': 'Inquisitive', 'idNivel': 3},
    {'id': 110, 'descripcion': 'Curious', 'idNivel': 3},
    {'id': 111, 'descripcion': 'Joyful', 'idNivel': 3},
    {'id': 112, 'descripcion': 'Free', 'idNivel': 3},
    {'id': 113, 'descripcion': 'Cheeky', 'idNivel': 3},
    {'id': 114, 'descripcion': 'Aroused', 'idNivel': 3},
    {'id': 115, 'descripcion': 'Energetic', 'idNivel': 3},
    {'id': 116, 'descripcion': 'Eager', 'idNivel': 3},
    {'id': 117, 'descripcion': 'Awe', 'idNivel': 3},
    {'id': 118, 'descripcion': 'Astonished', 'idNivel': 3},
    {'id': 119, 'descripcion': 'Perplex', 'idNivel': 3},
    {'id': 120, 'descripcion': 'Disillusioned', 'idNivel': 3},
    {'id': 121, 'descripcion': 'Dismayed', 'idNivel': 3},
    {'id': 122, 'descripcion': 'Shocked', 'idNivel': 3},
    {'id': 123, 'descripcion': 'Unfocussed', 'idNivel': 3},
    {'id': 124, 'descripcion': 'Sleepy', 'idNivel': 3},
    {'id': 125, 'descripcion': 'Out of control', 'idNivel': 3},
    {'id': 126, 'descripcion': 'Overwhelmed', 'idNivel': 3},
    {'id': 127, 'descripcion': 'Rushed', 'idNivel': 3},
    {'id': 128, 'descripcion': 'Pressured', 'idNivel': 3},
    {'id': 129, 'descripcion': 'Apathetic', 'idNivel': 3},
    {'id': 130, 'descripcion': 'Indifferent', 'idNivel': 3},
  ];

  // Relaciones padre-hijo según la tabla de relaciones
  static final Map<int, List<int>> _relaciones = {
    1: [8, 9, 10, 11, 12, 13],        // Fearful -> Scared, Anxious, Insecure, Weak, Rejected, Threatened
    2: [14, 15, 16, 17, 18, 19, 20, 21], // Angry -> Let Down, Humiliated, Bitter, Mad, Aggressive, Frustrated, Distant, Critical
    3: [22, 23, 24, 25],              // Disgusted -> Disapproving, Disappointed, Awful, Repelled
    4: [26, 27, 28, 29, 30, 31],      // Sad -> Hurt, Depressed, Guilty, Despair, Vulnerable, Lonely
    5: [32, 33, 34, 35, 36, 37, 38, 39, 40], // Happy -> Optimistic, Trusting, Peaceful, Powerful, Accepted, Proud, Interested, Content, Playful
    6: [41, 42, 43, 44],              // Surprised -> Excited, Amazed, Confused, Startled
    7: [45, 46, 47, 48],              // Bad -> Tired, Stressed, Busy, Bored
    8: [49, 50], 9: [51, 52], 10: [53, 54], 11: [55, 56], 12: [57, 58], 13: [59, 60],
    14: [61, 62], 15: [63, 64], 16: [65, 66], 17: [67, 68], 18: [69, 70], 19: [71, 72],
    20: [73, 74], 21: [75, 76], 22: [77, 78], 23: [79, 80], 24: [81, 82], 25: [83, 84],
    26: [85, 86], 27: [87, 88], 28: [89, 90], 29: [91, 92], 30: [93, 94], 31: [95, 96],
    32: [97, 98], 33: [99, 100], 34: [101, 102], 35: [103, 104], 36: [105, 106], 37: [107, 108],
    38: [109, 110], 39: [111, 112], 40: [113, 114], 41: [115, 116], 42: [117, 118], 43: [119, 120],
    44: [121, 122], 45: [123, 124], 46: [125, 126], 47: [127, 128], 48: [129, 130],
  };

  // Construir la estructura jerárquica
  List<CirculoEmociones> get emocionesData {
    final Map<int, Map<String, dynamic>> emocionesMap = {};
    
    // Crear mapa de emociones por ID
    for (final emocion in _emocionesRaw) {
      emocionesMap[emocion['id']] = Map<String, dynamic>.from(emocion);
      emocionesMap[emocion['id']]!['children'] = <Map<String, dynamic>>[];
    }
    
    // Construir relaciones padre-hijo
    _relaciones.forEach((padreId, hijosIds) {
      if (emocionesMap.containsKey(padreId)) {
        for (final hijoId in hijosIds) {
          if (emocionesMap.containsKey(hijoId)) {
            emocionesMap[padreId]!['children'].add(emocionesMap[hijoId]!);
          }
        }
      }
    });
    
    // Devolver solo las emociones de nivel 1 (raíces)
    return _emocionesRaw
        .where((e) => e['idNivel'] == 1)
        .map((e) => CirculoEmociones.fromJson(emocionesMap[e['id']]!))
        .toList();
  }

  // Simular guardado de selección
  Future<Map<String, dynamic>> guardarSeleccion(SeleccionEmocion seleccion) async {
    // Simular latencia de red
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Simular éxito (en una app real, aquí harías la llamada HTTP)
    final random = math.Random();
    final exito = random.nextDouble() > 0.1; // 90% de éxito
    
    if (exito) {
      return {
        'success': true,
        'mensaje': 'Emoción "${seleccion.nombre}" registrada correctamente con intensidad ${seleccion.intensidad}/10'
      };
    } else {
      return {
        'success': false,
        'mensaje': 'Error al guardar la emoción'
      };
    }
  }

  // Obtener colores para las emociones basado en su tipo
  static Map<String, int> getColorForEmotion(String emotionName) {
    final lowerName = emotionName.toLowerCase();
    
    if (lowerName.contains('happy') || lowerName.contains('optimistic') || lowerName.contains('trusting') || 
        lowerName.contains('peaceful') || lowerName.contains('powerful') || lowerName.contains('accepted') ||
        lowerName.contains('proud') || lowerName.contains('content') || lowerName.contains('playful') ||
        lowerName.contains('inspired') || lowerName.contains('hopeful') || lowerName.contains('loving') ||
        lowerName.contains('creative') || lowerName.contains('confident') || lowerName.contains('joyful') ||
        lowerName.contains('free') || lowerName.contains('energetic') || lowerName.contains('successful')) {
      return {'r': 255, 'g': 193, 'b': 7}; // Amarillo/Dorado para emociones positivas
    } else if (lowerName.contains('sad') || lowerName.contains('hurt') || lowerName.contains('depressed') || 
               lowerName.contains('guilty') || lowerName.contains('despair') || lowerName.contains('vulnerable') ||
               lowerName.contains('lonely') || lowerName.contains('empty') || lowerName.contains('grief') ||
               lowerName.contains('abandoned') || lowerName.contains('isolated') || lowerName.contains('fragile')) {
      return {'r': 52, 'g': 152, 'b': 219}; // Azul para tristeza
    } else if (lowerName.contains('fearful') || lowerName.contains('scared') || lowerName.contains('anxious') || 
               lowerName.contains('insecure') || lowerName.contains('weak') || lowerName.contains('threatened') ||
               lowerName.contains('helpless') || lowerName.contains('frightened') || lowerName.contains('overwhelmed') ||
               lowerName.contains('worried') || lowerName.contains('nervous') || lowerName.contains('inadequate')) {
      return {'r': 155, 'g': 89, 'b': 182}; // Púrpura para miedo
    } else if (lowerName.contains('angry') || lowerName.contains('mad') || lowerName.contains('aggressive') || 
               lowerName.contains('frustrated') || lowerName.contains('bitter') || lowerName.contains('furious') ||
               lowerName.contains('jealous') || lowerName.contains('hostile') || lowerName.contains('infuriated') ||
               lowerName.contains('annoyed') || lowerName.contains('indignant') || lowerName.contains('humiliated')) {
      return {'r': 231, 'g': 76, 'b': 60}; // Rojo para ira
    } else if (lowerName.contains('disgusted') || lowerName.contains('disapproving') || lowerName.contains('awful') ||
               lowerName.contains('repelled') || lowerName.contains('appalled') || lowerName.contains('revolted') ||
               lowerName.contains('nauseated') || lowerName.contains('horrified') || lowerName.contains('detestable')) {
      return {'r': 46, 'g': 125, 'b': 50}; // Verde para disgusto
    } else if (lowerName.contains('surprised') || lowerName.contains('excited') || lowerName.contains('amazed') ||
               lowerName.contains('confused') || lowerName.contains('startled') || lowerName.contains('astonished') ||
               lowerName.contains('shocked') || lowerName.contains('dismayed') || lowerName.contains('perplex')) {
      return {'r': 255, 'g': 152, 'b': 0}; // Naranja para sorpresa
    } else {
      return {'r': 149, 'g': 165, 'b': 166}; // Gris para estados neutros o no clasificados
    }
  }
}
