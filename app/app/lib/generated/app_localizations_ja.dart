// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get allowNotification => 'Allow notification';

  @override
  String get accessDeniedMessage => 'このリソースへのアクセス権限がありません。';

  @override
  String get accessDeniedTitle => 'ACCESS DENIED';

  @override
  String get awardKudosPromoBody => 'A peer recognition program for all Sunners, launching in November 2025. Share appreciation on the platform published by the organizing committee. This will inform the Heads Council when selecting award winners.';

  @override
  String get awardKudosPromoDetailsButton => 'Details';

  @override
  String get awardKudosPromoEyebrow => 'Recognition movement';

  @override
  String get awardKudosPromoHighlightTitle => 'NEW IN SAA 2025\n';

  @override
  String get awardKudosPromoTitle => 'Sun* Kudos';

  @override
  String get awardOrDivider => 'Or';

  @override
  String get awardPrizeQuantityLabel => 'Number of prizes';

  @override
  String get awardPrizeValueLabel => 'Prize value';

  @override
  String get awardTopProjectDescription => 'Top Project honors outstanding project teams with significant impact.';

  @override
  String get awardTopProjectLeaderDescription => 'Top Project Leader honors exemplary project leaders.';

  @override
  String get awardTopProjectLeaderTitle => 'Top Project Leader';

  @override
  String get awardTopProjectTitle => 'Top Project';

  @override
  String get awardTopTalentDescription => 'Top Talent honors individuals who excel across all dimensions in 2025.';

  @override
  String get awardTopTalentTitle => 'Top Talent';

  @override
  String get awardsEventEyebrow => 'Sun* Annual Awards 2025';

  @override
  String get awardsKudosBrand => 'KUDOS';

  @override
  String get awardsKudosMovementEyebrow => 'Recognition movement';

  @override
  String get awardsKudosTitle => 'Sun* Kudos';

  @override
  String get awardsRecognitionSystemEyebrow => 'Recognition and appreciation';

  @override
  String get awardsSystemTitle => 'Award system\nSAA 2025';

  @override
  String get biometricAuthReason => 'Please authenticate to sign in';

  @override
  String get bottomNavAwards => 'Awards';

  @override
  String get bottomNavHome => 'SAA 2025';

  @override
  String get bottomNavKudos => 'Kudos';

  @override
  String get bottomNavProfile => 'Profile';

  @override
  String get cancel => 'Cancel';

  @override
  String get communityStandardsPrivacyBullet1 => 'Information security: All information Sunners share is protected on the system.';

  @override
  String get communityStandardsPrivacyBullet2 => 'Sharing scope: All personnel and project information on the system is confidential. Please share only within Sun*.';

  @override
  String get communityStandardsPrivacyCommitment => 'Sunner is committed to protecting information. Every member is responsible for keeping shared content on the system confidential.';

  @override
  String get communityStandardsPurpose => 'Community Standards are designed to ensure a civilized, safe, and positive environment for all members joining the Sun* Kudos recognition movement.';

  @override
  String get communityStandardsRule1 => 'Using vulgar language, profanity, or offensive or defamatory content.';

  @override
  String get communityStandardsRule10 => 'Abnormal spike in heart (like) counts (compared to average user behavior).';

  @override
  String get communityStandardsRule2 => 'Referencing political, religious, or gender discrimination issues.';

  @override
  String get communityStandardsRule3 => 'Containing specific figures (revenue, contracts, KPIs, customers, project codes, account numbers, etc.).';

  @override
  String get communityStandardsRule4 => 'Mentioning names of partners, customers, or external organizations.';

  @override
  String get communityStandardsRule5 => 'Containing personal information (email, phone number, address, family information).';

  @override
  String get communityStandardsRule6 => 'Sending 3+ similar messages repeatedly in a short time.';

  @override
  String get communityStandardsRule7 => 'Kudos that are too short (under 30 characters) without context (e.g. \"Thanks a lot\", \"Thanks\", \"Good job!\").';

  @override
  String get communityStandardsRule8 => 'Sending to too many people/groups in a short time (<3s per message).';

  @override
  String get communityStandardsRule9 => 'Spam wording (only symbols like \".\", \",\", \"...\", or meaningless characters).';

  @override
  String get communityStandardsScreenTitle => 'General standards';

  @override
  String get communityStandardsSectionTitle => 'Community standards';

  @override
  String get communityStandardsSpamIntro => 'Content found to meet any of the criteria below will be labeled as Spam and proactively hidden by the system.';

  @override
  String get communityStandardsSupport => 'Support contact: For any questions, please contact the SAA organizing committee representative on Slack: duong.thi.thuy.an.';

  @override
  String get communityStandardsTitle => 'Standards';

  @override
  String get continueAction => 'Continue';

  @override
  String get copyLink => 'Copy link';

  @override
  String get currentVersion => 'Current version';

  @override
  String get details => 'Details';

  @override
  String get done => 'Done';

  @override
  String get downloadingUpdate => 'Downloading update…';

  @override
  String get errorAccessDeniedMessage => 'このリソースへのアクセス権限がありません。';

  @override
  String get errorAccessDeniedTitle => 'ACCESS DENIED';

  @override
  String get errorBackendNoToken => 'Sign-in failed: the server did not return a token.';

  @override
  String get errorBiometricNotAvailable => 'Biometric authentication is not available on this device';

  @override
  String get errorBiometricSavedCredentialsMissing => 'Please sign in with email and password first to use biometric login';

  @override
  String get errorEmailInvalid => 'Invalid email format.';

  @override
  String get errorEmailRequired => 'Email is required.';

  @override
  String get errorGoHome => 'ホームに戻る';

  @override
  String get errorGoogleLoginFailed => 'Google sign-in failed. Please try again.';

  @override
  String get errorGoogleNotConfigured => 'Google Sign-In is not configured. Set SAA_AUTH_MOCK=true or GOOGLE_SERVER_CLIENT_ID.';

  @override
  String get errorLoginInvalid => 'Incorrect email or password.';

  @override
  String get errorLoginSuccess => 'Signed in successfully';

  @override
  String get errorNotFoundMessage => 'お探しのリソースは存在しないか、\n削除されました。';

  @override
  String get errorNotFoundTitle => 'NOT FOUND';

  @override
  String get errorPasswordRequired => 'Password is required';

  @override
  String errorTooManyLoginAttempts(int minutes) {
    return 'Too many failed attempts. Please try again in $minutes minutes or reset your password';
  }

  @override
  String get homeAboutAwardButton => 'ABOUT AWARD';

  @override
  String get homeAboutKudosButton => 'ABOUT KUDOS';

  @override
  String get homeAwardsEyebrow => 'Sun* Annual Awards 2025';

  @override
  String get homeAwardsTitle => 'Award system';

  @override
  String get homeComingSoon => 'Coming soon';

  @override
  String get homeCountdownDays => 'DAYS';

  @override
  String get homeCountdownHours => 'HOURS';

  @override
  String get homeCountdownMinutes => 'MINUTES';

  @override
  String get homeDetailsLink => 'Details';

  @override
  String get homeEventDate => '26/12/2025';

  @override
  String get homeEventTimeLabel => 'Time: ';

  @override
  String get homeEventVenue => 'Au Co Art Center';

  @override
  String get homeEventVenueLabel => 'Venue:';

  @override
  String get homeKudosDetailsButton => 'Details';

  @override
  String get homeKudosEyebrow => 'Recognition movement';

  @override
  String get homeKudosHighlightTitle => 'NEW IN SAA 2025\n';

  @override
  String get homeKudosNote => 'A peer recognition program for all Sunners, launching in November 2025. Share appreciation on the platform published by the organizing committee. This will inform the Heads Council when selecting award winners.';

  @override
  String get homeKudosTitle => 'Sun* Kudos';

  @override
  String get homeLiveStreamNote => 'Live stream on the Sun* Family Facebook Group';

  @override
  String get homeThemeNote => 'Root Further is more than a name—it is the spirit every Sunner strives for: seeing deeply in every context and continuously creating, expanding yourself beyond limits you once set. Like color theory, from three primaries—red, yellow, and blue—each person\'s creativity can produce nearly infinite hues, each representing breakthrough and boundless innovation.';

  @override
  String get honorBadgeHeroSuffix => 'Hero';

  @override
  String get honorBadgeLegendPrefix => 'Legend ';

  @override
  String get honorBadgeRisingPrefix => 'Rising ';

  @override
  String get honorLegendHero => 'Legend Hero';

  @override
  String get honorRisingHero => 'Rising Hero';

  @override
  String get image => 'Image';

  @override
  String get kudoAnonymousSender => 'Anonymous';

  @override
  String get kudoFormatSelectTextToast => 'Select text to format';

  @override
  String get kudoLinkCopiedToast => 'Link copied';

  @override
  String get kudoViewDetailsAction => 'View details';

  @override
  String get kudosAllEyebrow => 'Sun* Annual Awards 2025';

  @override
  String get kudosAllScreenTitle => 'All Kudos';

  @override
  String get kudosAllSectionHeader => 'ALL KUDOS';

  @override
  String get kudosAllSectionTitle => 'ALL KUDOS';

  @override
  String get kudosFilterDepartmentCev => 'CEV';

  @override
  String get kudosFilterDepartmentDefault => 'Department';

  @override
  String get kudosFilterDepartmentDesign => 'Design';

  @override
  String get kudosFilterDepartmentEngineering => 'Engineering';

  @override
  String get kudosFilterDepartmentHr => 'HR';

  @override
  String get kudosFilterDepartmentSales => 'Sales';

  @override
  String get kudosFilterHashtagAll => 'All';

  @override
  String get kudosFilterHashtagCreative => '#creative';

  @override
  String get kudosFilterHashtagGratitude => '#gratitude';

  @override
  String get kudosFilterHashtagMotivation => '#motivation';

  @override
  String get kudosFilterHashtagTeamwork => '#teamwork';

  @override
  String get kudosFilterPeriodAll => 'All time';

  @override
  String get kudosFilterPeriodThreeMonths => 'Last 3 months';

  @override
  String get kudosFilterPeriodThisMonth => 'This month';

  @override
  String get kudosFilterPeriodTitle => 'Time';

  @override
  String get kudosFilterPeriodWeek => 'This week';

  @override
  String get kudosHashtagSheetDone => 'Done';

  @override
  String kudosHashtagSheetTitle(int selected) {
    return 'Hashtag ($selected/5)';
  }

  @override
  String get kudosHighlightEmptyFiltered => 'No Kudos match the current filters';

  @override
  String get kudosHighlightSectionTitle => 'HIGHLIGHT';

  @override
  String get kudosOpenSecretBoxButton => 'Open Secret Box';

  @override
  String get kudosRecognitionSystemEyebrow => 'Recognition and appreciation';

  @override
  String get kudosRecipientAdvancedSearch => 'Advanced search';

  @override
  String get kudosRecipientSearchHint => 'Search';

  @override
  String get kudosRecipientSheetTitle => 'Select recipient';

  @override
  String get kudosSectionEyebrow => 'Sun* Annual Awards 2025';

  @override
  String get kudosSendCtaPrompt => 'Who would you like to send kudos to today?';

  @override
  String get kudosSpotlightSearch => 'Search';

  @override
  String get kudosSpotlightSectionTitle => 'SPOTLIGHT BOARD';

  @override
  String get kudosSpotlightReceivedNewKudo => 'received a new Kudo';

  @override
  String kudosSpotlightTotalCount(int count) {
    return '$count KUDOS';
  }

  @override
  String get kudosStatsHeartsLabel => 'Hearts received:';

  @override
  String get kudosStatsReceivedLabel => 'Kudos received:';

  @override
  String get kudosStatsSecretBoxOpenedLabel => 'Secret Boxes opened:';

  @override
  String get kudosStatsSecretBoxUnopenedLabel => 'Secret Boxes unopened:';

  @override
  String get kudosStatsSentLabel => 'Kudos sent:';

  @override
  String get kudosTopGiftReceiverNamePlaceholder => 'Huynh Duong Xuan';

  @override
  String get kudosTopGiftReceiverRewardPlaceholder => 'Received 1 SAA t-shirt';

  @override
  String get kudosTopGiftReceiversTitle => '10 SUNNERS WITH LATEST GIFTS';

  @override
  String get kudosViewAllLink => 'View all Kudos';

  @override
  String get languageEnglish => 'English (EN)';

  @override
  String get languageJapanese => 'Japanese (JA)';

  @override
  String get languageSheetTitle => 'Language';

  @override
  String get languageVietnamese => 'Vietnamese (VN)';

  @override
  String get latestVersion => 'Latest version';

  @override
  String get loginCopyright => '著作権は Sun* © 2025 に帰属します';

  @override
  String get loginDescription => 'SAA 2025の旅を始めましょう。\nログインして探索してください！';

  @override
  String get loginGoogleButton => 'SIGN IN WITH GOOGLE';

  @override
  String newVersionAvailable(String version) {
    return 'A new version ($version) is available';
  }

  @override
  String get notificationEmptyDescription => 'Updates about Kudos, awards, and SAA events will appear here.';

  @override
  String get notificationEmptyTitle => 'No notifications yet';

  @override
  String get notificationListTitle => 'Notifications';

  @override
  String get notificationMarkAllRead => 'Mark all as read';

  @override
  String get notifications => 'Notifications';

  @override
  String get preview => 'Preview';

  @override
  String previewKudoAttachedImages(int count) {
    return '$count attached image(s)';
  }

  @override
  String get previewKudoEditButton => 'Edit';

  @override
  String get previewKudoSendButton => 'Send';

  @override
  String get previewKudoSendSuccessToast => 'Kudos sent successfully!';

  @override
  String get previewKudoSendingButton => 'Sending…';

  @override
  String get previewKudoTitle => 'Preview Kudos';

  @override
  String get privacyStandardsSectionTitle => 'Privacy standards';

  @override
  String get profileIconCollectionTitle => 'My icon collection';

  @override
  String get profileKudosEmpty => 'No Kudos yet';

  @override
  String get profileKudosEyebrow => 'Sun* Annual Awards 2025';

  @override
  String profileKudosFilterReceived(int count) {
    return 'Received ($count)';
  }

  @override
  String profileKudosFilterSent(int count) {
    return 'Sent ($count)';
  }

  @override
  String get profileKudosSectionTitle => 'KUDOS';

  @override
  String get profileOpenSecretBoxButton => 'Open Secret Box';

  @override
  String get profileStatsHeartsLabel => 'Hearts received:';

  @override
  String get profileStatsKudosReceivedLabel => 'Kudos received:';

  @override
  String get profileStatsKudosSentLabel => 'Kudos sent:';

  @override
  String get profileStatsSecretBoxOpenedLabel => 'Secret Boxes opened:';

  @override
  String get profileStatsSecretBoxUnopenedLabel => 'Secret Boxes unopened:';

  @override
  String get rulesCloseButton => 'Close';

  @override
  String get rulesContentTitle => 'Rules';

  @override
  String get rulesEventTitle => 'Sun* Annual Awards 2025';

  @override
  String get rulesHeroLegendDescription => 'You have become a trusted and beloved symbol,\nalways ready to support and remembered by many teammates.';

  @override
  String get rulesHeroLegendRequirement => 'More than 20 people sent you Kudos';

  @override
  String get rulesHeroNewDescription => 'Your journey of spreading goodness begins — the first words of thanks and recognition have reached you.';

  @override
  String get rulesHeroNewRequirement => '1–4 people sent you Kudos';

  @override
  String get rulesHeroRisingDescription => 'Your journey of spreading goodness begins — the first words of thanks and recognition have reached you.';

  @override
  String get rulesHeroRisingRequirement => '5–9 people sent you Kudos';

  @override
  String get rulesHeroSectionIntro => 'Based on how many teammates send you Kudos, you earn a corresponding Hero badge shown next to your profile name.';

  @override
  String get rulesHeroSectionTitle => 'KUDOS RECIPIENTS: HERO BADGES FOR POSITIVE INFLUENCE';

  @override
  String get rulesHeroSuperDescription => 'You have become a trusted and beloved symbol,\nalways ready to support and remembered by many teammates.';

  @override
  String get rulesHeroSuperRequirement => '10–20 people sent you Kudos';

  @override
  String get rulesHonorNewPrefix => 'New ';

  @override
  String get rulesHonorSuperPrefix => 'Super';

  @override
  String get rulesIconBeyondBoundary => 'BEYOND THE BOUNDARY';

  @override
  String get rulesIconFlowToHorizon => 'FLOW TO HORIZON';

  @override
  String get rulesIconRevival => 'REVIVAL';

  @override
  String get rulesIconRootFurther => 'ROOT FURTHER';

  @override
  String get rulesIconStayGold => 'STAY GOLD';

  @override
  String get rulesIconTouchOfLight => 'TOUCH OF LIGHT';

  @override
  String get rulesIconsFooter => 'Sunners who collect all 6 icons receive a mystery gift from SAA 2025.';

  @override
  String get rulesIconsSectionIntro => 'Every Kudos you send is published on the platform and earns ❤️ from the Sunner community. Every 5 hearts lets you open 1 Secret Box for a chance to collect one of 6 exclusive SAA icons.';

  @override
  String get rulesIconsSectionTitle => 'KUDOS SENDERS: COLLECT ALL 6 ICONS FOR A MYSTERY GIFT';

  @override
  String get rulesNationalKudosBody => 'The 5 Kudos with the most ❤️ across Sun* become National Kudos and receive the special Root Further gift from SAA 2025.';

  @override
  String get rulesNationalKudosTitle => 'NATIONAL KUDOS';

  @override
  String get rulesTitle => 'Rules';

  @override
  String get rulesWriteKudoButton => 'Write Kudos';

  @override
  String get search => 'Search';

  @override
  String get searchSunnerHint => 'Search Sunner';

  @override
  String get searchSunnerNoResults => 'No Sunner found';

  @override
  String get searchSunnerRecentTitle => 'Recent';

  @override
  String get searchSunnerSuggestionsTitle => 'Suggestions';

  @override
  String get searchSunnerViewAll => 'View all';

  @override
  String get secretBoxActivitySectionTitle => 'In-app activity';

  @override
  String get secretBoxAllOpened => 'You have opened all Secret Boxes';

  @override
  String get secretBoxContinueButton => 'Continue';

  @override
  String get secretBoxExploreTitle => 'EXPLORE YOUR SECRET BOX';

  @override
  String get secretBoxMarkAllRead => 'Mark all as read';

  @override
  String get secretBoxOpening => 'Opening gift box…';

  @override
  String get secretBoxRevealed => 'Congratulations! You received a reward';

  @override
  String get secretBoxShowMore => 'Show more';

  @override
  String get secretBoxStandbySubtitle => 'Congratulations on receiving a gift from the SAA 2025 organizers';

  @override
  String get secretBoxStandbyTitle => 'SECRET BOX';

  @override
  String get secretBoxTapToOpen => 'Tap the box to open';

  @override
  String get secretBoxTitle => 'Secret Box';

  @override
  String get secretBoxUnopenedLabel => 'Secret Box not opened';

  @override
  String get send => 'Send';

  @override
  String get sending => 'Sending…';

  @override
  String get systemError => 'System error. Please try again later.';

  @override
  String get updateAvailable => 'Update available';

  @override
  String get updateDownloadUrlNotFound => 'Download URL not found';

  @override
  String get updateDownloaded => 'Update downloaded. Installing…';

  @override
  String get updateFailed => 'Failed to download update';

  @override
  String get updateLater => 'Later';

  @override
  String get updateNow => 'Update now';

  @override
  String get version => 'Version';

  @override
  String get viewAnonymousKudoReceiverLabel => 'Kudos recipient';

  @override
  String get viewAnonymousKudoSenderLabel => 'Anonymous sender';

  @override
  String get viewAnonymousKudoTitle => 'Anonymous Kudos';

  @override
  String get viewKudoTitle => 'Kudo';

  @override
  String get whatsNew => 'What\'s new';

  @override
  String get writeKudoAddHashtagChip => '+ Hashtag (max 5)';

  @override
  String writeKudoAddImageButton(int max) {
    return '+ Image (max $max)';
  }

  @override
  String get writeKudoAnonymousCheckbox => 'Send appreciation anonymously';

  @override
  String get writeKudoCancelButton => 'Cancel';

  @override
  String get writeKudoCancelDialogConfirm => 'Discard';

  @override
  String get writeKudoCancelDialogContinue => 'Keep editing';

  @override
  String get writeKudoCancelDialogMessage => 'Unsent content will be lost.';

  @override
  String get writeKudoCancelDialogTitle => 'Discard Kudos draft?';

  @override
  String get writeKudoCommunityStandardsLink => 'Community standards';

  @override
  String get writeKudoHashtagLabel => 'Hashtag';

  @override
  String writeKudoMaxImagesToast(int max) {
    return 'Maximum $max images';
  }

  @override
  String get writeKudoMentionHint => 'You can use \"@ + name\" to mention colleagues';

  @override
  String get writeKudoMessageHint => 'Write your message of appreciation here!';

  @override
  String get writeKudoPreviewButton => 'Preview';

  @override
  String get writeKudoRecipientHint => 'Search';

  @override
  String get writeKudoRecipientLabel => 'Recipient';

  @override
  String get writeKudoSendButton => 'Send';

  @override
  String get writeKudoSendFailedRetryToast => 'Failed to send Kudos. Please try again.';

  @override
  String get writeKudoSendFailedToast => 'Failed to send Kudos';

  @override
  String get writeKudoSendSuccessToast => 'Kudos sent successfully!';

  @override
  String get writeKudoSendingButton => 'Sending…';

  @override
  String get writeKudoSubtitle => 'Send appreciation and recognition to your teammate';

  @override
  String get writeKudoTitle => 'New Kudo';

  @override
  String get writeKudoTitleHint => 'Give an honor title…';

  @override
  String get writeKudoTitleHelper => 'Example: The person who motivates me.\nThis title will appear as your Kudo headline.';

  @override
  String get writeKudoTitleLabel => 'Honor title';

  @override
  String get writeKudoTitleRequiredToast => 'Please enter an honor title';

  @override
  String get writeKudoValidationBanner => 'Fill in Recipient, Message, and Hashtag to send Kudos!';
}
