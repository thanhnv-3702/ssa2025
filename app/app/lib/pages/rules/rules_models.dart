/// Hero tier pills on Rules screen (Figma `3:22473`).
enum RulesHeroTier {
  newHero,
  risingHero,
  superHero,
  legendHero,
}

class RulesHeroLevel {
  const RulesHeroLevel({
    required this.tier,
    required this.requirementKey,
    required this.descriptionKey,
  });

  final RulesHeroTier tier;

  /// `AppLocalizations` key for requirement line (Bold 14).
  final String requirementKey;

  /// `AppLocalizations` key for description (Regular 14).
  final String descriptionKey;
}

class RulesSaaIcon {
  const RulesSaaIcon({
    required this.labelKey,
    this.imageAsset,
    this.gradientColors,
  });

  final String labelKey;
  final String? imageAsset;
  final List<int>? gradientColors;
}
