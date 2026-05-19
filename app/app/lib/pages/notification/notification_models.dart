enum SaaNotificationType { kudos, award, system }

class SaaNotificationItem {
  const SaaNotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.timeLabel,
    required this.type,
    this.isRead = false,
  });

  final String id;
  final String title;
  final String body;
  final String timeLabel;
  final SaaNotificationType type;
  final bool isRead;

  SaaNotificationItem copyWith({bool? isRead}) {
    return SaaNotificationItem(
      id: id,
      title: title,
      body: body,
      timeLabel: timeLabel,
      type: type,
      isRead: isRead ?? this.isRead,
    );
  }
}
