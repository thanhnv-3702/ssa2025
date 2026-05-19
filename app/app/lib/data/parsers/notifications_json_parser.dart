import 'package:saa2025/pages/notification/notification_models.dart';

class NotificationsJsonParser {
  NotificationsJsonParser._();

  static List<SaaNotificationItem> parseList(Map<String, dynamic> json) {
    final root = _unwrapData(json);
    final list = root['items'] ?? root['notifications'] ?? root;
    if (list is! List) return [];
    return list.whereType<Map>().map((e) => _parseItem(Map<String, dynamic>.from(e))).toList();
  }

  static Map<String, dynamic> _unwrapData(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map<String, dynamic>) return data;
    return json;
  }

  static SaaNotificationItem _parseItem(Map<String, dynamic> m) {
    return SaaNotificationItem(
      id: '${m['id'] ?? m['_id'] ?? ''}',
      title: '${m['title'] ?? ''}',
      body: '${m['body'] ?? m['message'] ?? ''}',
      timeLabel: '${m['time_label'] ?? m['timeLabel'] ?? m['created_at'] ?? ''}',
      type: _parseType('${m['type'] ?? m['category'] ?? ''}'),
      isRead: m['is_read'] == true || m['isRead'] == true || m['read'] == true,
    );
  }

  static SaaNotificationType _parseType(String raw) {
    final t = raw.toLowerCase();
    if (t.contains('award') || t.contains('giải')) return SaaNotificationType.award;
    if (t.contains('system') || t.contains('event') || t.contains('saa')) {
      return SaaNotificationType.system;
    }
    return SaaNotificationType.kudos;
  }
}
