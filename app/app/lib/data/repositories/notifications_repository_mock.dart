import 'package:saa2025/data/repositories/notifications_repository.dart';
import 'package:saa2025/pages/notification/notification_mock_data.dart';
import 'package:saa2025/pages/notification/notification_models.dart';

class NotificationsRepositoryMock implements NotificationsRepository {
  List<SaaNotificationItem> _items = NotificationMockData.initial();

  @override
  Future<List<SaaNotificationItem>> fetchNotifications() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return List.from(_items);
  }

  @override
  Future<int> unreadCount() async {
    final list = await fetchNotifications();
    return list.where((n) => !n.isRead).length;
  }

  void markRead(String id) {
    _items = _items.map((n) => n.id == id ? n.copyWith(isRead: true) : n).toList();
  }

  void markAllRead() {
    _items = _items.map((n) => n.copyWith(isRead: true)).toList();
  }
}
