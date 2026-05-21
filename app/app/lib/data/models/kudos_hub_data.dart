import 'package:saa2025/pages/kudos/kudos_models.dart';

/// Aggregated Kudos hub payload (API or mock).
class KudosHubData {
  const KudosHubData({
    required this.stats,
    required this.highlights,
    required this.spotlight,
    required this.allKudos,
    this.spotlightActivities = const [],
    this.periodFilters = const [],
    this.hashtagFilters = const [],
    this.departmentFilters = const [],
  });

  final KudosStats stats;
  final List<KudoItem> highlights;
  final List<SpotlightEntry> spotlight;
  final List<SpotlightActivity> spotlightActivities;
  final List<KudoItem> allKudos;
  final List<String> periodFilters;
  final List<String> hashtagFilters;
  final List<String> departmentFilters;
}
