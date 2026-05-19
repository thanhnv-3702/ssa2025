import 'package:base_core/common/config.dart';
import 'package:saa2025/config/api_config.dart';
import 'package:saa2025/data/api/saa_api_guard.dart';
import 'package:saa2025/data/api/saa_api_service.dart';
import 'package:saa2025/data/parsers/awards_json_parser.dart';
import 'package:saa2025/data/repositories/awards_repository.dart';
import 'package:saa2025/data/repositories/awards_repository_mock.dart';
import 'package:saa2025/pages/awards/awards_models.dart';

class AwardsRepositoryRemote implements AwardsRepository {
  AwardsRepositoryRemote({
    SaaApiService? api,
    AwardsRepositoryMock? fallback,
  })  : _api = api ?? SaaApiService(),
        _fallback = fallback ?? AwardsRepositoryMock();

  final SaaApiService _api;
  final AwardsRepositoryMock _fallback;

  @override
  Future<List<AwardItem>> fetchAwards() async {
    try {
      final json = await _api.fetchAwards();
      final list = AwardsJsonParser.parseList(json);
      if (list.isEmpty && ApiConfig.allowMockFallback) {
        logger.w('Awards API empty — mock fallback');
        return _fallback.fetchAwards();
      }
      return list;
    } catch (e, st) {
      if (SaaApiGuard.handleAuthErrors(e)) rethrow;
      logger.e('Awards API failed: $e', stackTrace: st);
      if (ApiConfig.allowMockFallback) return _fallback.fetchAwards();
      rethrow;
    }
  }
}
