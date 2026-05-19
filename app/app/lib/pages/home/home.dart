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
import 'package:saa2025/pages/kudos/search_sunner.dart';
import 'package:saa2025/pages/rules/rules.dart';
import 'package:saa2025/pages/utils/event_bus/event_bus_util.dart';
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
  String _languageCode = 'VN';

  HomeCountdown get countdown => _countdown;

  String get languageCode => _languageCode;

  String get themeNote =>
      'Không đơn thuần là một cái tên, “Root Further” chính là tinh thần mà mỗi người Sun* đang hướng tới: luôn nhìn nhận sâu sắc trong mọi bối cảnh và không ngừng sáng tạo, mở rộng bản thân để vượt qua những giới hạn mà chính mình đã từng đặt ra.';

  String get kudosNote =>
      'Hoạt động ghi nhận và cảm ơn đồng nghiệp - lần đầu tiên được diễn ra dành cho tất cả Sunner. Hoạt động sẽ được triển khai vào tháng 11/2025, khuyến khích người Sun* chia sẻ những lời ghi nhận, cảm ơn đồng nghiệp trên hệ thống do BTC công bố.';

  List<HomeAwardItem> get awards => const [
        HomeAwardItem(
          title: 'Top Talent',
          description: 'Giải thưởng Top Talent vinh danh những cá nhân xuất sắc trên mọi phương diện trong năm 2025.',
          imageAsset: Assets.homeHomeAwardTalent,
        ),
        HomeAwardItem(
          title: 'Top Project',
          description: 'Giải thưởng Top Project vinh danh các tập thể dự án xuất sắc và có tác động lớn.',
          imageAsset: Assets.homeHomeAwardProject,
        ),
        HomeAwardItem(
          title: 'Top Project Leader',
          description: 'Giải thưởng Top Project Leader vinh danh những nhà lãnh đạo dự án tiêu biểu.',
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

  void onAboutAwardTap() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => const RulesState()),
    );
  }

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

  void onFabKudosTap() => eventBus.fire(ChangeTabEvent(2));

  @override
  void dispose() {
    _countdownTimer?.cancel();
    disposeNotificationBadge();
    super.dispose();
  }
}
