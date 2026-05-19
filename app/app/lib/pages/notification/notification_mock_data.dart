import 'package:saa2025/pages/notification/notification_models.dart';

class NotificationMockData {
  NotificationMockData._();

  static List<SaaNotificationItem> initial() => [
        const SaaNotificationItem(
          id: '1',
          title: 'Bạn nhận được Kudos mới',
          body: 'Nguyễn Văn A đã gửi lời cảm ơn đến bạn.',
          timeLabel: '5 phút trước',
          type: SaaNotificationType.kudos,
        ),
        const SaaNotificationItem(
          id: '2',
          title: 'Đề cử Top Talent',
          body: 'Bạn được đề cử hạng mục Top Talent — hãy xem chi tiết.',
          timeLabel: '2 giờ trước',
          type: SaaNotificationType.award,
        ),
        const SaaNotificationItem(
          id: '3',
          title: 'SAA 2025 sắp diễn ra',
          body: 'Sự kiện Sun* Annual Awards 2025 sẽ diễn ra vào 26/12/2025.',
          timeLabel: 'Hôm qua',
          type: SaaNotificationType.system,
          isRead: true,
        ),
      ];
}
