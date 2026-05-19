import 'package:base_core/presenter/base_screen_state.dart';
import 'package:base_core/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/app_pages.router.dart';
import 'package:saa2025/pages/awards/award_detail.dart';
import 'package:saa2025/pages/awards/awards_models.dart';
import 'package:saa2025/pages/awards/awards_vm.dart';
import 'package:saa2025/pages/rules/rules.dart';
import 'package:saa2025/pages/secret_box/secret_box_navigation.dart';
import 'package:saa2025/pages/utils/mixin/notification_badge_mixin.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';
import 'package:saa2025/pages/widgets/saa_language_sheet.dart';

import 'awards_screen.dart';

class AwardsState extends StatefulWidget {
  const AwardsState({super.key});

  @override
  State<StatefulWidget> createState() => Awards();
}

class Awards extends BaseScreenState<AwardsState, AwardsVm> with UIMixin, NotificationBadgeMixin {
  String _languageCode = 'VN';

  String get languageCode => _languageCode;

  List<AwardItem> get awards => vm.awards;

  bool get isLoading => vm.isLoading;

  @override
  AwardsVm initViewModel() => AwardsVm();

  @override
  void beforeBuild() {
    _loadLanguage();
    initNotificationBadge();
    vm.loadAwards();
  }

  @override
  void dispose() {
    disposeNotificationBadge();
    super.dispose();
  }

  void _loadLanguage() {
    final saved = storage.getString(StorageKey.keySelectedLanguage.name);
    if (saved == 'en') _languageCode = 'EN';
    if (saved == 'ja') _languageCode = 'JA';
  }

  @override
  Widget initWidget(BuildContext context) => AwardsScreen(this, context).screen();

  void onLanguageTap() {
    showSaaLanguageSheet(
      context: context,
      currentCode: _languageCode,
      onLanguageChanged: (code) => setState(() => _languageCode = code),
    );
  }

  void onSearchTap() {}

  void onNotificationTap() => navigator.navigateTo(Routes.notificationListState);

  void onRulesTap() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => const RulesState()),
    );
  }

  void onSecretBoxTap() => openSecretBox(context);

  void onAwardTap(AwardItem item) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => AwardDetailState(award: item),
      ),
    );
  }
}
