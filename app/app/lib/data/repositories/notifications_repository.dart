import 'package:saa2025/pages/notification/notification_models.dart';

abstract class NotificationsRepository {
  Future<List<SaaNotificationItem>> fetchNotifications();

  Future<int> unreadCount();
}
