// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Emotion Wheel';

  @override
  String get emotionCircle => 'Emotion Circle';

  @override
  String get selectedEmotion => 'Selected emotion:';

  @override
  String get selectedEmotionNone => 'None';

  @override
  String intensity(int intensity) {
    return 'Intensity (1 to 10): $intensity';
  }

  @override
  String get intensityLabel => 'Intensity';

  @override
  String get comments => 'Comments';

  @override
  String get commentsHint => 'Write your comments here...';

  @override
  String get saveEmotion => 'Save Emotion';

  @override
  String get saving => 'Saving...';

  @override
  String get backToPrevious => 'Back to Previous Level';

  @override
  String get backToMain => 'Back to Main Emotions';

  @override
  String backTo(String emotion) {
    return 'Back to $emotion';
  }

  @override
  String level(int current, int total) {
    return 'Level $current of $total';
  }

  @override
  String get mainEmotions => 'Main Emotions';

  @override
  String get selectMoreSpecific => 'Select a more specific emotion to continue';

  @override
  String get emotionSavedSuccess => 'Emotion saved successfully';

  @override
  String get emotionSavedError => 'Error saving emotion';

  @override
  String get networkError => 'Network error: Could not connect to server';

  @override
  String get changeLanguage => 'Change language';

  @override
  String get fearful => 'Fearful';

  @override
  String get angry => 'Angry';

  @override
  String get disgusted => 'Disgusted';

  @override
  String get sad => 'Sad';

  @override
  String get happy => 'Happy';

  @override
  String get surprised => 'Surprised';

  @override
  String get bad => 'Bad';

  @override
  String get scared => 'Scared';

  @override
  String get anxious => 'Anxious';

  @override
  String get insecure => 'Insecure';

  @override
  String get weak => 'Weak';

  @override
  String get rejected => 'Rejected';

  @override
  String get threatened => 'Threatened';

  @override
  String get letDown => 'Let Down';

  @override
  String get humiliated => 'Humiliated';

  @override
  String get bitter => 'Bitter';

  @override
  String get mad => 'Mad';

  @override
  String get aggressive => 'Aggressive';

  @override
  String get frustrated => 'Frustrated';

  @override
  String get distant => 'Distant';

  @override
  String get critical => 'Critical';

  @override
  String get disapproving => 'Disapproving';

  @override
  String get disappointed => 'Disappointed';

  @override
  String get awful => 'Awful';

  @override
  String get repelled => 'Repelled';

  @override
  String get hurt => 'Hurt';

  @override
  String get depressed => 'Depressed';

  @override
  String get guilty => 'Guilty';

  @override
  String get despair => 'Despair';

  @override
  String get vulnerable => 'Vulnerable';

  @override
  String get lonely => 'Lonely';

  @override
  String get optimistic => 'Optimistic';

  @override
  String get trusting => 'Trusting';

  @override
  String get peaceful => 'Peaceful';

  @override
  String get powerful => 'Powerful';

  @override
  String get accepted => 'Accepted';

  @override
  String get proud => 'Proud';

  @override
  String get interested => 'Interested';

  @override
  String get content => 'Content';

  @override
  String get playful => 'Playful';

  @override
  String get excited => 'Excited';

  @override
  String get amazed => 'Amazed';

  @override
  String get confused => 'Confused';

  @override
  String get startled => 'Startled';

  @override
  String get tired => 'Tired';

  @override
  String get stressed => 'Stressed';

  @override
  String get busy => 'Busy';

  @override
  String get bored => 'Bored';

  @override
  String get helpless => 'Helpless';

  @override
  String get frightened => 'Frightened';

  @override
  String get overwhelmed => 'Overwhelmed';

  @override
  String get worried => 'Worried';

  @override
  String get inadequate => 'Inadequate';

  @override
  String get inferior => 'Inferior';

  @override
  String get worthless => 'Worthless';

  @override
  String get insignificant => 'Insignificant';

  @override
  String get excluded => 'Excluded';

  @override
  String get persecuted => 'Persecuted';

  @override
  String get nervous => 'Nervous';

  @override
  String get exposed => 'Exposed';

  @override
  String get betrayed => 'Betrayed';

  @override
  String get resentful => 'Resentful';

  @override
  String get disrespected => 'Disrespected';

  @override
  String get ridiculed => 'Ridiculed';

  @override
  String get indignant => 'Indignant';

  @override
  String get violated => 'Violated';

  @override
  String get furious => 'Furious';

  @override
  String get jealous => 'Jealous';

  @override
  String get provoked => 'Provoked';

  @override
  String get hostile => 'Hostile';

  @override
  String get infuriated => 'Infuriated';

  @override
  String get annoyed => 'Annoyed';

  @override
  String get withdrawn => 'Withdrawn';

  @override
  String get numb => 'Numb';

  @override
  String get sceptical => 'Sceptical';

  @override
  String get dismissive => 'Dismissive';

  @override
  String get judgmental => 'Judgmental';

  @override
  String get embarrassed => 'Embarrassed';

  @override
  String get appalled => 'Appalled';

  @override
  String get revolted => 'Revolted';

  @override
  String get nauseated => 'Nauseated';

  @override
  String get detestable => 'Detestable';

  @override
  String get horrified => 'Horrified';

  @override
  String get hesitant => 'Hesitant';

  @override
  String get empty => 'Empty';

  @override
  String get remorseful => 'Remorseful';

  @override
  String get ashamed => 'Ashamed';

  @override
  String get powerless => 'Powerless';

  @override
  String get grief => 'Grief';

  @override
  String get fragile => 'Fragile';

  @override
  String get victimised => 'Victimised';

  @override
  String get abandoned => 'Abandoned';

  @override
  String get isolated => 'Isolated';

  @override
  String get inspired => 'Inspired';

  @override
  String get hopeful => 'Hopeful';

  @override
  String get intimate => 'Intimate';

  @override
  String get sensitive => 'Sensitive';

  @override
  String get thankful => 'Thankful';

  @override
  String get loving => 'Loving';

  @override
  String get creative => 'Creative';

  @override
  String get courageous => 'Courageous';

  @override
  String get valued => 'Valued';

  @override
  String get respected => 'Respected';

  @override
  String get confident => 'Confident';

  @override
  String get successful => 'Successful';

  @override
  String get inquisitive => 'Inquisitive';

  @override
  String get curious => 'Curious';

  @override
  String get joyful => 'Joyful';

  @override
  String get free => 'Free';

  @override
  String get cheeky => 'Cheeky';

  @override
  String get aroused => 'Aroused';

  @override
  String get energetic => 'Energetic';

  @override
  String get eager => 'Eager';

  @override
  String get awe => 'Awe';

  @override
  String get astonished => 'Astonished';

  @override
  String get perplex => 'Perplex';

  @override
  String get disillusioned => 'Disillusioned';

  @override
  String get dismayed => 'Dismayed';

  @override
  String get shocked => 'Shocked';

  @override
  String get unfocussed => 'Unfocussed';

  @override
  String get sleepy => 'Sleepy';

  @override
  String get outOfControl => 'Out of control';

  @override
  String get rushed => 'Rushed';

  @override
  String get pressured => 'Pressured';

  @override
  String get apathetic => 'Apathetic';

  @override
  String get indifferent => 'Indifferent';

  @override
  String get reports => 'Reports';

  @override
  String get statistics => 'Statistics';

  @override
  String get lastWeek => 'Last week';

  @override
  String get lastMonth => 'Last month';

  @override
  String get trends => 'Trends';

  @override
  String get distribution => 'Distribution';

  @override
  String get patterns => 'Patterns';

  @override
  String get compare => 'Compare';
}
