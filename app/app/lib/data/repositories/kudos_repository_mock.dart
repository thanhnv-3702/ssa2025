import 'package:saa2025/data/models/kudos_hub_data.dart';
import 'package:saa2025/data/models/submit_kudo_result.dart';
import 'package:saa2025/data/repositories/kudos_repository.dart';
import 'package:saa2025/pages/kudos/kudos_mock_data.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';

class KudosRepositoryMock implements KudosRepository {
  @override
  SunnerProfile? get currentUser => KudosMockData.currentUser;

  @override
  Future<KudosHubData> fetchHub({
    String? period,
    String? hashtag,
    String? department,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    var highlights = List<KudoItem>.from(KudosMockData.highlights);
    if (hashtag != null && hashtag != 'Tất cả') {
      highlights = highlights.where((k) => k.hashtags.contains(hashtag)).toList();
    }
    if (department != null && department != 'Tất cả') {
      highlights = highlights
          .where(
            (k) => KudosMockData.sunners.any(
              (s) => (s.name == k.receiverName || s.name == k.senderName) && s.department == department,
            ),
          )
          .toList();
    }

    var spotlight = List<SpotlightEntry>.from(KudosMockData.spotlight);
    if (department != null && department != 'Tất cả') {
      spotlight = spotlight
          .where(
            (e) => KudosMockData.sunners.any((s) => s.name == e.name && s.department == department),
          )
          .toList();
    }

    return KudosHubData(
      stats: KudosMockData.stats,
      highlights: highlights,
      spotlight: spotlight,
      allKudos: KudosMockData.allKudos,
      periodFilters: KudosMockData.periodFilters,
      hashtagFilters: KudosMockData.hashtagFilters,
      departmentFilters: KudosMockData.departmentFilters,
    );
  }

  @override
  Future<List<SunnerProfile>> searchSunners(String query) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return KudosMockData.searchSunners(query);
  }

  @override
  Future<List<KudoItem>> kudosForSunner(String sunnerId) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return KudosMockData.kudosForSunner(sunnerId);
  }

  @override
  Future<SunnerProfile?> fetchSunnerProfile(String sunnerId) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    if (sunnerId == 'me' || sunnerId == KudosMockData.currentUser.id) {
      return KudosMockData.currentUser;
    }
    for (final s in KudosMockData.sunners) {
      if (s.id == sunnerId) return s;
    }
    return null;
  }

  @override
  Future<SubmitKudoResult> submitKudo(KudoDraft draft) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return SubmitKudoResult(
      success: true,
      kudoId: 'mock_kudo_${DateTime.now().millisecondsSinceEpoch}',
      message: 'Kudos sent',
    );
  }
}
