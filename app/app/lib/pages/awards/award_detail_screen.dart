import 'package:base_core/common/base_const.dart';
import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/awards/award_detail.dart';
import 'package:saa2025/pages/awards/awards_models.dart';
import 'package:saa2025/pages/awards/widgets/award_kudos_promo.dart';
import 'package:saa2025/pages/awards/widgets/award_picture_card.dart';
import 'package:saa2025/pages/widgets/saa_app_header.dart';

/// Award detail — MoMorph `Award_*` screens (Sprint B).
class AwardDetailScreen extends BaseScreen<AwardDetailPage> {
  AwardDetailScreen(super.main, super.context);

  static const Color _background = Color(0xFF00101A);
  static const Color _accent = Color(0xFFFFE99E);
  static const Color _textOnDark = Color(0xFFFFFFFF);
  static const Color _divider = Color(0xFF2E3940);

  @override
  Widget screen() {
    final award = main.award;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: _background,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 280.h,
              child: Image.asset(Assets.homeHomeBg, fit: BoxFit.cover),
            ),
            Column(
              children: [
                SaaAppHeader(
                  languageCode: main.languageCode,
                  onLanguageTap: main.onLanguageTap,
                  onNotificationTap: main.onNotificationTap,
                  showBack: true,
                  onBack: main.onBack,
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 40.h),
                    children: [
                      AwardPictureCard(imageAsset: award.imageAsset, title: award.title),
                      Gap(20.h),
                      _descriptionBlock(award),
                      Gap(16.h),
                      const Divider(color: _divider, height: 1),
                      Gap(16.h),
                      _prizeQuantityBlock(award),
                      Gap(16.h),
                      const Divider(color: _divider, height: 1),
                      Gap(16.h),
                      for (var i = 0; i < award.prizeValues.length; i++) ...[
                        if (i > 0) ...[
                          Gap(16.h),
                          const Divider(color: _divider, height: 1),
                          Gap(16.h),
                        ],
                        _prizeValueBlock(award.prizeValues[i]),
                      ],
                      Gap(32.h),
                      AwardKudosPromo(onDetailTap: main.onKudosDetailTap),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _descriptionBlock(AwardItem award) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(Icons.emoji_events_outlined, award.displayTitle),
        Gap(12.h),
        Text(
          award.longDescription,
          style: TextStyle(
            fontFamily: BaseConst.fontLight,
            fontSize: 14.sp,
            height: 20 / 14,
            letterSpacing: 0.25,
            color: _textOnDark.withValues(alpha: 0.95),
          ),
        ),
      ],
    );
  }

  Widget _prizeQuantityBlock(AwardItem award) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(Icons.diamond_outlined, 'Số lượng giải thưởng'),
        Gap(8.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              award.prizeQuantity,
              style: TextStyle(
                fontFamily: BaseConst.fontBold,
                fontSize: 18.sp,
                height: 24 / 18,
                letterSpacing: 0.5,
                color: _textOnDark,
              ),
            ),
            Gap(4.w),
            Text(
              award.prizeQuantityUnit,
              style: TextStyle(
                fontFamily: BaseConst.fontLight,
                fontSize: 14.sp,
                height: 20 / 14,
                letterSpacing: 0.25,
                color: _textOnDark.withValues(alpha: 0.9),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _prizeValueBlock(AwardPrizeValue value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(Icons.flag_outlined, 'Giá trị giải thưởng'),
        Gap(8.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Flexible(
              child: Text(
                value.amount,
                style: TextStyle(
                  fontFamily: BaseConst.fontBold,
                  fontSize: 18.sp,
                  height: 24 / 18,
                  letterSpacing: 0.5,
                  color: _textOnDark,
                ),
              ),
            ),
            Gap(8.w),
            Flexible(
              child: Text(
                value.suffix,
                style: TextStyle(
                  fontFamily: BaseConst.fontLight,
                  fontSize: 14.sp,
                  height: 20 / 14,
                  letterSpacing: 0.25,
                  color: _textOnDark.withValues(alpha: 0.9),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _sectionTitle(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: _accent, size: 24.sp),
        Gap(8.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: BaseConst.fontBold,
              fontSize: 14.sp,
              height: 20 / 14,
              color: _accent,
            ),
          ),
        ),
      ],
    );
  }
}
