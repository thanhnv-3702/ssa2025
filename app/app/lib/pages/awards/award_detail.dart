import 'package:base_core/presenter/base_screen_state.dart';
import 'package:base_core/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/app_pages.router.dart';
import 'package:saa2025/pages/awards/award_detail_screen.dart';
import 'package:saa2025/pages/awards/award_detail_vm.dart';
import 'package:saa2025/pages/awards/awards_models.dart';
import 'package:saa2025/pages/utils/event_bus/event_bus_util.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';
import 'package:saa2025/pages/widgets/saa_language_sheet.dart';

class AwardDetailState extends StatefulWidget {
  const AwardDetailState({super.key, required this.award});

  final AwardItem award;

  @override
  State<StatefulWidget> createState() => AwardDetailPage();
}

class AwardDetailPage extends BaseScreenState<AwardDetailState, AwardDetailVm> with UIMixin {
  String _languageCode = 'VN';

  AwardItem get award => widget.award;

  String get languageCode => _languageCode;

  @override
  AwardDetailVm initViewModel() => AwardDetailVm();

  @override
  void beforeBuild() => _loadLanguage();

  void _loadLanguage() {
    final saved = storage.getString(StorageKey.keySelectedLanguage.name);
    if (saved == 'en') _languageCode = 'EN';
    if (saved == 'ja') _languageCode = 'JA';
  }

  @override
  Widget initWidget(BuildContext context) => AwardDetailScreen(this, context).screen();

  void onBack() => Navigator.pop(context);

  void onLanguageTap() {
    showSaaLanguageSheet(
      context: context,
      currentCode: _languageCode,
      onLanguageChanged: (code) => setState(() => _languageCode = code),
    );
  }

  void onNotificationTap() => navigator.navigateTo(Routes.notificationListState);

  void onKudosDetailTap() {
    Navigator.popUntil(context, (route) => route.isFirst);
    eventBus.fire(ChangeTabEvent(2));
  }
}
