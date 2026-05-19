import 'package:base_core/common/config.dart';
import 'package:saa2025/config/api_config.dart';
import 'package:saa2025/data/api/saa_api_guard.dart';
import 'package:saa2025/data/api/saa_api_service.dart';
import 'package:saa2025/data/parsers/notifications_json_parser.dart';
import 'package:saa2025/data/repositories/notifications_repository.dart';
import 'package:saa2025/data/repositories/notifications_repository_mock.dart';
import 'package:saa2025/pages/notification/notification_models.dart';

class NotificationsRepositoryRemote implements NotificationsRepository {
  NotificationsRepositoryRemote({
    SaaApiService? api,
    NotificationsRepositoryMock? fallback,
  })  : _api = api ?? SaaApiService(),
        _fallback = fallback ?? NotificationsRepositoryMock();

  final SaaApiService _api;
  final NotificationsRepositoryMock _fallback;

  @override
  Future<List<SaaNotificationItem>> fetchNotifications() async {
    try {
      final json = await _api.fetchNotifications();
      final list = NotificationsJsonParser.parseList(json);
      if (list.isEmpty && ApiConfig.allowMockFallback) {
        return _fallback.fetchNotifications();
      }
      return list;
    } catch (e, st) {
      if (SaaApiGuard.handleAuthErrors(e)) rethrow;
      logger.e('Notifications API failed: $e', stackTrace: st);
      if (ApiConfig.allowMockFallback) return _fallback.fetchNotifications();
      rethrow;
    }
  }

  @override
  Future<int> unreadCount() async {
    final list = await fetchNotifications();
    return list.where((n) => !n.isRead).length;
  }
}
