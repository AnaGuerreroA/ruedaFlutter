import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Emotion Wheel'**
  String get appTitle;

  /// No description provided for @emotionCircle.
  ///
  /// In en, this message translates to:
  /// **'Emotion Circle'**
  String get emotionCircle;

  /// No description provided for @selectedEmotion.
  ///
  /// In en, this message translates to:
  /// **'Selected emotion:'**
  String get selectedEmotion;

  /// No description provided for @selectedEmotionNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get selectedEmotionNone;

  /// No description provided for @intensity.
  ///
  /// In en, this message translates to:
  /// **'Intensity (1 to 10): {intensity}'**
  String intensity(int intensity);

  /// No description provided for @intensityLabel.
  ///
  /// In en, this message translates to:
  /// **'Intensity'**
  String get intensityLabel;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @commentsHint.
  ///
  /// In en, this message translates to:
  /// **'Write your comments here...'**
  String get commentsHint;

  /// No description provided for @saveEmotion.
  ///
  /// In en, this message translates to:
  /// **'Save Emotion'**
  String get saveEmotion;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// No description provided for @backToPrevious.
  ///
  /// In en, this message translates to:
  /// **'Back to Previous Level'**
  String get backToPrevious;

  /// No description provided for @backToMain.
  ///
  /// In en, this message translates to:
  /// **'Back to Main Emotions'**
  String get backToMain;

  /// No description provided for @backTo.
  ///
  /// In en, this message translates to:
  /// **'Back to {emotion}'**
  String backTo(String emotion);

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level {current} of {total}'**
  String level(int current, int total);

  /// No description provided for @mainEmotions.
  ///
  /// In en, this message translates to:
  /// **'Main Emotions'**
  String get mainEmotions;

  /// No description provided for @selectMoreSpecific.
  ///
  /// In en, this message translates to:
  /// **'Select a more specific emotion to continue'**
  String get selectMoreSpecific;

  /// No description provided for @emotionSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Emotion saved successfully'**
  String get emotionSavedSuccess;

  /// No description provided for @emotionSavedError.
  ///
  /// In en, this message translates to:
  /// **'Error saving emotion'**
  String get emotionSavedError;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Network error: Could not connect to server'**
  String get networkError;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get changeLanguage;

  /// No description provided for @fearful.
  ///
  /// In en, this message translates to:
  /// **'Fearful'**
  String get fearful;

  /// No description provided for @angry.
  ///
  /// In en, this message translates to:
  /// **'Angry'**
  String get angry;

  /// No description provided for @disgusted.
  ///
  /// In en, this message translates to:
  /// **'Disgusted'**
  String get disgusted;

  /// No description provided for @sad.
  ///
  /// In en, this message translates to:
  /// **'Sad'**
  String get sad;

  /// No description provided for @happy.
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get happy;

  /// No description provided for @surprised.
  ///
  /// In en, this message translates to:
  /// **'Surprised'**
  String get surprised;

  /// No description provided for @bad.
  ///
  /// In en, this message translates to:
  /// **'Bad'**
  String get bad;

  /// No description provided for @scared.
  ///
  /// In en, this message translates to:
  /// **'Scared'**
  String get scared;

  /// No description provided for @anxious.
  ///
  /// In en, this message translates to:
  /// **'Anxious'**
  String get anxious;

  /// No description provided for @insecure.
  ///
  /// In en, this message translates to:
  /// **'Insecure'**
  String get insecure;

  /// No description provided for @weak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get weak;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @threatened.
  ///
  /// In en, this message translates to:
  /// **'Threatened'**
  String get threatened;

  /// No description provided for @letDown.
  ///
  /// In en, this message translates to:
  /// **'Let Down'**
  String get letDown;

  /// No description provided for @humiliated.
  ///
  /// In en, this message translates to:
  /// **'Humiliated'**
  String get humiliated;

  /// No description provided for @bitter.
  ///
  /// In en, this message translates to:
  /// **'Bitter'**
  String get bitter;

  /// No description provided for @mad.
  ///
  /// In en, this message translates to:
  /// **'Mad'**
  String get mad;

  /// No description provided for @aggressive.
  ///
  /// In en, this message translates to:
  /// **'Aggressive'**
  String get aggressive;

  /// No description provided for @frustrated.
  ///
  /// In en, this message translates to:
  /// **'Frustrated'**
  String get frustrated;

  /// No description provided for @distant.
  ///
  /// In en, this message translates to:
  /// **'Distant'**
  String get distant;

  /// No description provided for @critical.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get critical;

  /// No description provided for @disapproving.
  ///
  /// In en, this message translates to:
  /// **'Disapproving'**
  String get disapproving;

  /// No description provided for @disappointed.
  ///
  /// In en, this message translates to:
  /// **'Disappointed'**
  String get disappointed;

  /// No description provided for @awful.
  ///
  /// In en, this message translates to:
  /// **'Awful'**
  String get awful;

  /// No description provided for @repelled.
  ///
  /// In en, this message translates to:
  /// **'Repelled'**
  String get repelled;

  /// No description provided for @hurt.
  ///
  /// In en, this message translates to:
  /// **'Hurt'**
  String get hurt;

  /// No description provided for @depressed.
  ///
  /// In en, this message translates to:
  /// **'Depressed'**
  String get depressed;

  /// No description provided for @guilty.
  ///
  /// In en, this message translates to:
  /// **'Guilty'**
  String get guilty;

  /// No description provided for @despair.
  ///
  /// In en, this message translates to:
  /// **'Despair'**
  String get despair;

  /// No description provided for @vulnerable.
  ///
  /// In en, this message translates to:
  /// **'Vulnerable'**
  String get vulnerable;

  /// No description provided for @lonely.
  ///
  /// In en, this message translates to:
  /// **'Lonely'**
  String get lonely;

  /// No description provided for @optimistic.
  ///
  /// In en, this message translates to:
  /// **'Optimistic'**
  String get optimistic;

  /// No description provided for @trusting.
  ///
  /// In en, this message translates to:
  /// **'Trusting'**
  String get trusting;

  /// No description provided for @peaceful.
  ///
  /// In en, this message translates to:
  /// **'Peaceful'**
  String get peaceful;

  /// No description provided for @powerful.
  ///
  /// In en, this message translates to:
  /// **'Powerful'**
  String get powerful;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @proud.
  ///
  /// In en, this message translates to:
  /// **'Proud'**
  String get proud;

  /// No description provided for @interested.
  ///
  /// In en, this message translates to:
  /// **'Interested'**
  String get interested;

  /// No description provided for @content.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get content;

  /// No description provided for @playful.
  ///
  /// In en, this message translates to:
  /// **'Playful'**
  String get playful;

  /// No description provided for @excited.
  ///
  /// In en, this message translates to:
  /// **'Excited'**
  String get excited;

  /// No description provided for @amazed.
  ///
  /// In en, this message translates to:
  /// **'Amazed'**
  String get amazed;

  /// No description provided for @confused.
  ///
  /// In en, this message translates to:
  /// **'Confused'**
  String get confused;

  /// No description provided for @startled.
  ///
  /// In en, this message translates to:
  /// **'Startled'**
  String get startled;

  /// No description provided for @tired.
  ///
  /// In en, this message translates to:
  /// **'Tired'**
  String get tired;

  /// No description provided for @stressed.
  ///
  /// In en, this message translates to:
  /// **'Stressed'**
  String get stressed;

  /// No description provided for @busy.
  ///
  /// In en, this message translates to:
  /// **'Busy'**
  String get busy;

  /// No description provided for @bored.
  ///
  /// In en, this message translates to:
  /// **'Bored'**
  String get bored;

  /// No description provided for @helpless.
  ///
  /// In en, this message translates to:
  /// **'Helpless'**
  String get helpless;

  /// No description provided for @frightened.
  ///
  /// In en, this message translates to:
  /// **'Frightened'**
  String get frightened;

  /// No description provided for @overwhelmed.
  ///
  /// In en, this message translates to:
  /// **'Overwhelmed'**
  String get overwhelmed;

  /// No description provided for @worried.
  ///
  /// In en, this message translates to:
  /// **'Worried'**
  String get worried;

  /// No description provided for @inadequate.
  ///
  /// In en, this message translates to:
  /// **'Inadequate'**
  String get inadequate;

  /// No description provided for @inferior.
  ///
  /// In en, this message translates to:
  /// **'Inferior'**
  String get inferior;

  /// No description provided for @worthless.
  ///
  /// In en, this message translates to:
  /// **'Worthless'**
  String get worthless;

  /// No description provided for @insignificant.
  ///
  /// In en, this message translates to:
  /// **'Insignificant'**
  String get insignificant;

  /// No description provided for @excluded.
  ///
  /// In en, this message translates to:
  /// **'Excluded'**
  String get excluded;

  /// No description provided for @persecuted.
  ///
  /// In en, this message translates to:
  /// **'Persecuted'**
  String get persecuted;

  /// No description provided for @nervous.
  ///
  /// In en, this message translates to:
  /// **'Nervous'**
  String get nervous;

  /// No description provided for @exposed.
  ///
  /// In en, this message translates to:
  /// **'Exposed'**
  String get exposed;

  /// No description provided for @betrayed.
  ///
  /// In en, this message translates to:
  /// **'Betrayed'**
  String get betrayed;

  /// No description provided for @resentful.
  ///
  /// In en, this message translates to:
  /// **'Resentful'**
  String get resentful;

  /// No description provided for @disrespected.
  ///
  /// In en, this message translates to:
  /// **'Disrespected'**
  String get disrespected;

  /// No description provided for @ridiculed.
  ///
  /// In en, this message translates to:
  /// **'Ridiculed'**
  String get ridiculed;

  /// No description provided for @indignant.
  ///
  /// In en, this message translates to:
  /// **'Indignant'**
  String get indignant;

  /// No description provided for @violated.
  ///
  /// In en, this message translates to:
  /// **'Violated'**
  String get violated;

  /// No description provided for @furious.
  ///
  /// In en, this message translates to:
  /// **'Furious'**
  String get furious;

  /// No description provided for @jealous.
  ///
  /// In en, this message translates to:
  /// **'Jealous'**
  String get jealous;

  /// No description provided for @provoked.
  ///
  /// In en, this message translates to:
  /// **'Provoked'**
  String get provoked;

  /// No description provided for @hostile.
  ///
  /// In en, this message translates to:
  /// **'Hostile'**
  String get hostile;

  /// No description provided for @infuriated.
  ///
  /// In en, this message translates to:
  /// **'Infuriated'**
  String get infuriated;

  /// No description provided for @annoyed.
  ///
  /// In en, this message translates to:
  /// **'Annoyed'**
  String get annoyed;

  /// No description provided for @withdrawn.
  ///
  /// In en, this message translates to:
  /// **'Withdrawn'**
  String get withdrawn;

  /// No description provided for @numb.
  ///
  /// In en, this message translates to:
  /// **'Numb'**
  String get numb;

  /// No description provided for @sceptical.
  ///
  /// In en, this message translates to:
  /// **'Sceptical'**
  String get sceptical;

  /// No description provided for @dismissive.
  ///
  /// In en, this message translates to:
  /// **'Dismissive'**
  String get dismissive;

  /// No description provided for @judgmental.
  ///
  /// In en, this message translates to:
  /// **'Judgmental'**
  String get judgmental;

  /// No description provided for @embarrassed.
  ///
  /// In en, this message translates to:
  /// **'Embarrassed'**
  String get embarrassed;

  /// No description provided for @appalled.
  ///
  /// In en, this message translates to:
  /// **'Appalled'**
  String get appalled;

  /// No description provided for @revolted.
  ///
  /// In en, this message translates to:
  /// **'Revolted'**
  String get revolted;

  /// No description provided for @nauseated.
  ///
  /// In en, this message translates to:
  /// **'Nauseated'**
  String get nauseated;

  /// No description provided for @detestable.
  ///
  /// In en, this message translates to:
  /// **'Detestable'**
  String get detestable;

  /// No description provided for @horrified.
  ///
  /// In en, this message translates to:
  /// **'Horrified'**
  String get horrified;

  /// No description provided for @hesitant.
  ///
  /// In en, this message translates to:
  /// **'Hesitant'**
  String get hesitant;

  /// No description provided for @empty.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get empty;

  /// No description provided for @remorseful.
  ///
  /// In en, this message translates to:
  /// **'Remorseful'**
  String get remorseful;

  /// No description provided for @ashamed.
  ///
  /// In en, this message translates to:
  /// **'Ashamed'**
  String get ashamed;

  /// No description provided for @powerless.
  ///
  /// In en, this message translates to:
  /// **'Powerless'**
  String get powerless;

  /// No description provided for @grief.
  ///
  /// In en, this message translates to:
  /// **'Grief'**
  String get grief;

  /// No description provided for @fragile.
  ///
  /// In en, this message translates to:
  /// **'Fragile'**
  String get fragile;

  /// No description provided for @victimised.
  ///
  /// In en, this message translates to:
  /// **'Victimised'**
  String get victimised;

  /// No description provided for @abandoned.
  ///
  /// In en, this message translates to:
  /// **'Abandoned'**
  String get abandoned;

  /// No description provided for @isolated.
  ///
  /// In en, this message translates to:
  /// **'Isolated'**
  String get isolated;

  /// No description provided for @inspired.
  ///
  /// In en, this message translates to:
  /// **'Inspired'**
  String get inspired;

  /// No description provided for @hopeful.
  ///
  /// In en, this message translates to:
  /// **'Hopeful'**
  String get hopeful;

  /// No description provided for @intimate.
  ///
  /// In en, this message translates to:
  /// **'Intimate'**
  String get intimate;

  /// No description provided for @sensitive.
  ///
  /// In en, this message translates to:
  /// **'Sensitive'**
  String get sensitive;

  /// No description provided for @thankful.
  ///
  /// In en, this message translates to:
  /// **'Thankful'**
  String get thankful;

  /// No description provided for @loving.
  ///
  /// In en, this message translates to:
  /// **'Loving'**
  String get loving;

  /// No description provided for @creative.
  ///
  /// In en, this message translates to:
  /// **'Creative'**
  String get creative;

  /// No description provided for @courageous.
  ///
  /// In en, this message translates to:
  /// **'Courageous'**
  String get courageous;

  /// No description provided for @valued.
  ///
  /// In en, this message translates to:
  /// **'Valued'**
  String get valued;

  /// No description provided for @respected.
  ///
  /// In en, this message translates to:
  /// **'Respected'**
  String get respected;

  /// No description provided for @confident.
  ///
  /// In en, this message translates to:
  /// **'Confident'**
  String get confident;

  /// No description provided for @successful.
  ///
  /// In en, this message translates to:
  /// **'Successful'**
  String get successful;

  /// No description provided for @inquisitive.
  ///
  /// In en, this message translates to:
  /// **'Inquisitive'**
  String get inquisitive;

  /// No description provided for @curious.
  ///
  /// In en, this message translates to:
  /// **'Curious'**
  String get curious;

  /// No description provided for @joyful.
  ///
  /// In en, this message translates to:
  /// **'Joyful'**
  String get joyful;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @cheeky.
  ///
  /// In en, this message translates to:
  /// **'Cheeky'**
  String get cheeky;

  /// No description provided for @aroused.
  ///
  /// In en, this message translates to:
  /// **'Aroused'**
  String get aroused;

  /// No description provided for @energetic.
  ///
  /// In en, this message translates to:
  /// **'Energetic'**
  String get energetic;

  /// No description provided for @eager.
  ///
  /// In en, this message translates to:
  /// **'Eager'**
  String get eager;

  /// No description provided for @awe.
  ///
  /// In en, this message translates to:
  /// **'Awe'**
  String get awe;

  /// No description provided for @astonished.
  ///
  /// In en, this message translates to:
  /// **'Astonished'**
  String get astonished;

  /// No description provided for @perplex.
  ///
  /// In en, this message translates to:
  /// **'Perplex'**
  String get perplex;

  /// No description provided for @disillusioned.
  ///
  /// In en, this message translates to:
  /// **'Disillusioned'**
  String get disillusioned;

  /// No description provided for @dismayed.
  ///
  /// In en, this message translates to:
  /// **'Dismayed'**
  String get dismayed;

  /// No description provided for @shocked.
  ///
  /// In en, this message translates to:
  /// **'Shocked'**
  String get shocked;

  /// No description provided for @unfocussed.
  ///
  /// In en, this message translates to:
  /// **'Unfocussed'**
  String get unfocussed;

  /// No description provided for @sleepy.
  ///
  /// In en, this message translates to:
  /// **'Sleepy'**
  String get sleepy;

  /// No description provided for @outOfControl.
  ///
  /// In en, this message translates to:
  /// **'Out of control'**
  String get outOfControl;

  /// No description provided for @rushed.
  ///
  /// In en, this message translates to:
  /// **'Rushed'**
  String get rushed;

  /// No description provided for @pressured.
  ///
  /// In en, this message translates to:
  /// **'Pressured'**
  String get pressured;

  /// No description provided for @apathetic.
  ///
  /// In en, this message translates to:
  /// **'Apathetic'**
  String get apathetic;

  /// No description provided for @indifferent.
  ///
  /// In en, this message translates to:
  /// **'Indifferent'**
  String get indifferent;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @lastWeek.
  ///
  /// In en, this message translates to:
  /// **'Last week'**
  String get lastWeek;

  /// No description provided for @lastMonth.
  ///
  /// In en, this message translates to:
  /// **'Last month'**
  String get lastMonth;

  /// No description provided for @trends.
  ///
  /// In en, this message translates to:
  /// **'Trends'**
  String get trends;

  /// No description provided for @distribution.
  ///
  /// In en, this message translates to:
  /// **'Distribution'**
  String get distribution;

  /// No description provided for @patterns.
  ///
  /// In en, this message translates to:
  /// **'Patterns'**
  String get patterns;

  /// No description provided for @compare.
  ///
  /// In en, this message translates to:
  /// **'Compare'**
  String get compare;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
