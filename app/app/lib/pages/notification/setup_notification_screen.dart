import 'package:base_core/presenter/base_screen.dart';
import 'package:base_core/res/widgets/text.dart';
import 'package:base_core/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/notification/setup_notification.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/pages/widgets/custom_switch_widget.dart';

class SetupNotificationScreen extends BaseScreen<SetupNotification> {
  SetupNotificationScreen(super.main, super.context);

  @override
  Widget screen() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: _appBar(),
        body: _body(),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          Assets.commonIcBack,
          width: 24.w,
          height: 24.w,
        ),
        onPressed: main.onBackPressed,
      ),
      centerTitle: true,
      title: TextCs(
        text: tr.notifications,
        style: AppFonts.large500.copyWith(
          color: AppColors.inkDarkest,
          fontSize: 18.sp,
        ),
      ),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(16.h),
            _notificationToggleSection(),
          ],
        ),
      ),
    );
  }

  Widget _notificationToggleSection() {
    return Row(
      children: [
        Expanded(
          child: TextCs(
            text: tr.allowNotification,
            style: AppFonts.regular500.copyWith(
              color: AppColors.inkBase,
              fontSize: 16.sp,
            ),
          ),
        ),
        Gap(12.w),
        CustomSwitchWidget(
          value: main.isNotificationEnabled,
          onChanged: main.onNotificationToggleChanged,
        ),
      ],
    );
  }
}
