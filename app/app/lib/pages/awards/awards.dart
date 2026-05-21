import 'package:base_core/presenter/base_screen_state.dart';
import 'package:base_core/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/pages/app_pages.router.dart';
import 'package:saa2025/pages/awards/award_detail.dart';
import 'package:saa2025/pages/awards/awards_models.dart';
import 'package:saa2025/pages/awards/awards_vm.dart';
import 'package:saa2025/pages/utils/event_bus/event_bus_util.dart';
import 'package:saa2025/pages/utils/mixin/notification_badge_mixin.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';
import 'package:saa2025/pages/widgets/saa_language_sheet.dart';
import 'package:saa2025/theme/app_colors.dart';

import 'awards_screen.dart';

class AwardsState extends StatefulWidget {
  const AwardsState({super.key});

  @override
  State<StatefulWidget> createState() => Awards();
}

class Awards extends BaseScreenState<AwardsState, AwardsVm> with UIMixin, NotificationBadgeMixin {
  String _languageCode = 'EN';
  int _selectedAwardIndex = 0;

  String get languageCode => _languageCode;

  List<AwardItem> get awards => vm.awards;

  AwardItem get selectedAward => awards.isNotEmpty ? awards[_selectedAwardIndex] : awards[0];

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

  void onDropdownTap() {
    showModalBottomSheet<int>(
      context: context,
      backgroundColor: AppColors.surfaceDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(12.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.white30,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Gap(16.h),
              for (var i = 0; i < awards.length; i++)
                InkWell(
                  onTap: () => Navigator.pop(ctx, i),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          awards[i].title,
                          style: TextStyle(
                            fontFamily: 'PlusJakartaSans-Medium',
                            fontSize: 16.sp,
                            color: i == _selectedAwardIndex ? AppColors.accentGold : AppColors.textPrimary,
                          ),
                        ),
                        if (i == _selectedAwardIndex) Icon(Icons.check, color: AppColors.accentGold, size: 20.sp),
                      ],
                    ),
                  ),
                ),
              Gap(16.h),
            ],
          ),
        );
      },
    ).then((index) {
      if (index != null && index >= 0 && index < awards.length) {
        setState(() => _selectedAwardIndex = index);
      }
    });
  }

  void onKudosDetailTap() => eventBus.fire(ChangeTabEvent(2));

  void onAwardTap(AwardItem item) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => AwardDetailState(award: item),
      ),
    );
  }
}
