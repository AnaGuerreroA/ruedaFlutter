import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/circulo_emociones.dart';
import 'hybrid_data_service.dart';

class EmocionesService {
  static final EmocionesService _instance = EmocionesService._internal();
  factory EmocionesService() => _instance;
  EmocionesService._internal();

  // Función para convertir nombres de emociones a camelCase para localizaciones
  String _emotionToCamelCase(String emotion) {
    // Lista de casos especiales
    final Map<String, String> specialCases = {
      'Let Down': 'letDown',
      'Out of control': 'outOfControl',
    };
    
    if (specialCases.containsKey(emotion)) {
      return specialCases[emotion]!;
    }
    
    // Convertir primera letra a minúscula
    return emotion[0].toLowerCase() + emotion.substring(1);
  }

  // Función para obtener la traducción de una emoción
  String getTranslatedEmotion(String emotion, BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final camelCaseKey = _emotionToCamelCase(emotion);
    
    // Usar reflexión para obtener la traducción
    try {
      switch (camelCaseKey) {
        case 'fearful': return localizations.fearful;
        case 'angry': return localizations.angry;
        case 'disgusted': return localizations.disgusted;
        case 'sad': return localizations.sad;
        case 'happy': return localizations.happy;
        case 'surprised': return localizations.surprised;
        case 'bad': return localizations.bad;
        case 'scared': return localizations.scared;
        case 'anxious': return localizations.anxious;
        case 'insecure': return localizations.insecure;
        case 'weak': return localizations.weak;
        case 'rejected': return localizations.rejected;
        case 'threatened': return localizations.threatened;
        case 'letDown': return localizations.letDown;
        case 'humiliated': return localizations.humiliated;
        case 'bitter': return localizations.bitter;
        case 'mad': return localizations.mad;
        case 'aggressive': return localizations.aggressive;
        case 'frustrated': return localizations.frustrated;
        case 'distant': return localizations.distant;
        case 'critical': return localizations.critical;
        case 'disapproving': return localizations.disapproving;
        case 'disappointed': return localizations.disappointed;
        case 'awful': return localizations.awful;
        case 'repelled': return localizations.repelled;
        case 'hurt': return localizations.hurt;
        case 'depressed': return localizations.depressed;
        case 'guilty': return localizations.guilty;
        case 'despair': return localizations.despair;
        case 'vulnerable': return localizations.vulnerable;
        case 'lonely': return localizations.lonely;
        case 'optimistic': return localizations.optimistic;
        case 'trusting': return localizations.trusting;
        case 'peaceful': return localizations.peaceful;
        case 'powerful': return localizations.powerful;
        case 'accepted': return localizations.accepted;
        case 'proud': return localizations.proud;
        case 'interested': return localizations.interested;
        case 'content': return localizations.content;
        case 'playful': return localizations.playful;
        case 'excited': return localizations.excited;
        case 'amazed': return localizations.amazed;
        case 'confused': return localizations.confused;
        case 'startled': return localizations.startled;
        case 'tired': return localizations.tired;
        case 'stressed': return localizations.stressed;
        case 'busy': return localizations.busy;
        case 'bored': return localizations.bored;
        case 'helpless': return localizations.helpless;
        case 'frightened': return localizations.frightened;
        case 'overwhelmed': return localizations.overwhelmed;
        case 'worried': return localizations.worried;
        case 'inadequate': return localizations.inadequate;
        case 'inferior': return localizations.inferior;
        case 'worthless': return localizations.worthless;
        case 'insignificant': return localizations.insignificant;
        case 'excluded': return localizations.excluded;
        case 'persecuted': return localizations.persecuted;
        case 'nervous': return localizations.nervous;
        case 'exposed': return localizations.exposed;
        case 'betrayed': return localizations.betrayed;
        case 'resentful': return localizations.resentful;
        case 'disrespected': return localizations.disrespected;
        case 'ridiculed': return localizations.ridiculed;
        case 'indignant': return localizations.indignant;
        case 'violated': return localizations.violated;
        case 'furious': return localizations.furious;
        case 'jealous': return localizations.jealous;
        case 'provoked': return localizations.provoked;
        case 'hostile': return localizations.hostile;
        case 'infuriated': return localizations.infuriated;
        case 'annoyed': return localizations.annoyed;
        case 'withdrawn': return localizations.withdrawn;
        case 'numb': return localizations.numb;
        case 'sceptical': return localizations.sceptical;
        case 'dismissive': return localizations.dismissive;
        case 'judgmental': return localizations.judgmental;
        case 'embarrassed': return localizations.embarrassed;
        case 'appalled': return localizations.appalled;
        case 'revolted': return localizations.revolted;
        case 'nauseated': return localizations.nauseated;
        case 'detestable': return localizations.detestable;
        case 'horrified': return localizations.horrified;
        case 'hesitant': return localizations.hesitant;
        case 'empty': return localizations.empty;
        case 'remorseful': return localizations.remorseful;
        case 'ashamed': return localizations.ashamed;
        case 'powerless': return localizations.powerless;
        case 'grief': return localizations.grief;
        case 'fragile': return localizations.fragile;
        case 'victimised': return localizations.victimised;
        case 'abandoned': return localizations.abandoned;
        case 'isolated': return localizations.isolated;
        case 'inspired': return localizations.inspired;
        case 'hopeful': return localizations.hopeful;
        case 'intimate': return localizations.intimate;
        case 'sensitive': return localizations.sensitive;
        case 'thankful': return localizations.thankful;
        case 'loving': return localizations.loving;
        case 'creative': return localizations.creative;
        case 'courageous': return localizations.courageous;
        case 'valued': return localizations.valued;
        case 'respected': return localizations.respected;
        case 'confident': return localizations.confident;
        case 'successful': return localizations.successful;
        case 'inquisitive': return localizations.inquisitive;
        case 'curious': return localizations.curious;
        case 'joyful': return localizations.joyful;
        case 'free': return localizations.free;
        case 'cheeky': return localizations.cheeky;
        case 'aroused': return localizations.aroused;
        case 'energetic': return localizations.energetic;
        case 'eager': return localizations.eager;
        case 'awe': return localizations.awe;
        case 'astonished': return localizations.astonished;
        case 'perplex': return localizations.perplex;
        case 'disillusioned': return localizations.disillusioned;
        case 'dismayed': return localizations.dismayed;
        case 'shocked': return localizations.shocked;
        case 'unfocussed': return localizations.unfocussed;
        case 'sleepy': return localizations.sleepy;
        case 'outOfControl': return localizations.outOfControl;
        case 'rushed': return localizations.rushed;
        case 'pressured': return localizations.pressured;
        case 'apathetic': return localizations.apathetic;
        case 'indifferent': return localizations.indifferent;
        default: return emotion; // Fallback al nombre original
      }
    } catch (e) {
      return emotion; // Fallback al nombre original en caso de error
    }
  }

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
    try {
      // Usar el servicio híbrido que maneja SQLite + API
      final hybridService = HybridDataService();
      return await hybridService.guardarSeleccionEmocion(seleccion);
    } catch (e) {
      return {
        'success': false,
        'mensaje': 'Error al guardar la emoción: $e'
      };
    }
  }

  // Obtener colores para las emociones basado en su tipo y nivel
  static Map<String, int> getColorForEmotion(String emotionName, {int nivel = 1, int index = 0}) {
    final lowerName = emotionName.toLowerCase();
    
    // Colores base más vibrantes y diversos
    final List<Map<String, int>> coloresBase = [
      {'r': 255, 'g': 87, 'b': 34},   // Rojo vibrante
      {'r': 63, 'g': 81, 'b': 181},   // Índigo
      {'r': 46, 'g': 125, 'b': 50},   // Verde
      {'r': 255, 'g': 152, 'b': 0},   // Naranja
      {'r': 156, 'g': 39, 'b': 176},  // Púrpura
      {'r': 0, 'g': 150, 'b': 136},   // Teal
      {'r': 233, 'g': 30, 'b': 99},   // Rosa
      {'r': 121, 'g': 85, 'b': 72},   // Marrón
      {'r': 96, 'g': 125, 'b': 139},  // Azul gris
      {'r': 255, 'g': 193, 'b': 7},   // Amarillo dorado
      {'r': 76, 'g': 175, 'b': 80},   // Verde claro
      {'r': 244, 'g': 67, 'b': 54},   // Rojo coral
    ];
    
    // Si es específico por tipo de emoción, usar el sistema actual
    if (lowerName.contains('happy') || lowerName.contains('optimistic') || lowerName.contains('trusting') || 
        lowerName.contains('peaceful') || lowerName.contains('powerful') || lowerName.contains('accepted') ||
        lowerName.contains('proud') || lowerName.contains('content') || lowerName.contains('playful') ||
        lowerName.contains('inspired') || lowerName.contains('hopeful') || lowerName.contains('loving') ||
        lowerName.contains('creative') || lowerName.contains('confident') || lowerName.contains('joyful') ||
        lowerName.contains('free') || lowerName.contains('energetic') || lowerName.contains('successful')) {
      // Variaciones de colores cálidos y positivos
      final coloresPositivos = [
        {'r': 255, 'g': 193, 'b': 7},   // Amarillo dorado
        {'r': 255, 'g': 152, 'b': 0},   // Naranja
        {'r': 76, 'g': 175, 'b': 80},   // Verde
        {'r': 255, 'g': 235, 'b': 59},  // Amarillo lima
      ];
      return coloresPositivos[index % coloresPositivos.length];
    } else if (lowerName.contains('sad') || lowerName.contains('hurt') || lowerName.contains('depressed') || 
               lowerName.contains('guilty') || lowerName.contains('despair') || lowerName.contains('vulnerable') ||
               lowerName.contains('lonely') || lowerName.contains('empty') || lowerName.contains('grief') ||
               lowerName.contains('abandoned') || lowerName.contains('isolated') || lowerName.contains('fragile')) {
      // Variaciones de azules
      final coloresTriste = [
        {'r': 52, 'g': 152, 'b': 219},  // Azul
        {'r': 63, 'g': 81, 'b': 181},   // Índigo
        {'r': 96, 'g': 125, 'b': 139},  // Azul gris
        {'r': 103, 'g': 58, 'b': 183},  // Violeta
      ];
      return coloresTriste[index % coloresTriste.length];
    } else if (lowerName.contains('fearful') || lowerName.contains('scared') || lowerName.contains('anxious') || 
               lowerName.contains('insecure') || lowerName.contains('weak') || lowerName.contains('threatened') ||
               lowerName.contains('helpless') || lowerName.contains('frightened') || lowerName.contains('overwhelmed') ||
               lowerName.contains('worried') || lowerName.contains('nervous') || lowerName.contains('inadequate')) {
      // Variaciones de púrpuras y violetas
      final coloresMiedo = [
        {'r': 155, 'g': 89, 'b': 182},  // Púrpura
        {'r': 103, 'g': 58, 'b': 183},  // Violeta
        {'r': 142, 'g': 36, 'b': 170},  // Púrpura oscuro
        {'r': 124, 'g': 77, 'b': 255},  // Azul violeta
      ];
      return coloresMiedo[index % coloresMiedo.length];
    } else if (lowerName.contains('angry') || lowerName.contains('mad') || lowerName.contains('aggressive') || 
               lowerName.contains('frustrated') || lowerName.contains('bitter') || lowerName.contains('furious') ||
               lowerName.contains('jealous') || lowerName.contains('hostile') || lowerName.contains('infuriated') ||
               lowerName.contains('annoyed') || lowerName.contains('indignant') || lowerName.contains('humiliated')) {
      // Variaciones de rojos
      final coloresIra = [
        {'r': 231, 'g': 76, 'b': 60},   // Rojo
        {'r': 255, 'g': 87, 'b': 34},   // Rojo naranja
        {'r': 213, 'g': 0, 'b': 0},     // Rojo oscuro
        {'r': 255, 'g': 61, 'b': 0},    // Rojo brillante
      ];
      return coloresIra[index % coloresIra.length];
    } else if (lowerName.contains('disgusted') || lowerName.contains('disapproving') || lowerName.contains('awful') ||
               lowerName.contains('repelled') || lowerName.contains('appalled') || lowerName.contains('revolted') ||
               lowerName.contains('nauseated') || lowerName.contains('horrified') || lowerName.contains('detestable')) {
      // Variaciones de verdes
      final coloresAversion = [
        {'r': 46, 'g': 125, 'b': 50},   // Verde
        {'r': 76, 'g': 175, 'b': 80},   // Verde claro
        {'r': 129, 'g': 199, 'b': 132}, // Verde suave
        {'r': 67, 'g': 160, 'b': 71},   // Verde medio
      ];
      return coloresAversion[index % coloresAversion.length];
    } else if (lowerName.contains('surprised') || lowerName.contains('excited') || lowerName.contains('amazed') ||
               lowerName.contains('confused') || lowerName.contains('startled') || lowerName.contains('astonished') ||
               lowerName.contains('shocked') || lowerName.contains('dismayed') || lowerName.contains('perplex')) {
      // Variaciones de naranjas y amarillos
      final coloresSorpresa = [
        {'r': 255, 'g': 152, 'b': 0},   // Naranja
        {'r': 255, 'g': 193, 'b': 7},   // Amarillo
        {'r': 255, 'g': 111, 'b': 97},  // Salmón
        {'r': 255, 'g': 167, 'b': 38},  // Ámbar
      ];
      return coloresSorpresa[index % coloresSorpresa.length];
    } else {
      // Para emociones no categorizadas, usar colores base diversos
      return coloresBase[index % coloresBase.length];
    }
  }

  // Obtener descripción corta para emociones de nivel 3
  static String getDescripcionCorta(String emotionName, String languageCode) {
    final lowerName = emotionName.toLowerCase();
    
    // Descripciones actualizadas para emociones específicas
    if (lowerName.contains('helpless')) {
      return languageCode == 'es' 
          ? 'Sensación de ser incapaz de cambiar o controlar una situación. A menudo viene con una sensación de impotencia.'
          : 'A feeling of being unable to change or control a situation. It often comes with a sense of powerlessness.';
    } else if (lowerName.contains('frightened')) {
      return languageCode == 'es'
          ? 'Un miedo intenso en respuesta a una amenaza real o imaginaria. El cuerpo se prepara para escapar o defenderse.'
          : 'An intense fear in response to a real or imagined threat. The body prepares to escape or defend.';
    } else if (lowerName.contains('overwhelmed')) {
      return languageCode == 'es'
          ? 'Sentirse mental o emocionalmente sobrecargado. Todo parece demasiado para manejar a la vez.'
          : 'Feeling mentally or emotionally overloaded. Everything seems too much to handle at once.';
    } else if (lowerName.contains('worried')) {
      return languageCode == 'es'
          ? 'Preocupación persistente sobre posibles resultados negativos. A menudo acompañada de pensamientos repetitivos.'
          : 'Persistent concern about possible negative outcomes. Often accompanied by repetitive thoughts.';
    } else if (lowerName.contains('inadequate')) {
      return languageCode == 'es'
          ? 'Sentir que no se es lo suficientemente bueno para cumplir las expectativas. Puede llevar a dudas sobre uno mismo.'
          : 'Feeling not good enough to meet expectations. Can lead to self-doubt or self-criticism.';
    } else if (lowerName.contains('inferior')) {
      return languageCode == 'es'
          ? 'Creencia de que uno es menos valioso o capaz que otros. Daña la autoestima.'
          : 'A belief that one is less valuable or capable than others. It damages self-esteem.';
    } else if (lowerName.contains('worthless')) {
      return languageCode == 'es'
          ? 'Una profunda sensación de carecer de valor o propósito. A menudo vinculada a la desesperanza.'
          : 'A deep sense of lacking value or purpose. Often linked to hopelessness.';
    } else if (lowerName.contains('insignificant')) {
      return languageCode == 'es'
          ? 'Sentirse sin importancia o desapercibido. Puede surgir en situaciones sociales o de logros.'
          : 'Feeling unimportant or unnoticed. It may arise in social or achievement-based settings.';
    } else if (lowerName.contains('excluded')) {
      return languageCode == 'es'
          ? 'La sensación de ser excluido o no bienvenido. Puede llevar a tristeza o ira.'
          : 'The sense of being left out or unwelcome. Can lead to sadness or anger.';
    } else if (lowerName.contains('persecuted')) {
      return languageCode == 'es'
          ? 'Sentirse injustamente atacado o perseguido. A menudo acompañado de miedo o desconfianza.'
          : 'Feeling unfairly targeted or attacked. Often accompanied by fear or mistrust.';
    } else if (lowerName.contains('nervous')) {
      return languageCode == 'es'
          ? 'Un estado de inquietud antes de algo incierto o estresante. La tensión física es común.'
          : 'A state of restlessness before something uncertain or stressful. Physical tension is common.';
    } else if (lowerName.contains('exposed')) {
      return languageCode == 'es'
          ? 'Sentirse emocionalmente vulnerable o desprotegido. Hay miedo al juicio o al daño.'
          : 'Feeling emotionally vulnerable or unprotected. There is a fear of judgment or harm.';
    } else if (lowerName.contains('betrayed')) {
      return languageCode == 'es'
          ? 'Dolor emocional por la confianza rota. A menudo involucra shock y tristeza.'
          : 'Emotional pain from broken trust. It often involves shock and sadness.';
    } else if (lowerName.contains('resentful')) {
      return languageCode == 'es'
          ? 'Ira persistente por agravios pasados percibidos. Usualmente no expresada pero profundamente sentida.'
          : 'Lingering anger from perceived past wrongs. Usually unexpressed but deeply felt.';
    } else if (lowerName.contains('disrespected')) {
      return languageCode == 'es'
          ? 'Sentirse infravalorado o despreciado. A menudo desencadena frustración o tristeza.'
          : 'Feeling undervalued or dismissed. Often triggers frustration or sadness.';
    } else if (lowerName.contains('ridiculed')) {
      return languageCode == 'es'
          ? 'El dolor de ser burlado o ridiculizado. Daña el sentido de dignidad de uno.'
          : 'The pain of being mocked or made fun of. It harms one\'s sense of dignity.';
    } else if (lowerName.contains('indignant')) {
      return languageCode == 'es'
          ? 'Ira desencadenada por injusticia percibida. Enraizada en valores morales.'
          : 'Anger triggered by perceived injustice. Rooted in moral values.';
    } else if (lowerName.contains('violated')) {
      return languageCode == 'es'
          ? 'Sensación de que los límites personales han sido cruzados. Puede causar profundo malestar emocional.'
          : 'A sense of having one\'s personal boundaries crossed. It can cause deep emotional distress.';
    } else if (lowerName.contains('furious')) {
      return languageCode == 'es'
          ? 'Ira extrema que se siente incontrolable. A menudo resulta de provocación intensa.'
          : 'Extreme anger that feels uncontrollable. Often results from intense provocation.';
    } else if (lowerName.contains('jealous')) {
      return languageCode == 'es'
          ? 'Miedo de perder algo valioso ante alguien más. Puede incluir inseguridad o rivalidad.'
          : 'Fear of losing something valuable to someone else. Can include feelings of insecurity or rivalry.';
    } else if (lowerName.contains('provoked')) {
      return languageCode == 'es'
          ? 'Despertado a la ira por las acciones de alguien más. A menudo se siente repentino e intenso.'
          : 'Aroused to anger by someone else\'s actions. Often feels sudden and intense.';
    } else if (lowerName.contains('hostile')) {
      return languageCode == 'es'
          ? 'Abiertamente agresivo o antagónico. Puede involucrar pensamientos de confrontación o venganza.'
          : 'Openly aggressive or antagonistic. May involve thoughts of confrontation or revenge.';
    } else if (lowerName.contains('infuriated')) {
      return languageCode == 'es'
          ? 'Un estado elevado de rabia. A menudo resulta en tensión física o gritos.'
          : 'A heightened state of rage. Often results in physical tension or shouting.';
    } else if (lowerName.contains('annoyed')) {
      return languageCode == 'es'
          ? 'Irritación leve con alguien o algo. Típicamente de corta duración pero disruptiva.'
          : 'Mild irritation with someone or something. Typically short-lived but disruptive.';
    } else if (lowerName.contains('withdrawn')) {
      return languageCode == 'es'
          ? 'Alejarse emocional o socialmente. A menudo una respuesta al agobio o tristeza.'
          : 'Pulling away emotionally or socially. Often a response to overwhelm or sadness.';
    } else if (lowerName.contains('numb')) {
      return languageCode == 'es'
          ? 'Falta de respuesta emocional. Común en momentos de shock o agotamiento emocional.'
          : 'A lack of emotional response. Common in moments of shock or emotional burnout.';
    } else if (lowerName.contains('sceptical') || lowerName.contains('skeptical')) {
      return languageCode == 'es'
          ? 'Dudoso o cuestionando los motivos o ideas de otros. Refleja falta de confianza.'
          : 'Doubtful or questioning of others\' motives or ideas. Reflects a lack of trust.';
    } else if (lowerName.contains('dismissive')) {
      return languageCode == 'es'
          ? 'Rechazar o minimizar los pensamientos o sentimientos de otros. Puede parecer frío o indiferente.'
          : 'Rejecting or minimizing others\' thoughts or feelings. Can come off as cold or uncaring.';
    } else if (lowerName.contains('judgmental')) {
      return languageCode == 'es'
          ? 'Evaluar críticamente a otros con una postura moral o superior. A menudo refleja insatisfacción interna.'
          : 'Critically evaluating others with a moral or superior stance. Often reflects internal dissatisfaction.';
    } else if (lowerName.contains('embarrassed')) {
      return languageCode == 'es'
          ? 'Autoconciencia incómoda por cometer un error o ser visto negativamente. Puede incluir rubor o retraimiento.'
          : 'Uncomfortable self-awareness from making a mistake or being seen negatively. May include blushing or withdrawal.';
    } else if (lowerName.contains('appalled')) {
      return languageCode == 'es'
          ? 'Sorprendido y consternado por algo ofensivo o perturbador. Puede ser moral o estético.'
          : 'Shocked and dismayed by something offensive or disturbing. Can be moral or aesthetic.';
    } else if (lowerName.contains('revolted')) {
      return languageCode == 'es'
          ? 'Disgusto fuerte o repulsión. Puede ser físico o emocional.'
          : 'Strong disgust or repulsion. May be physical or emotional.';
    } else if (lowerName.contains('nauseated')) {
      return languageCode == 'es'
          ? 'Sentir náuseas en el estómago, a menudo por disgusto o estrés. Puede llevar a síntomas físicos.'
          : 'Feeling sick to the stomach, often from disgust or stress. Can lead to physical symptoms.';
    } else if (lowerName.contains('detestable')) {
      return languageCode == 'es'
          ? 'Desagrado intenso u odio. A menudo dirigido a algo considerado moralmente incorrecto.'
          : 'Intense dislike or hatred. Often directed at something considered morally wrong.';
    } else if (lowerName.contains('horrified')) {
      return languageCode == 'es'
          ? 'Miedo profundo y shock, a menudo en reacción a algo macabro o traumático.'
          : 'Deep fear and shock, often in reaction to something gruesome or traumatic.';
    } else if (lowerName.contains('hesitant')) {
      return languageCode == 'es'
          ? 'Incierto o reacio para actuar. Puede derivar del miedo o falta de confianza.'
          : 'Uncertain or reluctant to act. May stem from fear or lack of confidence.';
    } else if (lowerName.contains('disappointed')) {
      return languageCode == 'es'
          ? 'Tristeza cuando las expectativas no se cumplen. Puede sentirse como una decepción personal.'
          : 'Sadness when expectations are not met. Can feel like a personal letdown.';
    } else if (lowerName.contains('empty')) {
      return languageCode == 'es'
          ? 'Sentirse emocionalmente vacío o desconectado. A menudo vinculado a pérdida o agotamiento.'
          : 'Feeling emotionally hollow or disconnected. Often linked to loss or burnout.';
    } else if (lowerName.contains('remorseful')) {
      return languageCode == 'es'
          ? 'Arrepentimiento profundo por acciones pasadas. Incluye un fuerte deseo de enmendar.'
          : 'Deep regret over past actions. Includes a strong desire to make amends.';
    } else if (lowerName.contains('ashamed')) {
      return languageCode == 'es'
          ? 'Sentirse culpable e indigno debido a las propias acciones. Afecta la autoimagen.'
          : 'Feeling guilty and unworthy due to one\'s actions. It affects one\'s self-image.';
    } else if (lowerName.contains('powerless')) {
      return languageCode == 'es'
          ? 'Sentirse incapaz de afectar los resultados. A menudo relacionado con barreras sistémicas o personales.'
          : 'Feeling incapable of affecting outcomes. Often related to systemic or personal barriers.';
    } else if (lowerName.contains('grief')) {
      return languageCode == 'es'
          ? 'Dolor profundo después de una pérdida. A menudo involucra olas de tristeza y anhelo.'
          : 'Deep sorrow after a loss. Often involves waves of sadness and longing.';
    } else if (lowerName.contains('fragile')) {
      return languageCode == 'es'
          ? 'Emocionalmente delicado o fácil de lastimar. A menudo asociado con vulnerabilidad.'
          : 'Emotionally delicate or easily hurt. Often associated with vulnerability.';
    } else if (lowerName.contains('victimized')) {
      return languageCode == 'es'
          ? 'Sentirse dañado u oprimido por otros. Incluye una sensación de injusticia.'
          : 'Feeling harmed or oppressed by others. Includes a sense of injustice.';
    } else if (lowerName.contains('abandoned')) {
      return languageCode == 'es'
          ? 'El dolor de ser dejado solo o rechazado. Crea miedo de ser poco amable.'
          : 'The pain of being left alone or rejected. Creates fear of being unlovable.';
    } else if (lowerName.contains('isolated')) {
      return languageCode == 'es'
          ? 'Sentirse desconectado de otros emocional o físicamente. A menudo lleva a soledad.'
          : 'Feeling cut off from others emotionally or physically. Often leads to loneliness.';
    } else if (lowerName.contains('inspired')) {
      return languageCode == 'es'
          ? 'Una oleada de motivación o creatividad. A menudo provocada por belleza, ideas o acciones de otros.'
          : 'A surge of motivation or creativity. Often sparked by beauty, ideas, or others\' actions.';
    } else if (lowerName.contains('hopeful')) {
      return languageCode == 'es'
          ? 'Creencia de que las cosas mejorarán. Un sentimiento optimista hacia el futuro.'
          : 'Belief that things will improve. A forward-looking, optimistic feeling.';
    } else if (lowerName.contains('intimate')) {
      return languageCode == 'es'
          ? 'Sentirse cercano y emocionalmente conectado con alguien. Incluye confianza y calidez.'
          : 'Feeling close and emotionally connected to someone. Includes trust and warmth.';
    } else if (lowerName.contains('sensitive')) {
      return languageCode == 'es'
          ? 'Fácilmente afectado por emociones o comportamientos de otros. Puede ser fortaleza o vulnerabilidad.'
          : 'Easily affected by emotions or others\' behaviors. Can be a strength or vulnerability.';
    } else if (lowerName.contains('thankful')) {
      return languageCode == 'es'
          ? 'Gratitud por lo que uno tiene o experimenta. A menudo trae alegría o satisfacción.'
          : 'Gratitude for what one has or experiences. Often brings joy or contentment.';
    } else if (lowerName.contains('loving')) {
      return languageCode == 'es'
          ? 'Afecto profundo y cuidado por otros. A menudo incluye deseo de nutrir y conectar.'
          : 'Deep affection and care for others. Often includes a desire to nurture and connect.';
    } else if (lowerName.contains('creative')) {
      return languageCode == 'es'
          ? 'La capacidad de imaginar o producir ideas originales. A menudo alegre y expresivo.'
          : 'The ability to imagine or produce original ideas. Often joyful and expressive.';
    } else if (lowerName.contains('courageous')) {
      return languageCode == 'es'
          ? 'Actuar a pesar del miedo o riesgo. Involucra fuerza interior.'
          : 'Acting despite fear or risk. Involves inner strength.';
    } else if (lowerName.contains('valued')) {
      return languageCode == 'es'
          ? 'Sentirse apreciado e importante. Aumenta la confianza y pertenencia.'
          : 'Feeling appreciated and important. Boosts confidence and belonging.';
    } else if (lowerName.contains('respected')) {
      return languageCode == 'es'
          ? 'Ser tenido en alta estima por otros. A menudo vinculado al reconocimiento y dignidad.'
          : 'Being held in high regard by others. Often tied to recognition and dignity.';
    } else if (lowerName.contains('confident')) {
      return languageCode == 'es'
          ? 'Creencia en las propias habilidades o decisiones. Ayuda a actuar sin miedo.'
          : 'Belief in one\'s own abilities or decisions. Helps take action without fear.';
    } else if (lowerName.contains('successful')) {
      return languageCode == 'es'
          ? 'Sentirse exitoso después de alcanzar una meta. A menudo vinculado al esfuerzo y reconocimiento.'
          : 'Feeling accomplished after reaching a goal. Often tied to effort and recognition.';
    } else if (lowerName.contains('inquisitive')) {
      return languageCode == 'es'
          ? 'Un fuerte deseo de aprender o entender. Impulsado por la curiosidad.'
          : 'A strong desire to learn or understand. Driven by curiosity.';
    } else if (lowerName.contains('curious')) {
      return languageCode == 'es'
          ? 'Querer explorar nuevas ideas o experiencias. A menudo juguetón o de mente abierta.'
          : 'Wanting to explore new ideas or experiences. Often playful or open-minded.';
    } else if (lowerName.contains('joyful')) {
      return languageCode == 'es'
          ? 'Un fuerte sentimiento de felicidad y deleite. A menudo contagioso.'
          : 'A strong feeling of happiness and delight. Often contagious.';
    } else if (lowerName.contains('free')) {
      return languageCode == 'es'
          ? 'Sentirse sin restricciones y abierto a posibilidades. Incluye sensación de autonomía.'
          : 'Feeling unrestricted and open to possibilities. Includes a sense of autonomy.';
    } else if (lowerName.contains('cheeky')) {
      return languageCode == 'es'
          ? 'Juguetónamente audaz o travieso. Puede ser entrañable o irritante.'
          : 'Playfully bold or mischievous. Can be endearing or irritating.';
    } else if (lowerName.contains('aroused')) {
      return languageCode == 'es'
          ? 'Física o emocionalmente estimulado. Puede relacionarse con excitación, pasión o alerta.'
          : 'Physically or emotionally stimulated. Can relate to excitement, passion, or alertness.';
    } else if (lowerName.contains('energetic')) {
      return languageCode == 'es'
          ? 'Lleno de vitalidad y movimiento. Listo para actuar o participar.'
          : 'Full of vitality and movement. Ready to act or engage.';
    } else if (lowerName.contains('eager')) {
      return languageCode == 'es'
          ? 'Entusiasta y listo para algo. A menudo acompañado de impaciencia.'
          : 'Enthusiastic and ready for something. Often accompanied by impatience.';
    } else if (lowerName.contains('awe')) {
      return languageCode == 'es'
          ? 'Una mezcla de asombro y admiración. Usualmente provocada por algo vasto o hermoso.'
          : 'A mix of wonder and admiration. Usually triggered by something vast or beautiful.';
    } else if (lowerName.contains('astonished')) {
      return languageCode == 'es'
          ? 'Muy sorprendido o asombrado. A menudo deja a uno momentáneamente sin palabras.'
          : 'Greatly surprised or amazed. Often leaves one momentarily speechless.';
    } else if (lowerName.contains('perplexed')) {
      return languageCode == 'es'
          ? 'Confundido o desconcertado. Buscando claridad o respuestas.'
          : 'Confused or puzzled. Seeking clarity or answers.';
    } else if (lowerName.contains('disillusioned')) {
      return languageCode == 'es'
          ? 'Decepcionado después de descubrir que algo no es tan bueno como se creía. Involucra pérdida de confianza.'
          : 'Disappointed after discovering something is not as good as believed. Involves loss of trust or ideals.';
    } else if (lowerName.contains('dismayed')) {
      return languageCode == 'es'
          ? 'Decepción o preocupación repentina. Puede detener la motivación.'
          : 'Sudden disappointment or concern. Can halt motivation.';
    } else if (lowerName.contains('shocked')) {
      return languageCode == 'es'
          ? 'Impacto emocional o físico repentino por noticias inesperadas. A menudo causa congelamiento momentáneo.'
          : 'Sudden emotional or physical jolt from unexpected news. Often causes momentary freeze.';
    } else if (lowerName.contains('unfocussed') || lowerName.contains('unfocused')) {
      return languageCode == 'es'
          ? 'Mentalmente disperso o incapaz de concentrarse. Puede derivar del estrés o fatiga.'
          : 'Mentally scattered or unable to concentrate. May stem from stress or fatigue.';
    } else if (lowerName.contains('sleepy')) {
      return languageCode == 'es'
          ? 'Sentir la necesidad de descansar o dormir. A menudo incluye pensamiento lento y energía reducida.'
          : 'Feeling the urge to rest or sleep. Often includes slowed thinking and reduced energy.';
    } else if (lowerName.contains('out of control')) {
      return languageCode == 'es'
          ? 'Sentimiento de que las cosas están sucediendo más allá de tu capacidad de manejar. Puede causar miedo o pánico.'
          : 'Feeling that things are happening beyond your ability to manage. Can cause fear or panic.';
    } else if (lowerName.contains('rushed')) {
      return languageCode == 'es'
          ? 'Presionado para hacer las cosas rápidamente. A menudo lleva a errores o ansiedad.'
          : 'Pressured to do things quickly. Often leads to mistakes or anxiety.';
    } else if (lowerName.contains('pressured')) {
      return languageCode == 'es'
          ? 'Sentirse obligado o forzado por expectativas. Reduce la sensación de libertad.'
          : 'Feeling obligated or forced by expectations. Reduces a sense of freedom.';
    } else if (lowerName.contains('apathetic')) {
      return languageCode == 'es'
          ? 'Falta de interés o respuesta emocional. Un estado de indiferencia.'
          : 'Lack of interest or emotional response. A state of indifference.';
    } else if (lowerName.contains('indifferent')) {
      return languageCode == 'es'
          ? 'Ni cariñoso ni preocupado. A menudo percibido como emocionalmente desapegado.'
          : 'Neither caring nor concerned. Often perceived as emotionally detached.';
    }
    
    // Descripción por defecto
    return languageCode == 'es'
        ? 'Una emoción compleja que merece ser explorada con cuidado.'
        : 'A complex emotion that deserves to be explored carefully.';
  }
}
