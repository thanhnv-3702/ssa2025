import 'dart:async';

import 'package:base_core/presenter/base_screen_state.dart';
import 'package:base_core/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/app_pages.router.dart';
import 'package:saa2025/pages/awards/award_detail.dart';
import 'package:saa2025/pages/awards/awards_mock_data.dart';
import 'package:saa2025/pages/home/home_models.dart';
import 'package:saa2025/pages/home/home_vm.dart';
import 'package:saa2025/pages/kudos/community_standards.dart';
import 'package:saa2025/pages/kudos/search_sunner.dart';
import 'package:saa2025/pages/rules/rules.dart';
import 'package:saa2025/pages/utils/event_bus/event_bus_util.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/pages/utils/mixin/notification_badge_mixin.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';
import 'package:saa2025/pages/widgets/saa_language_sheet.dart';

import 'home_screen.dart';

class HomeState extends StatefulWidget {
  const HomeState({super.key});

  @override
  State<StatefulWidget> createState() => Home();
}

class Home extends BaseScreenState<HomeState, HomeVm> with UIMixin, NotificationBadgeMixin {
  static final DateTime _eventDate = DateTime(2025, 12, 26);

  Timer? _countdownTimer;
  HomeCountdown _countdown = HomeCountdown.zero;
  String _languageCode = 'EN';

  HomeCountdown get countdown => _countdown;

  String get languageCode => _languageCode;

  List<HomeAwardItem> get awards => [
        HomeAwardItem(
          title: tr.awardTopTalentTitle,
          description: tr.awardTopTalentDescription,
          imageAsset: Assets.homeHomeAwardTalent,
        ),
        HomeAwardItem(
          title: tr.awardTopProjectTitle,
          description: tr.awardTopProjectDescription,
          imageAsset: Assets.homeHomeAwardProject,
        ),
        HomeAwardItem(
          title: tr.awardTopProjectLeaderTitle,
          description: tr.awardTopProjectLeaderDescription,
          imageAsset: Assets.homeHomeAwardLeader,
        ),
      ];

  @override
  HomeVm initViewModel() => HomeVm();

  @override
  void beforeBuild() {
    _loadLanguage();
    initNotificationBadge();
    _tickCountdown();
    _countdownTimer = Timer.periodic(const Duration(minutes: 1), (_) => _tickCountdown());
  }

  void _loadLanguage() {
    final saved = storage.getString(StorageKey.keySelectedLanguage.name);
    if (saved == 'en') _languageCode = 'EN';
    if (saved == 'ja') _languageCode = 'JA';
  }

  void _tickCountdown() {
    final now = DateTime.now();
    final diff = _eventDate.difference(now);
    if (!mounted) return;
    setState(() {
      if (diff.isNegative) {
        _countdown = HomeCountdown.zero;
      } else {
        _countdown = HomeCountdown(
          days: diff.inDays,
          hours: diff.inHours.remainder(24),
          minutes: diff.inMinutes.remainder(60),
        );
      }
    });
  }

  @override
  Widget initWidget(BuildContext context) => HomeScreen(this, context).screen();

  void onLanguageTap() {
    showSaaLanguageSheet(
      context: context,
      currentCode: _languageCode,
      onLanguageChanged: (code) => setState(() => _languageCode = code),
    );
  }

  void onSearchTap() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const SearchSunnerState()),
    );
  }

  void onNotificationTap() => navigator.navigateTo(Routes.notificationListState);

  void onAboutAwardTap() => eventBus.fire(ChangeTabEvent(1));

  void onAboutKudosTap() => eventBus.fire(ChangeTabEvent(2));

  void onAwardDetailTap(int index) {
    if (index >= AwardsMockData.awards.length) return;
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => AwardDetailState(award: AwardsMockData.awards[index]),
      ),
    );
  }

  void onKudosDetailTap() => eventBus.fire(ChangeTabEvent(2));

  void onFabWriteKudoTap() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const RulesState()),
    );
  }

  void onFabKudosListTap() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const CommunityStandardsState()),
    );
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    disposeNotificationBadge();
    super.dispose();
  }
}
