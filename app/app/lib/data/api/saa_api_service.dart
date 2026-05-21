import 'package:https/vn/sun/https/data/remote/app_api.dart';
import 'package:https/vn/sun/https/inject/injection.dart';

/// Thin accessor for SAA REST endpoints on [AppAPI].
class SaaApiService {
  SaaApiService({AppAPI? api}) : _api = api ?? getIt<AppAPI>();

  final AppAPI _api;

  Future<Map<String, dynamic>> fetchKudosHub({
    String? period,
    String? hashtag,
    String? department,
  }) {
    final query = <String, dynamic>{};
    if (period != null && period.isNotEmpty) query['period'] = period;
    if (hashtag != null && hashtag.isNotEmpty) {
      query['hashtag'] = hashtag;
    }
    if (department != null && department.isNotEmpty) {
      query['department'] = department;
    }
    return _api.getKudosHub(query: query.isEmpty ? null : query);
  }

  Future<Map<String, dynamic>> fetchAwards() => _api.getAwards();

  Future<Map<String, dynamic>> fetchNotifications() => _api.getNotifications();

  Future<Map<String, dynamic>> submitKudo(Map<String, dynamic> body) => _api.postKudo(body: body);

  Future<Map<String, dynamic>> fetchSunnerProfile(String sunnerId) => _api.getSunnerProfile(sunnerId: sunnerId);

  Future<Map<String, dynamic>> fetchSunnerKudos(String sunnerId) => _api.getSunnerKudos(sunnerId: sunnerId);

  Future<Map<String, dynamic>> searchSunners(String query, {int limit = 50}) {
    return _api.searchSunners(query: query, limit: limit);
  }
}
