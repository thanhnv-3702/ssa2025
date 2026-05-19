import 'package:base_core/common/base_const.dart';
import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/awards/awards.dart';
import 'package:saa2025/pages/awards/awards_models.dart';
import 'package:saa2025/pages/widgets/saa_app_header.dart';

/// Awards hub tab — MoMorph awards list (Sprint A).
class AwardsScreen extends BaseScreen<Awards> {
  AwardsScreen(super.main, super.context);

  static const Color _background = Color(0xFF00101A);
  static const Color _accent = Color(0xFFFFE99E);
  static const Color _textOnDark = Color(0xFFFFFFFF);

  @override
  Widget screen() {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: _background,
        body: Column(
          children: [
            SaaAppHeader(
              languageCode: main.languageCode,
              onLanguageTap: main.onLanguageTap,
              onSearchTap: main.onSearchTap,
              onNotificationTap: main.onNotificationTap,
              hasUnreadNotifications: main.hasUnreadNotifications,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 100.h),
                children: [
                  _sectionHeader('Sun* Annual Awards 2025', 'Hệ thống giải thưởng'),
                  Gap(8.h),
                  Text(
                    'Khám phá các hạng mục giải thưởng và tiêu chí vinh danh năm 2025.',
                    style: TextStyle(
                      fontFamily: BaseConst.fontLight,
                      fontSize: 13.sp,
                      height: 20 / 13,
                      color: _textOnDark.withValues(alpha: 0.85),
                    ),
                  ),
                  Gap(16.h),
                  _rulesCard(),
                  Gap(12.h),
                  _secretBoxCard(),
                  Gap(24.h),
                  for (final award in main.awards) ...[
                    _awardTile(award),
                    Gap(12.h),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String eyebrow, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: TextStyle(
            fontFamily: BaseConst.fontMedium,
            fontSize: 12.sp,
            color: _accent,
          ),
        ),
        Gap(4.h),
        Text(
          title,
          style: TextStyle(
            fontFamily: BaseConst.fontSemiBold,
            fontSize: 20.sp,
            color: _textOnDark,
          ),
        ),
      ],
    );
  }

  Widget _secretBoxCard() {
    return Material(
      color: Colors.white.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: main.onSecretBoxTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Icon(Icons.card_giftcard, color: _accent, size: 28.sp),
              Gap(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SECRET BOX',
                      style: TextStyle(
                        fontFamily: BaseConst.fontSemiBold,
                        fontSize: 12.sp,
                        color: _accent,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      'Khám phá hộp quà bí mật của bạn',
                      style: TextStyle(
                        fontFamily: BaseConst.fontMedium,
                        fontSize: 15.sp,
                        color: _textOnDark,
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(Assets.homeHomeIcArrow, width: 20.w, height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rulesCard() {
    return Material(
      color: Colors.white.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: main.onRulesTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'THỂ LỆ',
                      style: TextStyle(
                        fontFamily: BaseConst.fontSemiBold,
                        fontSize: 12.sp,
                        color: _accent,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      'Quy định & điều kiện tham gia SAA 2025',
                      style: TextStyle(
                        fontFamily: BaseConst.fontMedium,
                        fontSize: 15.sp,
                        color: _textOnDark,
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(Assets.homeHomeIcArrow, width: 20.w, height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _awardTile(AwardItem item) {
    return Material(
      color: Colors.white.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: () => main.onAwardTap(item),
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: Image.asset(item.imageAsset, width: 72.w, height: 72.w, fit: BoxFit.cover),
              ),
              Gap(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.subtitle,
                      style: TextStyle(
                        fontFamily: BaseConst.fontMedium,
                        fontSize: 11.sp,
                        color: _accent,
                      ),
                    ),
                    Gap(2.h),
                    Text(
                      item.title,
                      style: TextStyle(
                        fontFamily: BaseConst.fontSemiBold,
                        fontSize: 16.sp,
                        color: _textOnDark,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      item.longDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: BaseConst.fontLight,
                        fontSize: 12.sp,
                        height: 16 / 12,
                        color: _textOnDark.withValues(alpha: 0.75),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(8.w),
              SvgPicture.asset(Assets.homeHomeIcArrow, width: 16.w, height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
