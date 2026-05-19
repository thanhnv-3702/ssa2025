import 'package:saa2025/data/models/kudos_hub_data.dart';
import 'package:saa2025/data/models/submit_kudo_result.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';

abstract class KudosRepository {
  Future<KudosHubData> fetchHub({
    String? period,
    String? hashtag,
    String? department,
  });

  Future<List<SunnerProfile>> searchSunners(String query);

  Future<List<KudoItem>> kudosForSunner(String sunnerId);

  Future<SunnerProfile?> fetchSunnerProfile(String sunnerId);

  Future<SubmitKudoResult> submitKudo(KudoDraft draft);

  SunnerProfile? get currentUser;
}
