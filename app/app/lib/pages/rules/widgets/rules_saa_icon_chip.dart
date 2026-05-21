import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/pages/rules/rules_mock_data.dart';
import 'package:saa2025/pages/rules/rules_models.dart';
import 'package:saa2025/generated/app_localizations.dart';
import 'package:saa2025/theme/app_colors.dart';

/// Figma `Huy hiệu` row — 32px circle + 10px label.
class RulesSaaIconChip extends StatelessWidget {
  const RulesSaaIconChip({super.key, required this.icon, this.width});

  final RulesSaaIcon icon;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final label = _label(context);
    return SizedBox(
      width: width?.w,
      child: Column(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.textPrimary, width: 1),
              gradient: icon.imageAsset == null
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: RulesMockData.iconGradient(icon),
                    )
                  : null,
              image: icon.imageAsset != null
                  ? DecorationImage(
                      image: AssetImage(icon.imageAsset!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
          Gap(4.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: BaseConst.fontRegular,
              fontSize: 10.sp,
              height: 16 / 10,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  String _label(BuildContext context) {
    final tr = AppLocalizations.of(context);
    return switch (icon.labelKey) {
      'rulesIconRevival' => tr.rulesIconRevival,
      'rulesIconTouchOfLight' => tr.rulesIconTouchOfLight,
      'rulesIconStayGold' => tr.rulesIconStayGold,
      'rulesIconFlowToHorizon' => tr.rulesIconFlowToHorizon,
      'rulesIconBeyondBoundary' => tr.rulesIconBeyondBoundary,
      'rulesIconRootFurther' => tr.rulesIconRootFurther,
      _ => icon.labelKey,
    };
  }
}
