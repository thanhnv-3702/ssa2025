import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('vi')
  ];

  /// No description provided for @allowNotification.
  ///
  /// In en, this message translates to:
  /// **'Allow notification'**
  String get allowNotification;

  /// No description provided for @accessDeniedMessage.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have permission to access this resource.'**
  String get accessDeniedMessage;

  /// No description provided for @accessDeniedTitle.
  ///
  /// In en, this message translates to:
  /// **'ACCESS DENIED'**
  String get accessDeniedTitle;

  /// No description provided for @awardKudosPromoBody.
  ///
  /// In en, this message translates to:
  /// **'A peer recognition program for all Sunners, launching in November 2025. Share appreciation on the platform published by the organizing committee. This will inform the Heads Council when selecting award winners.'**
  String get awardKudosPromoBody;

  /// No description provided for @awardKudosPromoDetailsButton.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get awardKudosPromoDetailsButton;

  /// No description provided for @awardKudosPromoEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Recognition movement'**
  String get awardKudosPromoEyebrow;

  /// No description provided for @awardKudosPromoHighlightTitle.
  ///
  /// In en, this message translates to:
  /// **'NEW IN SAA 2025\n'**
  String get awardKudosPromoHighlightTitle;

  /// No description provided for @awardKudosPromoTitle.
  ///
  /// In en, this message translates to:
  /// **'Sun* Kudos'**
  String get awardKudosPromoTitle;

  /// No description provided for @awardOrDivider.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get awardOrDivider;

  /// No description provided for @awardPrizeQuantityLabel.
  ///
  /// In en, this message translates to:
  /// **'Number of prizes'**
  String get awardPrizeQuantityLabel;

  /// No description provided for @awardPrizeValueLabel.
  ///
  /// In en, this message translates to:
  /// **'Prize value'**
  String get awardPrizeValueLabel;

  /// No description provided for @awardTopProjectDescription.
  ///
  /// In en, this message translates to:
  /// **'Top Project honors outstanding project teams with significant impact.'**
  String get awardTopProjectDescription;

  /// No description provided for @awardTopProjectLeaderDescription.
  ///
  /// In en, this message translates to:
  /// **'Top Project Leader honors exemplary project leaders.'**
  String get awardTopProjectLeaderDescription;

  /// No description provided for @awardTopProjectLeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Top Project Leader'**
  String get awardTopProjectLeaderTitle;

  /// No description provided for @awardTopProjectTitle.
  ///
  /// In en, this message translates to:
  /// **'Top Project'**
  String get awardTopProjectTitle;

  /// No description provided for @awardTopTalentDescription.
  ///
  /// In en, this message translates to:
  /// **'Top Talent honors individuals who excel across all dimensions in 2025.'**
  String get awardTopTalentDescription;

  /// No description provided for @awardTopTalentTitle.
  ///
  /// In en, this message translates to:
  /// **'Top Talent'**
  String get awardTopTalentTitle;

  /// No description provided for @awardsEventEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Sun* Annual Awards 2025'**
  String get awardsEventEyebrow;

  /// No description provided for @awardsKudosBrand.
  ///
  /// In en, this message translates to:
  /// **'KUDOS'**
  String get awardsKudosBrand;

  /// No description provided for @awardsKudosMovementEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Recognition movement'**
  String get awardsKudosMovementEyebrow;

  /// No description provided for @awardsKudosTitle.
  ///
  /// In en, this message translates to:
  /// **'Sun* Kudos'**
  String get awardsKudosTitle;

  /// No description provided for @awardsRecognitionSystemEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Recognition and appreciation'**
  String get awardsRecognitionSystemEyebrow;

  /// No description provided for @awardsSystemTitle.
  ///
  /// In en, this message translates to:
  /// **'Award system\nSAA 2025'**
  String get awardsSystemTitle;

  /// No description provided for @biometricAuthReason.
  ///
  /// In en, this message translates to:
  /// **'Please authenticate to sign in'**
  String get biometricAuthReason;

  /// No description provided for @bottomNavAwards.
  ///
  /// In en, this message translates to:
  /// **'Awards'**
  String get bottomNavAwards;

  /// No description provided for @bottomNavHome.
  ///
  /// In en, this message translates to:
  /// **'SAA 2025'**
  String get bottomNavHome;

  /// No description provided for @bottomNavKudos.
  ///
  /// In en, this message translates to:
  /// **'Kudos'**
  String get bottomNavKudos;

  /// No description provided for @bottomNavProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get bottomNavProfile;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @communityStandardsPrivacyBullet1.
  ///
  /// In en, this message translates to:
  /// **'Information security: All information Sunners share is protected on the system.'**
  String get communityStandardsPrivacyBullet1;

  /// No description provided for @communityStandardsPrivacyBullet2.
  ///
  /// In en, this message translates to:
  /// **'Sharing scope: All personnel and project information on the system is confidential. Please share only within Sun*.'**
  String get communityStandardsPrivacyBullet2;

  /// No description provided for @communityStandardsPrivacyCommitment.
  ///
  /// In en, this message translates to:
  /// **'Sunner is committed to protecting information. Every member is responsible for keeping shared content on the system confidential.'**
  String get communityStandardsPrivacyCommitment;

  /// No description provided for @communityStandardsPurpose.
  ///
  /// In en, this message translates to:
  /// **'Community Standards are designed to ensure a civilized, safe, and positive environment for all members joining the Sun* Kudos recognition movement.'**
  String get communityStandardsPurpose;

  /// No description provided for @communityStandardsRule1.
  ///
  /// In en, this message translates to:
  /// **'Using vulgar language, profanity, or offensive or defamatory content.'**
  String get communityStandardsRule1;

  /// No description provided for @communityStandardsRule10.
  ///
  /// In en, this message translates to:
  /// **'Abnormal spike in heart (like) counts (compared to average user behavior).'**
  String get communityStandardsRule10;

  /// No description provided for @communityStandardsRule2.
  ///
  /// In en, this message translates to:
  /// **'Referencing political, religious, or gender discrimination issues.'**
  String get communityStandardsRule2;

  /// No description provided for @communityStandardsRule3.
  ///
  /// In en, this message translates to:
  /// **'Containing specific figures (revenue, contracts, KPIs, customers, project codes, account numbers, etc.).'**
  String get communityStandardsRule3;

  /// No description provided for @communityStandardsRule4.
  ///
  /// In en, this message translates to:
  /// **'Mentioning names of partners, customers, or external organizations.'**
  String get communityStandardsRule4;

  /// No description provided for @communityStandardsRule5.
  ///
  /// In en, this message translates to:
  /// **'Containing personal information (email, phone number, address, family information).'**
  String get communityStandardsRule5;

  /// No description provided for @communityStandardsRule6.
  ///
  /// In en, this message translates to:
  /// **'Sending 3+ similar messages repeatedly in a short time.'**
  String get communityStandardsRule6;

  /// No description provided for @communityStandardsRule7.
  ///
  /// In en, this message translates to:
  /// **'Kudos that are too short (under 30 characters) without context (e.g. \"Thanks a lot\", \"Thanks\", \"Good job!\").'**
  String get communityStandardsRule7;

  /// No description provided for @communityStandardsRule8.
  ///
  /// In en, this message translates to:
  /// **'Sending to too many people/groups in a short time (<3s per message).'**
  String get communityStandardsRule8;

  /// No description provided for @communityStandardsRule9.
  ///
  /// In en, this message translates to:
  /// **'Spam wording (only symbols like \".\", \",\", \"...\", or meaningless characters).'**
  String get communityStandardsRule9;

  /// No description provided for @communityStandardsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'General standards'**
  String get communityStandardsScreenTitle;

  /// No description provided for @communityStandardsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Community standards'**
  String get communityStandardsSectionTitle;

  /// No description provided for @communityStandardsSpamIntro.
  ///
  /// In en, this message translates to:
  /// **'Content found to meet any of the criteria below will be labeled as Spam and proactively hidden by the system.'**
  String get communityStandardsSpamIntro;

  /// No description provided for @communityStandardsSupport.
  ///
  /// In en, this message translates to:
  /// **'Support contact: For any questions, please contact the SAA organizing committee representative on Slack: duong.thi.thuy.an.'**
  String get communityStandardsSupport;

  /// No description provided for @communityStandardsTitle.
  ///
  /// In en, this message translates to:
  /// **'Standards'**
  String get communityStandardsTitle;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @copyLink.
  ///
  /// In en, this message translates to:
  /// **'Copy link'**
  String get copyLink;

  /// No description provided for @currentVersion.
  ///
  /// In en, this message translates to:
  /// **'Current version'**
  String get currentVersion;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @downloadingUpdate.
  ///
  /// In en, this message translates to:
  /// **'Downloading update…'**
  String get downloadingUpdate;

  /// No description provided for @errorAccessDeniedMessage.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have permission to access this resource.'**
  String get errorAccessDeniedMessage;

  /// No description provided for @errorAccessDeniedTitle.
  ///
  /// In en, this message translates to:
  /// **'ACCESS DENIED'**
  String get errorAccessDeniedTitle;

  /// No description provided for @errorBackendNoToken.
  ///
  /// In en, this message translates to:
  /// **'Sign-in failed: the server did not return a token.'**
  String get errorBackendNoToken;

  /// No description provided for @errorBiometricNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication is not available on this device'**
  String get errorBiometricNotAvailable;

  /// No description provided for @errorBiometricSavedCredentialsMissing.
  ///
  /// In en, this message translates to:
  /// **'Please sign in with email and password first to use biometric login'**
  String get errorBiometricSavedCredentialsMissing;

  /// No description provided for @errorEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format.'**
  String get errorEmailInvalid;

  /// No description provided for @errorEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required.'**
  String get errorEmailRequired;

  /// No description provided for @errorGoHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get errorGoHome;

  /// No description provided for @errorGoogleLoginFailed.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in failed. Please try again.'**
  String get errorGoogleLoginFailed;

  /// No description provided for @errorGoogleNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Google Sign-In is not configured. Set SAA_AUTH_MOCK=true or GOOGLE_SERVER_CLIENT_ID.'**
  String get errorGoogleNotConfigured;

  /// No description provided for @errorLoginInvalid.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password.'**
  String get errorLoginInvalid;

  /// No description provided for @errorLoginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Signed in successfully'**
  String get errorLoginSuccess;

  /// No description provided for @errorNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'The resource you\'re looking for doesn\'t exist\nor has been removed.'**
  String get errorNotFoundMessage;

  /// No description provided for @errorNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'NOT FOUND'**
  String get errorNotFoundTitle;

  /// No description provided for @errorPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get errorPasswordRequired;

  /// Lockout toast
  ///
  /// In en, this message translates to:
  /// **'Too many failed attempts. Please try again in {minutes} minutes or reset your password'**
  String errorTooManyLoginAttempts(int minutes);

  /// No description provided for @homeAboutAwardButton.
  ///
  /// In en, this message translates to:
  /// **'ABOUT AWARD'**
  String get homeAboutAwardButton;

  /// No description provided for @homeAboutKudosButton.
  ///
  /// In en, this message translates to:
  /// **'ABOUT KUDOS'**
  String get homeAboutKudosButton;

  /// No description provided for @homeAwardsEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Sun* Annual Awards 2025'**
  String get homeAwardsEyebrow;

  /// No description provided for @homeAwardsTitle.
  ///
  /// In en, this message translates to:
  /// **'Award system'**
  String get homeAwardsTitle;

  /// No description provided for @homeComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get homeComingSoon;

  /// No description provided for @homeCountdownDays.
  ///
  /// In en, this message translates to:
  /// **'DAYS'**
  String get homeCountdownDays;

  /// No description provided for @homeCountdownHours.
  ///
  /// In en, this message translates to:
  /// **'HOURS'**
  String get homeCountdownHours;

  /// No description provided for @homeCountdownMinutes.
  ///
  /// In en, this message translates to:
  /// **'MINUTES'**
  String get homeCountdownMinutes;

  /// No description provided for @homeDetailsLink.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get homeDetailsLink;

  /// No description provided for @homeEventDate.
  ///
  /// In en, this message translates to:
  /// **'26/12/2025'**
  String get homeEventDate;

  /// No description provided for @homeEventTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time: '**
  String get homeEventTimeLabel;

  /// No description provided for @homeEventVenue.
  ///
  /// In en, this message translates to:
  /// **'Au Co Art Center'**
  String get homeEventVenue;

  /// No description provided for @homeEventVenueLabel.
  ///
  /// In en, this message translates to:
  /// **'Venue:'**
  String get homeEventVenueLabel;

  /// No description provided for @homeKudosDetailsButton.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get homeKudosDetailsButton;

  /// No description provided for @homeKudosEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Recognition movement'**
  String get homeKudosEyebrow;

  /// No description provided for @homeKudosHighlightTitle.
  ///
  /// In en, this message translates to:
  /// **'NEW IN SAA 2025\n'**
  String get homeKudosHighlightTitle;

  /// No description provided for @homeKudosNote.
  ///
  /// In en, this message translates to:
  /// **'A peer recognition program for all Sunners, launching in November 2025. Share appreciation on the platform published by the organizing committee. This will inform the Heads Council when selecting award winners.'**
  String get homeKudosNote;

  /// No description provided for @homeKudosTitle.
  ///
  /// In en, this message translates to:
  /// **'Sun* Kudos'**
  String get homeKudosTitle;

  /// No description provided for @homeLiveStreamNote.
  ///
  /// In en, this message translates to:
  /// **'Live stream on the Sun* Family Facebook Group'**
  String get homeLiveStreamNote;

  /// No description provided for @homeThemeNote.
  ///
  /// In en, this message translates to:
  /// **'Root Further is more than a name—it is the spirit every Sunner strives for: seeing deeply in every context and continuously creating, expanding yourself beyond limits you once set. Like color theory, from three primaries—red, yellow, and blue—each person\'s creativity can produce nearly infinite hues, each representing breakthrough and boundless innovation.'**
  String get homeThemeNote;

  /// No description provided for @honorBadgeHeroSuffix.
  ///
  /// In en, this message translates to:
  /// **'Hero'**
  String get honorBadgeHeroSuffix;

  /// No description provided for @honorBadgeLegendPrefix.
  ///
  /// In en, this message translates to:
  /// **'Legend '**
  String get honorBadgeLegendPrefix;

  /// No description provided for @honorBadgeRisingPrefix.
  ///
  /// In en, this message translates to:
  /// **'Rising '**
  String get honorBadgeRisingPrefix;

  /// No description provided for @honorLegendHero.
  ///
  /// In en, this message translates to:
  /// **'Legend Hero'**
  String get honorLegendHero;

  /// No description provided for @honorRisingHero.
  ///
  /// In en, this message translates to:
  /// **'Rising Hero'**
  String get honorRisingHero;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image;

  /// No description provided for @kudoAnonymousSender.
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get kudoAnonymousSender;

  /// No description provided for @kudoFormatSelectTextToast.
  ///
  /// In en, this message translates to:
  /// **'Select text to format'**
  String get kudoFormatSelectTextToast;

  /// No description provided for @kudoLinkCopiedToast.
  ///
  /// In en, this message translates to:
  /// **'Link copied'**
  String get kudoLinkCopiedToast;

  /// No description provided for @kudoViewDetailsAction.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get kudoViewDetailsAction;

  /// No description provided for @kudosAllEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Sun* Annual Awards 2025'**
  String get kudosAllEyebrow;

  /// No description provided for @kudosAllScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'All Kudos'**
  String get kudosAllScreenTitle;

  /// No description provided for @kudosAllSectionHeader.
  ///
  /// In en, this message translates to:
  /// **'ALL KUDOS'**
  String get kudosAllSectionHeader;

  /// No description provided for @kudosAllSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'ALL KUDOS'**
  String get kudosAllSectionTitle;

  /// No description provided for @kudosFilterDepartmentCev.
  ///
  /// In en, this message translates to:
  /// **'CEV'**
  String get kudosFilterDepartmentCev;

  /// No description provided for @kudosFilterDepartmentDefault.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get kudosFilterDepartmentDefault;

  /// No description provided for @kudosFilterDepartmentDesign.
  ///
  /// In en, this message translates to:
  /// **'Design'**
  String get kudosFilterDepartmentDesign;

  /// No description provided for @kudosFilterDepartmentEngineering.
  ///
  /// In en, this message translates to:
  /// **'Engineering'**
  String get kudosFilterDepartmentEngineering;

  /// No description provided for @kudosFilterDepartmentHr.
  ///
  /// In en, this message translates to:
  /// **'HR'**
  String get kudosFilterDepartmentHr;

  /// No description provided for @kudosFilterDepartmentSales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get kudosFilterDepartmentSales;

  /// No description provided for @kudosFilterHashtagAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get kudosFilterHashtagAll;

  /// No description provided for @kudosFilterHashtagCreative.
  ///
  /// In en, this message translates to:
  /// **'#creative'**
  String get kudosFilterHashtagCreative;

  /// No description provided for @kudosFilterHashtagGratitude.
  ///
  /// In en, this message translates to:
  /// **'#gratitude'**
  String get kudosFilterHashtagGratitude;

  /// No description provided for @kudosFilterHashtagMotivation.
  ///
  /// In en, this message translates to:
  /// **'#motivation'**
  String get kudosFilterHashtagMotivation;

  /// No description provided for @kudosFilterHashtagTeamwork.
  ///
  /// In en, this message translates to:
  /// **'#teamwork'**
  String get kudosFilterHashtagTeamwork;

  /// No description provided for @kudosFilterPeriodAll.
  ///
  /// In en, this message translates to:
  /// **'All time'**
  String get kudosFilterPeriodAll;

  /// No description provided for @kudosFilterPeriodThreeMonths.
  ///
  /// In en, this message translates to:
  /// **'Last 3 months'**
  String get kudosFilterPeriodThreeMonths;

  /// No description provided for @kudosFilterPeriodThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get kudosFilterPeriodThisMonth;

  /// No description provided for @kudosFilterPeriodTitle.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get kudosFilterPeriodTitle;

  /// No description provided for @kudosFilterPeriodWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get kudosFilterPeriodWeek;

  /// No description provided for @kudosHashtagSheetDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get kudosHashtagSheetDone;

  /// No description provided for @kudosHashtagSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Hashtag ({selected}/5)'**
  String kudosHashtagSheetTitle(int selected);

  /// No description provided for @kudosHighlightEmptyFiltered.
  ///
  /// In en, this message translates to:
  /// **'No Kudos match the current filters'**
  String get kudosHighlightEmptyFiltered;

  /// No description provided for @kudosHighlightSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'HIGHLIGHT'**
  String get kudosHighlightSectionTitle;

  /// No description provided for @kudosOpenSecretBoxButton.
  ///
  /// In en, this message translates to:
  /// **'Open Secret Box'**
  String get kudosOpenSecretBoxButton;

  /// No description provided for @kudosRecognitionSystemEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Recognition and appreciation'**
  String get kudosRecognitionSystemEyebrow;

  /// No description provided for @kudosRecipientAdvancedSearch.
  ///
  /// In en, this message translates to:
  /// **'Advanced search'**
  String get kudosRecipientAdvancedSearch;

  /// No description provided for @kudosRecipientSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get kudosRecipientSearchHint;

  /// No description provided for @kudosRecipientSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Select recipient'**
  String get kudosRecipientSheetTitle;

  /// No description provided for @kudosSectionEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Sun* Annual Awards 2025'**
  String get kudosSectionEyebrow;

  /// No description provided for @kudosSendCtaPrompt.
  ///
  /// In en, this message translates to:
  /// **'Who would you like to send kudos to today?'**
  String get kudosSendCtaPrompt;

  /// No description provided for @kudosSpotlightSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get kudosSpotlightSearch;

  /// No description provided for @kudosSpotlightSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'SPOTLIGHT BOARD'**
  String get kudosSpotlightSectionTitle;

  /// No description provided for @kudosSpotlightReceivedNewKudo.
  ///
  /// In en, this message translates to:
  /// **'received a new Kudo'**
  String get kudosSpotlightReceivedNewKudo;

  /// No description provided for @kudosSpotlightTotalCount.
  ///
  /// In en, this message translates to:
  /// **'{count} KUDOS'**
  String kudosSpotlightTotalCount(int count);

  /// No description provided for @kudosStatsHeartsLabel.
  ///
  /// In en, this message translates to:
  /// **'Hearts received:'**
  String get kudosStatsHeartsLabel;

  /// No description provided for @kudosStatsReceivedLabel.
  ///
  /// In en, this message translates to:
  /// **'Kudos received:'**
  String get kudosStatsReceivedLabel;

  /// No description provided for @kudosStatsSecretBoxOpenedLabel.
  ///
  /// In en, this message translates to:
  /// **'Secret Boxes opened:'**
  String get kudosStatsSecretBoxOpenedLabel;

  /// No description provided for @kudosStatsSecretBoxUnopenedLabel.
  ///
  /// In en, this message translates to:
  /// **'Secret Boxes unopened:'**
  String get kudosStatsSecretBoxUnopenedLabel;

  /// No description provided for @kudosStatsSentLabel.
  ///
  /// In en, this message translates to:
  /// **'Kudos sent:'**
  String get kudosStatsSentLabel;

  /// No description provided for @kudosTopGiftReceiverNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Huynh Duong Xuan'**
  String get kudosTopGiftReceiverNamePlaceholder;

  /// No description provided for @kudosTopGiftReceiverRewardPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Received 1 SAA t-shirt'**
  String get kudosTopGiftReceiverRewardPlaceholder;

  /// No description provided for @kudosTopGiftReceiversTitle.
  ///
  /// In en, this message translates to:
  /// **'10 SUNNERS WITH LATEST GIFTS'**
  String get kudosTopGiftReceiversTitle;

  /// No description provided for @kudosViewAllLink.
  ///
  /// In en, this message translates to:
  /// **'View all Kudos'**
  String get kudosViewAllLink;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English (EN)'**
  String get languageEnglish;

  /// No description provided for @languageJapanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese (JA)'**
  String get languageJapanese;

  /// No description provided for @languageSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSheetTitle;

  /// No description provided for @languageVietnamese.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese (VN)'**
  String get languageVietnamese;

  /// No description provided for @latestVersion.
  ///
  /// In en, this message translates to:
  /// **'Latest version'**
  String get latestVersion;

  /// No description provided for @loginCopyright.
  ///
  /// In en, this message translates to:
  /// **'Copyright © Sun* 2025'**
  String get loginCopyright;

  /// No description provided for @loginDescription.
  ///
  /// In en, this message translates to:
  /// **'Start your journey with SAA 2025.\nSign in to explore!'**
  String get loginDescription;

  /// No description provided for @loginGoogleButton.
  ///
  /// In en, this message translates to:
  /// **'SIGN IN WITH GOOGLE'**
  String get loginGoogleButton;

  /// No description provided for @newVersionAvailable.
  ///
  /// In en, this message translates to:
  /// **'A new version ({version}) is available'**
  String newVersionAvailable(String version);

  /// No description provided for @notificationEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Updates about Kudos, awards, and SAA events will appear here.'**
  String get notificationEmptyDescription;

  /// No description provided for @notificationEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get notificationEmptyTitle;

  /// No description provided for @notificationListTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationListTitle;

  /// No description provided for @notificationMarkAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get notificationMarkAllRead;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @previewKudoAttachedImages.
  ///
  /// In en, this message translates to:
  /// **'{count} attached image(s)'**
  String previewKudoAttachedImages(int count);

  /// No description provided for @previewKudoEditButton.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get previewKudoEditButton;

  /// No description provided for @previewKudoSendButton.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get previewKudoSendButton;

  /// No description provided for @previewKudoSendSuccessToast.
  ///
  /// In en, this message translates to:
  /// **'Kudos sent successfully!'**
  String get previewKudoSendSuccessToast;

  /// No description provided for @previewKudoSendingButton.
  ///
  /// In en, this message translates to:
  /// **'Sending…'**
  String get previewKudoSendingButton;

  /// No description provided for @previewKudoTitle.
  ///
  /// In en, this message translates to:
  /// **'Preview Kudos'**
  String get previewKudoTitle;

  /// No description provided for @privacyStandardsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy standards'**
  String get privacyStandardsSectionTitle;

  /// No description provided for @profileIconCollectionTitle.
  ///
  /// In en, this message translates to:
  /// **'My icon collection'**
  String get profileIconCollectionTitle;

  /// No description provided for @profileKudosEmpty.
  ///
  /// In en, this message translates to:
  /// **'No Kudos yet'**
  String get profileKudosEmpty;

  /// No description provided for @profileKudosEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Sun* Annual Awards 2025'**
  String get profileKudosEyebrow;

  /// No description provided for @profileKudosFilterReceived.
  ///
  /// In en, this message translates to:
  /// **'Received ({count})'**
  String profileKudosFilterReceived(int count);

  /// No description provided for @profileKudosFilterSent.
  ///
  /// In en, this message translates to:
  /// **'Sent ({count})'**
  String profileKudosFilterSent(int count);

  /// No description provided for @profileKudosSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'KUDOS'**
  String get profileKudosSectionTitle;

  /// No description provided for @profileOpenSecretBoxButton.
  ///
  /// In en, this message translates to:
  /// **'Open Secret Box'**
  String get profileOpenSecretBoxButton;

  /// No description provided for @profileStatsHeartsLabel.
  ///
  /// In en, this message translates to:
  /// **'Hearts received:'**
  String get profileStatsHeartsLabel;

  /// No description provided for @profileStatsKudosReceivedLabel.
  ///
  /// In en, this message translates to:
  /// **'Kudos received:'**
  String get profileStatsKudosReceivedLabel;

  /// No description provided for @profileStatsKudosSentLabel.
  ///
  /// In en, this message translates to:
  /// **'Kudos sent:'**
  String get profileStatsKudosSentLabel;

  /// No description provided for @profileStatsSecretBoxOpenedLabel.
  ///
  /// In en, this message translates to:
  /// **'Secret Boxes opened:'**
  String get profileStatsSecretBoxOpenedLabel;

  /// No description provided for @profileStatsSecretBoxUnopenedLabel.
  ///
  /// In en, this message translates to:
  /// **'Secret Boxes unopened:'**
  String get profileStatsSecretBoxUnopenedLabel;

  /// No description provided for @rulesCloseButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get rulesCloseButton;

  /// No description provided for @rulesContentTitle.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get rulesContentTitle;

  /// No description provided for @rulesEventTitle.
  ///
  /// In en, this message translates to:
  /// **'Sun* Annual Awards 2025'**
  String get rulesEventTitle;

  /// No description provided for @rulesHeroLegendDescription.
  ///
  /// In en, this message translates to:
  /// **'You have become a trusted and beloved symbol,\nalways ready to support and remembered by many teammates.'**
  String get rulesHeroLegendDescription;

  /// No description provided for @rulesHeroLegendRequirement.
  ///
  /// In en, this message translates to:
  /// **'More than 20 people sent you Kudos'**
  String get rulesHeroLegendRequirement;

  /// No description provided for @rulesHeroNewDescription.
  ///
  /// In en, this message translates to:
  /// **'Your journey of spreading goodness begins — the first words of thanks and recognition have reached you.'**
  String get rulesHeroNewDescription;

  /// No description provided for @rulesHeroNewRequirement.
  ///
  /// In en, this message translates to:
  /// **'1–4 people sent you Kudos'**
  String get rulesHeroNewRequirement;

  /// No description provided for @rulesHeroRisingDescription.
  ///
  /// In en, this message translates to:
  /// **'Your journey of spreading goodness begins — the first words of thanks and recognition have reached you.'**
  String get rulesHeroRisingDescription;

  /// No description provided for @rulesHeroRisingRequirement.
  ///
  /// In en, this message translates to:
  /// **'5–9 people sent you Kudos'**
  String get rulesHeroRisingRequirement;

  /// No description provided for @rulesHeroSectionIntro.
  ///
  /// In en, this message translates to:
  /// **'Based on how many teammates send you Kudos, you earn a corresponding Hero badge shown next to your profile name.'**
  String get rulesHeroSectionIntro;

  /// No description provided for @rulesHeroSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'KUDOS RECIPIENTS: HERO BADGES FOR POSITIVE INFLUENCE'**
  String get rulesHeroSectionTitle;

  /// No description provided for @rulesHeroSuperDescription.
  ///
  /// In en, this message translates to:
  /// **'You have become a trusted and beloved symbol,\nalways ready to support and remembered by many teammates.'**
  String get rulesHeroSuperDescription;

  /// No description provided for @rulesHeroSuperRequirement.
  ///
  /// In en, this message translates to:
  /// **'10–20 people sent you Kudos'**
  String get rulesHeroSuperRequirement;

  /// No description provided for @rulesHonorNewPrefix.
  ///
  /// In en, this message translates to:
  /// **'New '**
  String get rulesHonorNewPrefix;

  /// No description provided for @rulesHonorSuperPrefix.
  ///
  /// In en, this message translates to:
  /// **'Super'**
  String get rulesHonorSuperPrefix;

  /// No description provided for @rulesIconBeyondBoundary.
  ///
  /// In en, this message translates to:
  /// **'BEYOND THE BOUNDARY'**
  String get rulesIconBeyondBoundary;

  /// No description provided for @rulesIconFlowToHorizon.
  ///
  /// In en, this message translates to:
  /// **'FLOW TO HORIZON'**
  String get rulesIconFlowToHorizon;

  /// No description provided for @rulesIconRevival.
  ///
  /// In en, this message translates to:
  /// **'REVIVAL'**
  String get rulesIconRevival;

  /// No description provided for @rulesIconRootFurther.
  ///
  /// In en, this message translates to:
  /// **'ROOT FURTHER'**
  String get rulesIconRootFurther;

  /// No description provided for @rulesIconStayGold.
  ///
  /// In en, this message translates to:
  /// **'STAY GOLD'**
  String get rulesIconStayGold;

  /// No description provided for @rulesIconTouchOfLight.
  ///
  /// In en, this message translates to:
  /// **'TOUCH OF LIGHT'**
  String get rulesIconTouchOfLight;

  /// No description provided for @rulesIconsFooter.
  ///
  /// In en, this message translates to:
  /// **'Sunners who collect all 6 icons receive a mystery gift from SAA 2025.'**
  String get rulesIconsFooter;

  /// No description provided for @rulesIconsSectionIntro.
  ///
  /// In en, this message translates to:
  /// **'Every Kudos you send is published on the platform and earns ❤️ from the Sunner community. Every 5 hearts lets you open 1 Secret Box for a chance to collect one of 6 exclusive SAA icons.'**
  String get rulesIconsSectionIntro;

  /// No description provided for @rulesIconsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'KUDOS SENDERS: COLLECT ALL 6 ICONS FOR A MYSTERY GIFT'**
  String get rulesIconsSectionTitle;

  /// No description provided for @rulesNationalKudosBody.
  ///
  /// In en, this message translates to:
  /// **'The 5 Kudos with the most ❤️ across Sun* become National Kudos and receive the special Root Further gift from SAA 2025.'**
  String get rulesNationalKudosBody;

  /// No description provided for @rulesNationalKudosTitle.
  ///
  /// In en, this message translates to:
  /// **'NATIONAL KUDOS'**
  String get rulesNationalKudosTitle;

  /// No description provided for @rulesTitle.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get rulesTitle;

  /// No description provided for @rulesWriteKudoButton.
  ///
  /// In en, this message translates to:
  /// **'Write Kudos'**
  String get rulesWriteKudoButton;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchSunnerHint.
  ///
  /// In en, this message translates to:
  /// **'Search Sunner'**
  String get searchSunnerHint;

  /// No description provided for @searchSunnerNoResults.
  ///
  /// In en, this message translates to:
  /// **'No Sunner found'**
  String get searchSunnerNoResults;

  /// No description provided for @searchSunnerRecentTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get searchSunnerRecentTitle;

  /// No description provided for @searchSunnerSuggestionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get searchSunnerSuggestionsTitle;

  /// No description provided for @searchSunnerViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get searchSunnerViewAll;

  /// No description provided for @secretBoxActivitySectionTitle.
  ///
  /// In en, this message translates to:
  /// **'In-app activity'**
  String get secretBoxActivitySectionTitle;

  /// No description provided for @secretBoxAllOpened.
  ///
  /// In en, this message translates to:
  /// **'You have opened all Secret Boxes'**
  String get secretBoxAllOpened;

  /// No description provided for @secretBoxContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get secretBoxContinueButton;

  /// No description provided for @secretBoxExploreTitle.
  ///
  /// In en, this message translates to:
  /// **'EXPLORE YOUR SECRET BOX'**
  String get secretBoxExploreTitle;

  /// No description provided for @secretBoxMarkAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get secretBoxMarkAllRead;

  /// No description provided for @secretBoxOpening.
  ///
  /// In en, this message translates to:
  /// **'Opening gift box…'**
  String get secretBoxOpening;

  /// No description provided for @secretBoxRevealed.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You received a reward'**
  String get secretBoxRevealed;

  /// No description provided for @secretBoxShowMore.
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get secretBoxShowMore;

  /// No description provided for @secretBoxStandbySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Congratulations on receiving a gift from the SAA 2025 organizers'**
  String get secretBoxStandbySubtitle;

  /// No description provided for @secretBoxStandbyTitle.
  ///
  /// In en, this message translates to:
  /// **'SECRET BOX'**
  String get secretBoxStandbyTitle;

  /// No description provided for @secretBoxTapToOpen.
  ///
  /// In en, this message translates to:
  /// **'Tap the box to open'**
  String get secretBoxTapToOpen;

  /// No description provided for @secretBoxTitle.
  ///
  /// In en, this message translates to:
  /// **'Secret Box'**
  String get secretBoxTitle;

  /// No description provided for @secretBoxUnopenedLabel.
  ///
  /// In en, this message translates to:
  /// **'Secret Box not opened'**
  String get secretBoxUnopenedLabel;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @sending.
  ///
  /// In en, this message translates to:
  /// **'Sending…'**
  String get sending;

  /// No description provided for @systemError.
  ///
  /// In en, this message translates to:
  /// **'System error. Please try again later.'**
  String get systemError;

  /// No description provided for @updateAvailable.
  ///
  /// In en, this message translates to:
  /// **'Update available'**
  String get updateAvailable;

  /// No description provided for @updateDownloadUrlNotFound.
  ///
  /// In en, this message translates to:
  /// **'Download URL not found'**
  String get updateDownloadUrlNotFound;

  /// No description provided for @updateDownloaded.
  ///
  /// In en, this message translates to:
  /// **'Update downloaded. Installing…'**
  String get updateDownloaded;

  /// No description provided for @updateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to download update'**
  String get updateFailed;

  /// No description provided for @updateLater.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get updateLater;

  /// No description provided for @updateNow.
  ///
  /// In en, this message translates to:
  /// **'Update now'**
  String get updateNow;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @viewAnonymousKudoReceiverLabel.
  ///
  /// In en, this message translates to:
  /// **'Kudos recipient'**
  String get viewAnonymousKudoReceiverLabel;

  /// No description provided for @viewAnonymousKudoSenderLabel.
  ///
  /// In en, this message translates to:
  /// **'Anonymous sender'**
  String get viewAnonymousKudoSenderLabel;

  /// No description provided for @viewAnonymousKudoTitle.
  ///
  /// In en, this message translates to:
  /// **'Anonymous Kudos'**
  String get viewAnonymousKudoTitle;

  /// No description provided for @viewKudoTitle.
  ///
  /// In en, this message translates to:
  /// **'Kudo'**
  String get viewKudoTitle;

  /// No description provided for @whatsNew.
  ///
  /// In en, this message translates to:
  /// **'What\'s new'**
  String get whatsNew;

  /// No description provided for @writeKudoAddHashtagChip.
  ///
  /// In en, this message translates to:
  /// **'+ Hashtag (max 5)'**
  String get writeKudoAddHashtagChip;

  /// No description provided for @writeKudoAddImageButton.
  ///
  /// In en, this message translates to:
  /// **'+ Image (max {max})'**
  String writeKudoAddImageButton(int max);

  /// No description provided for @writeKudoAnonymousCheckbox.
  ///
  /// In en, this message translates to:
  /// **'Send appreciation anonymously'**
  String get writeKudoAnonymousCheckbox;

  /// No description provided for @writeKudoCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get writeKudoCancelButton;

  /// No description provided for @writeKudoCancelDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get writeKudoCancelDialogConfirm;

  /// No description provided for @writeKudoCancelDialogContinue.
  ///
  /// In en, this message translates to:
  /// **'Keep editing'**
  String get writeKudoCancelDialogContinue;

  /// No description provided for @writeKudoCancelDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Unsent content will be lost.'**
  String get writeKudoCancelDialogMessage;

  /// No description provided for @writeKudoCancelDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard Kudos draft?'**
  String get writeKudoCancelDialogTitle;

  /// No description provided for @writeKudoCommunityStandardsLink.
  ///
  /// In en, this message translates to:
  /// **'Community standards'**
  String get writeKudoCommunityStandardsLink;

  /// No description provided for @writeKudoHashtagLabel.
  ///
  /// In en, this message translates to:
  /// **'Hashtag'**
  String get writeKudoHashtagLabel;

  /// No description provided for @writeKudoMaxImagesToast.
  ///
  /// In en, this message translates to:
  /// **'Maximum {max} images'**
  String writeKudoMaxImagesToast(int max);

  /// No description provided for @writeKudoMentionHint.
  ///
  /// In en, this message translates to:
  /// **'You can use \"@ + name\" to mention colleagues'**
  String get writeKudoMentionHint;

  /// No description provided for @writeKudoMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Write your message of appreciation here!'**
  String get writeKudoMessageHint;

  /// No description provided for @writeKudoPreviewButton.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get writeKudoPreviewButton;

  /// No description provided for @writeKudoRecipientHint.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get writeKudoRecipientHint;

  /// No description provided for @writeKudoRecipientLabel.
  ///
  /// In en, this message translates to:
  /// **'Recipient'**
  String get writeKudoRecipientLabel;

  /// No description provided for @writeKudoSendButton.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get writeKudoSendButton;

  /// No description provided for @writeKudoSendFailedRetryToast.
  ///
  /// In en, this message translates to:
  /// **'Failed to send Kudos. Please try again.'**
  String get writeKudoSendFailedRetryToast;

  /// No description provided for @writeKudoSendFailedToast.
  ///
  /// In en, this message translates to:
  /// **'Failed to send Kudos'**
  String get writeKudoSendFailedToast;

  /// No description provided for @writeKudoSendSuccessToast.
  ///
  /// In en, this message translates to:
  /// **'Kudos sent successfully!'**
  String get writeKudoSendSuccessToast;

  /// No description provided for @writeKudoSendingButton.
  ///
  /// In en, this message translates to:
  /// **'Sending…'**
  String get writeKudoSendingButton;

  /// No description provided for @writeKudoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Send appreciation and recognition to your teammate'**
  String get writeKudoSubtitle;

  /// No description provided for @writeKudoTitle.
  ///
  /// In en, this message translates to:
  /// **'New Kudo'**
  String get writeKudoTitle;

  /// No description provided for @writeKudoTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Give an honor title…'**
  String get writeKudoTitleHint;

  /// No description provided for @writeKudoTitleHelper.
  ///
  /// In en, this message translates to:
  /// **'Example: The person who motivates me.\nThis title will appear as your Kudo headline.'**
  String get writeKudoTitleHelper;

  /// No description provided for @writeKudoTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Honor title'**
  String get writeKudoTitleLabel;

  /// No description provided for @writeKudoTitleRequiredToast.
  ///
  /// In en, this message translates to:
  /// **'Please enter an honor title'**
  String get writeKudoTitleRequiredToast;

  /// No description provided for @writeKudoValidationBanner.
  ///
  /// In en, this message translates to:
  /// **'Fill in Recipient, Message, and Hashtag to send Kudos!'**
  String get writeKudoValidationBanner;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ja', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ja': return AppLocalizationsJa();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
