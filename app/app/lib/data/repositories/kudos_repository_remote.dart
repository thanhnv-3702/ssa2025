import 'package:base_core/common/config.dart';
import 'package:saa2025/config/api_config.dart';
import 'package:saa2025/data/api/saa_api_guard.dart';
import 'package:saa2025/data/api/saa_api_service.dart';
import 'package:saa2025/data/kudo_submit_mapper.dart';
import 'package:saa2025/data/models/kudos_hub_data.dart';
import 'package:saa2025/data/models/submit_kudo_result.dart';
import 'package:saa2025/data/parsers/kudos_json_parser.dart';
import 'package:saa2025/data/repositories/kudos_repository.dart';
import 'package:saa2025/data/repositories/kudos_repository_mock.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';

class KudosRepositoryRemote implements KudosRepository {
  KudosRepositoryRemote({
    SaaApiService? api,
    KudosRepositoryMock? fallback,
  })  : _api = api ?? SaaApiService(),
        _fallback = fallback ?? KudosRepositoryMock();

  final SaaApiService _api;
  final KudosRepositoryMock _fallback;
  SunnerProfile? _cachedCurrentUser;

  @override
  SunnerProfile? get currentUser => _cachedCurrentUser ?? _fallback.currentUser;

  @override
  Future<KudosHubData> fetchHub({
    String? period,
    String? hashtag,
    String? department,
  }) async {
    try {
      final json = await _api.fetchKudosHub(
        period: period,
        hashtag: hashtag,
        department: department,
      );
      final hub = KudosJsonParser.parseHub(json);
      final me = KudosJsonParser.parseProfile(json);
      if (me != null) _cachedCurrentUser = me;
      if (hub.highlights.isEmpty && hub.stats.totalKudos == 0) {
        if (ApiConfig.allowMockFallback) {
          logger.w('Kudos hub API empty — using mock fallback');
          return _fallback.fetchHub(period: period, hashtag: hashtag, department: department);
        }
      }
      return hub;
    } catch (e, st) {
      if (SaaApiGuard.handleAuthErrors(e)) rethrow;
      logger.e('Kudos hub API failed: $e', stackTrace: st);
      if (ApiConfig.allowMockFallback) {
        return _fallback.fetchHub(period: period, hashtag: hashtag, department: department);
      }
      rethrow;
    }
  }

  @override
  Future<List<SunnerProfile>> searchSunners(String query) async {
    try {
      if (query.trim().isEmpty) {
        if (ApiConfig.allowMockFallback) return _fallback.searchSunners(query);
        return <SunnerProfile>[];
      }
      final json = await _api.searchSunners(query.trim());
      final list = KudosJsonParser.parseSunners(json);
      if (list.isEmpty && ApiConfig.allowMockFallback) {
        return _fallback.searchSunners(query);
      }
      return list;
    } catch (e) {
      if (SaaApiGuard.handleAuthErrors(e)) rethrow;
      logger.w('Sunner search API failed: $e');
      if (ApiConfig.allowMockFallback) return _fallback.searchSunners(query);
      rethrow;
    }
  }

  @override
  Future<List<KudoItem>> kudosForSunner(String sunnerId) async {
    try {
      final json = await _api.fetchSunnerKudos(sunnerId);
      final list = KudosJsonParser.parseKudoList(json);
      if (list.isEmpty && ApiConfig.allowMockFallback) {
        return _fallback.kudosForSunner(sunnerId);
      }
      return list;
    } catch (e, st) {
      if (SaaApiGuard.handleAuthErrors(e)) rethrow;
      logger.e('Sunner kudos API failed: $e', stackTrace: st);
      if (ApiConfig.allowMockFallback) return _fallback.kudosForSunner(sunnerId);
      rethrow;
    }
  }

  @override
  Future<SunnerProfile?> fetchSunnerProfile(String sunnerId) async {
    try {
      final id = sunnerId == 'me' ? (currentUser?.id ?? 'me') : sunnerId;
      final json = await _api.fetchSunnerProfile(id);
      final profile = KudosJsonParser.parseProfile(json);
      if (profile == null && ApiConfig.allowMockFallback) {
        return _fallback.fetchSunnerProfile(sunnerId);
      }
      if (sunnerId == 'me' && profile != null) _cachedCurrentUser = profile;
      return profile;
    } catch (e, st) {
      if (SaaApiGuard.handleAuthErrors(e)) rethrow;
      logger.e('Sunner profile API failed: $e', stackTrace: st);
      if (ApiConfig.allowMockFallback) return _fallback.fetchSunnerProfile(sunnerId);
      rethrow;
    }
  }

  @override
  Future<SubmitKudoResult> submitKudo(KudoDraft draft) async {
    try {
      final json = await _api.submitKudo(KudoSubmitMapper.toJson(draft));
      return KudosJsonParser.parseSubmitResult(json);
    } catch (e, st) {
      if (SaaApiGuard.handleAuthErrors(e)) rethrow;
      logger.e('Submit kudo API failed: $e', stackTrace: st);
      if (ApiConfig.allowMockFallback) return _fallback.submitKudo(draft);
      rethrow;
    }
  }
}
