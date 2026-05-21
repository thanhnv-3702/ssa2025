import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/app_localizations.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/theme/app_colors.dart';

/// Kudos promo block on award detail screens — MoMorph `mms_2.4_kudos`.
class AwardKudosPromo extends StatelessWidget {
  const AwardKudosPromo({super.key, required this.onDetailTap});

  final VoidCallback onDetailTap;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr.awardKudosPromoEyebrow,
          style: TextStyle(
            fontFamily: BaseConst.fontMedium,
            fontSize: 12.sp,
            color: AppColors.accent,
          ),
        ),
        Gap(4.h),
        Text(
          tr.awardKudosPromoTitle,
          style: TextStyle(
            fontFamily: BaseConst.fontSemiBold,
            fontSize: 20.sp,
            color: AppColors.textOnDark,
          ),
        ),
        Gap(16.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.asset(Assets.homeHomeKudosBanner, width: double.infinity, fit: BoxFit.cover),
        ),
        Gap(16.h),
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontFamily: BaseConst.fontLight,
              fontSize: 14.sp,
              height: 20 / 14,
              letterSpacing: 0.25,
              color: AppColors.textOnDark.withValues(alpha: 0.9),
            ),
            children: [
              TextSpan(
                text: tr.awardKudosPromoHighlightTitle,
                style: TextStyle(fontFamily: BaseConst.fontMedium),
              ),
              TextSpan(text: tr.awardKudosPromoBody),
            ],
          ),
        ),
        Gap(16.h),
        Material(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(4.r),
          child: InkWell(
            onTap: onDetailTap,
            borderRadius: BorderRadius.circular(4.r),
            child: SizedBox(
              width: double.infinity,
              height: 40.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tr.awardKudosPromoDetailsButton,
                    style: TextStyle(
                      fontFamily: BaseConst.fontMedium,
                      fontSize: 14.sp,
                      color: AppColors.background,
                    ),
                  ),
                  Gap(8.w),
                  SvgPicture.asset(Assets.homeHomeIcArrow, width: 20.w, height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
