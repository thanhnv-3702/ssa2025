import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/pages/awards/awards_models.dart';
import 'package:saa2025/pages/home/home_styles.dart';

/// Shared award copy blocks — MoMorph `D.*` award detail rows.
abstract final class AwardInfoBlocks {
  static Widget sectionTitle(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 24.sp),
        Gap(8.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: BaseConst.fontBold,
              fontSize: 14.sp,
              height: 20 / 14,
              color: HomeStyles.accent,
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

  static Widget prizeQuantityBlock(AwardItem award) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(Icons.diamond_outlined, 'Số lượng giải thưởng'),
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
                color: HomeStyles.textPrimary,
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

  static Widget prizeValueBlock(AwardPrizeValue value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(Icons.flag_outlined, 'Giá trị giải thưởng'),
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
                  color: HomeStyles.textPrimary,
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

  static Widget orDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(child: Container(height: 1, color: HomeStyles.divider)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              'Hoặc',
              style: TextStyle(
                fontFamily: BaseConst.fontLight,
                fontSize: 14.sp,
                color: HomeStyles.textPrimary.withValues(alpha: 0.8),
              ),
            ),
          ),
          Expanded(child: Container(height: 1, color: HomeStyles.divider)),
        ],
      ),
    );
  }
}
