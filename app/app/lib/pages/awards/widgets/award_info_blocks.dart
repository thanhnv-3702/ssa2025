import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/app_localizations.dart';
import 'package:saa2025/pages/awards/awards_models.dart';
import 'package:saa2025/pages/home/home_styles.dart';
import 'package:saa2025/theme/app_colors.dart';

/// Shared award copy blocks — MoMorph `D.*` award detail rows.
abstract final class AwardInfoBlocks {
  static Widget sectionTitle(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textPrimary, size: 24.sp),
        Gap(8.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: BaseConst.fontBold,
              fontSize: 14.sp,
              height: 20 / 14,
              color: AppColors.accentGold,
            ),
          ),
        ),
      ],
    );
  }

  static Widget descriptionBlock({
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(Icons.track_changes, title),
        Gap(12.h),
        Text(description, style: HomeStyles.bodyLight),
      ],
    );
  }

  static Widget prizeQuantityBlock(AppLocalizations tr, AwardItem award) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(Icons.diamond_outlined, tr.awardPrizeQuantityLabel),
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
                color: AppColors.textPrimary,
              ),
            ),
            Gap(4.w),
            Flexible(
              child: Text(
                award.prizeQuantityUnit,
                style: HomeStyles.bodyLight,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Widget prizeValueBlock(AppLocalizations tr, AwardPrizeValue value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(Icons.flag_outlined, tr.awardPrizeValueLabel),
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
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Gap(8.w),
            Flexible(child: Text(value.suffix, style: HomeStyles.bodyLight)),
          ],
        ),
      ],
    );
  }

  static Widget orDivider(AppLocalizations tr) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(child: Container(height: 1, color: AppColors.divider)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              tr.awardOrDivider,
              style: TextStyle(
                fontFamily: BaseConst.fontLight,
                fontSize: 14.sp,
                color: AppColors.textPrimary.withValues(alpha: 0.8),
              ),
            ),
          ),
          Expanded(child: Container(height: 1, color: AppColors.divider)),
        ],
      ),
    );
  }
}
