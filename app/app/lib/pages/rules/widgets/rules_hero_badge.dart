import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saa2025/generated/app_localizations.dart';
import 'package:saa2025/pages/rules/rules_models.dart';
import 'package:saa2025/theme/app_colors.dart';

/// Figma `MM_MEDIA_Danh hiệu * Hero` — 16px pill on Rules screen.
class RulesHeroBadge extends StatelessWidget {
  const RulesHeroBadge({super.key, required this.tier});

  final RulesHeroTier tier;

  static const double _height = 16;
  static const double _minWidth = 92;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    return Container(
      height: _height.h,
      constraints: BoxConstraints(minWidth: _minWidth.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48.r),
        border: Border.all(color: AppColors.accentGold, width: 0.421),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.honorBadgeDark.withValues(alpha: 0.5),
                    AppColors.honorBadgeDark.withValues(alpha: 0.5),
                  ],
                ),
              ),
            ),
          ),
          Text.rich(
            TextSpan(children: _spans(tr)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  List<InlineSpan> _spans(AppLocalizations tr) {
    switch (tier) {
      case RulesHeroTier.newHero:
        return [
          _span(tr.rulesHonorNewPrefix, AppColors.textPrimary, bold: true),
          _span(tr.honorBadgeHeroSuffix, AppColors.textPrimary, bold: true),
        ];
      case RulesHeroTier.risingHero:
        return [
          _span(tr.honorBadgeRisingPrefix, AppColors.risingHero, bold: true),
          _span(tr.honorBadgeHeroSuffix, AppColors.textPrimary),
        ];
      case RulesHeroTier.superHero:
        return [
          _span(tr.rulesHonorSuperPrefix, const Color(0xFFFF6E60), bold: true),
          _span(' ', const Color(0xFFFF4F4F)),
          _span(tr.honorBadgeHeroSuffix, AppColors.textPrimary),
        ];
      case RulesHeroTier.legendHero:
        return [
          _span(tr.honorBadgeLegendPrefix, AppColors.accentGold, bold: true),
          _span(tr.honorBadgeHeroSuffix, AppColors.textPrimary),
        ];
    }
  }

  TextSpan _span(String text, Color color, {bool bold = false}) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontFamily: bold ? BaseConst.fontBold : BaseConst.fontRegular,
        fontSize: 9.6.sp,
        height: 13.7 / 9.6,
        letterSpacing: 0.08,
        color: color,
        shadows: tier == RulesHeroTier.risingHero || tier == RulesHeroTier.superHero
            ? [const Shadow(color: AppColors.black, blurRadius: 1.3)]
            : null,
      ),
    );
  }
}
