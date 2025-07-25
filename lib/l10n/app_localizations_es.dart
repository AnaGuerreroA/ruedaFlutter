// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Rueda de Emociones';

  @override
  String get emotionCircle => 'Círculo de Emociones';

  @override
  String get selectedEmotion => 'Emoción seleccionada:';

  @override
  String get selectedEmotionNone => 'Ninguna';

  @override
  String intensity(int intensity) {
    return 'Intensidad (1 a 10): $intensity';
  }

  @override
  String get intensityLabel => 'Intensidad';

  @override
  String get comments => 'Comentarios';

  @override
  String get commentsHint => 'Escribe tus comentarios aquí...';

  @override
  String get saveEmotion => 'Guardar Emoción';

  @override
  String get saving => 'Guardando...';

  @override
  String get backToPrevious => 'Volver al Nivel Anterior';

  @override
  String get backToMain => 'Volver a Emociones Principales';

  @override
  String backTo(String emotion) {
    return 'Volver a $emotion';
  }

  @override
  String level(int current, int total) {
    return 'Nivel $current de $total';
  }

  @override
  String get mainEmotions => 'Emociones Principales';

  @override
  String get selectMoreSpecific =>
      'Selecciona una emoción más específica para continuar';

  @override
  String get emotionSavedSuccess => 'Emoción guardada correctamente';

  @override
  String get emotionSavedError => 'Error al guardar la emoción';

  @override
  String get networkError =>
      'Error de red: No se pudo conectar con el servidor';

  @override
  String get changeLanguage => 'Cambiar idioma';

  @override
  String get fearful => 'Miedo';

  @override
  String get angry => 'Enojado';

  @override
  String get disgusted => 'Disgustado';

  @override
  String get sad => 'Triste';

  @override
  String get happy => 'Feliz';

  @override
  String get surprised => 'Sorprendido';

  @override
  String get bad => 'Malo';

  @override
  String get scared => 'Asustado';

  @override
  String get anxious => 'Ansioso';

  @override
  String get insecure => 'Inseguro';

  @override
  String get weak => 'Débil';

  @override
  String get rejected => 'Rechazado';

  @override
  String get threatened => 'Amenazado';

  @override
  String get letDown => 'Decepcionado';

  @override
  String get humiliated => 'Humillado';

  @override
  String get bitter => 'Amargado';

  @override
  String get mad => 'Furioso';

  @override
  String get aggressive => 'Agresivo';

  @override
  String get frustrated => 'Frustrado';

  @override
  String get distant => 'Distante';

  @override
  String get critical => 'Crítico';

  @override
  String get disapproving => 'Desaprobador';

  @override
  String get disappointed => 'Desilusionado';

  @override
  String get awful => 'Horrible';

  @override
  String get repelled => 'Repelido';

  @override
  String get hurt => 'Herido';

  @override
  String get depressed => 'Deprimido';

  @override
  String get guilty => 'Culpable';

  @override
  String get despair => 'Desesperado';

  @override
  String get vulnerable => 'Vulnerable';

  @override
  String get lonely => 'Solitario';

  @override
  String get optimistic => 'Optimista';

  @override
  String get trusting => 'Confiado';

  @override
  String get peaceful => 'Pacífico';

  @override
  String get powerful => 'Poderoso';

  @override
  String get accepted => 'Aceptado';

  @override
  String get proud => 'Orgulloso';

  @override
  String get interested => 'Interesado';

  @override
  String get content => 'Contento';

  @override
  String get playful => 'Juguetón';

  @override
  String get excited => 'Emocionado';

  @override
  String get amazed => 'Sorprendido';

  @override
  String get confused => 'Confundido';

  @override
  String get startled => 'Sobresaltado';

  @override
  String get tired => 'Cansado';

  @override
  String get stressed => 'Estresado';

  @override
  String get busy => 'Ocupado';

  @override
  String get bored => 'Aburrido';

  @override
  String get helpless => 'Indefenso';

  @override
  String get frightened => 'Aterrorizado';

  @override
  String get overwhelmed => 'Abrumado';

  @override
  String get worried => 'Preocupado';

  @override
  String get inadequate => 'Inadecuado';

  @override
  String get inferior => 'Inferior';

  @override
  String get worthless => 'Sin valor';

  @override
  String get insignificant => 'Insignificante';

  @override
  String get excluded => 'Excluido';

  @override
  String get persecuted => 'Perseguido';

  @override
  String get nervous => 'Nervioso';

  @override
  String get exposed => 'Expuesto';

  @override
  String get betrayed => 'Traicionado';

  @override
  String get resentful => 'Resentido';

  @override
  String get disrespected => 'Irrespetado';

  @override
  String get ridiculed => 'Ridiculizado';

  @override
  String get indignant => 'Indignado';

  @override
  String get violated => 'Violado';

  @override
  String get furious => 'Furioso';

  @override
  String get jealous => 'Celoso';

  @override
  String get provoked => 'Provocado';

  @override
  String get hostile => 'Hostil';

  @override
  String get infuriated => 'Enfurecido';

  @override
  String get annoyed => 'Molesto';

  @override
  String get withdrawn => 'Retraído';

  @override
  String get numb => 'Entumecido';

  @override
  String get sceptical => 'Escéptico';

  @override
  String get dismissive => 'Desdeñoso';

  @override
  String get judgmental => 'Juzgador';

  @override
  String get embarrassed => 'Avergonzado';

  @override
  String get appalled => 'Consternado';

  @override
  String get revolted => 'Repugnado';

  @override
  String get nauseated => 'Nauseado';

  @override
  String get detestable => 'Detestable';

  @override
  String get horrified => 'Horrorizado';

  @override
  String get hesitant => 'Vacilante';

  @override
  String get empty => 'Vacío';

  @override
  String get remorseful => 'Arrepentido';

  @override
  String get ashamed => 'Avergonzado';

  @override
  String get powerless => 'Impotente';

  @override
  String get grief => 'Dolor';

  @override
  String get fragile => 'Frágil';

  @override
  String get victimised => 'Victimizado';

  @override
  String get abandoned => 'Abandonado';

  @override
  String get isolated => 'Aislado';

  @override
  String get inspired => 'Inspirado';

  @override
  String get hopeful => 'Esperanzado';

  @override
  String get intimate => 'Íntimo';

  @override
  String get sensitive => 'Sensible';

  @override
  String get thankful => 'Agradecido';

  @override
  String get loving => 'Amoroso';

  @override
  String get creative => 'Creativo';

  @override
  String get courageous => 'Valiente';

  @override
  String get valued => 'Valorado';

  @override
  String get respected => 'Respetado';

  @override
  String get confident => 'Confiado';

  @override
  String get successful => 'Exitoso';

  @override
  String get inquisitive => 'Inquisitivo';

  @override
  String get curious => 'Curioso';

  @override
  String get joyful => 'Alegre';

  @override
  String get free => 'Libre';

  @override
  String get cheeky => 'Travieso';

  @override
  String get aroused => 'Excitado';

  @override
  String get energetic => 'Enérgico';

  @override
  String get eager => 'Ansioso';

  @override
  String get awe => 'Asombro';

  @override
  String get astonished => 'Asombrado';

  @override
  String get perplex => 'Perplejo';

  @override
  String get disillusioned => 'Desilusionado';

  @override
  String get dismayed => 'Consternado';

  @override
  String get shocked => 'Conmocionado';

  @override
  String get unfocussed => 'Desenfocado';

  @override
  String get sleepy => 'Somnoliento';

  @override
  String get outOfControl => 'Fuera de control';

  @override
  String get rushed => 'Apurado';

  @override
  String get pressured => 'Presionado';

  @override
  String get apathetic => 'Apático';

  @override
  String get indifferent => 'Indiferente';

  @override
  String get reports => 'Reportes';

  @override
  String get statistics => 'Estadísticas';

  @override
  String get lastWeek => 'Última semana';

  @override
  String get lastMonth => 'Último mes';

  @override
  String get trends => 'Tendencias';

  @override
  String get distribution => 'Distribución';

  @override
  String get patterns => 'Patrones';

  @override
  String get compare => 'Comparar';
}
