import 'package:flutter/material.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/rules/rules_models.dart';

/// Copy and structure for Figma `3:22428` [iOS] Thể lệ.
class RulesMockData {
  RulesMockData._();

  static const heroLevels = [
    RulesHeroLevel(
      tier: RulesHeroTier.newHero,
      requirementKey: 'rulesHeroNewRequirement',
      descriptionKey: 'rulesHeroNewDescription',
    ),
    RulesHeroLevel(
      tier: RulesHeroTier.risingHero,
      requirementKey: 'rulesHeroRisingRequirement',
      descriptionKey: 'rulesHeroRisingDescription',
    ),
    RulesHeroLevel(
      tier: RulesHeroTier.superHero,
      requirementKey: 'rulesHeroSuperRequirement',
      descriptionKey: 'rulesHeroSuperDescription',
    ),
    RulesHeroLevel(
      tier: RulesHeroTier.legendHero,
      requirementKey: 'rulesHeroLegendRequirement',
      descriptionKey: 'rulesHeroLegendDescription',
    ),
  ];

  static const saaIcons = [
    RulesSaaIcon(
      labelKey: 'rulesIconRevival',
      gradientColors: [0xFF1A2530, 0xFF4A3F6B],
    ),
    RulesSaaIcon(
      labelKey: 'rulesIconTouchOfLight',
      gradientColors: [0xFF3B4FD8, 0xFF8B5CF6],
    ),
    RulesSaaIcon(
      labelKey: 'rulesIconStayGold',
      gradientColors: [0xFFEA9E1A, 0xFFFFEA9E],
    ),
    RulesSaaIcon(
      labelKey: 'rulesIconFlowToHorizon',
      gradientColors: [0xFF0A4A5A, 0xFF5EEAD4],
    ),
    RulesSaaIcon(
      labelKey: 'rulesIconBeyondBoundary',
      gradientColors: [0xFFB91C4C, 0xFFFF6E60],
    ),
    RulesSaaIcon(
      labelKey: 'rulesIconRootFurther',
      imageAsset: Assets.homeHomeRootFurther,
      gradientColors: [0xFF092432, 0xFF1A3A2A],
    ),
  ];

  static List<Color> iconGradient(RulesSaaIcon icon) {
    final colors = icon.gradientColors ?? [0xFF323231, 0xFF1A2530];
    return colors.map((c) => Color(c)).toList();
  }
}
