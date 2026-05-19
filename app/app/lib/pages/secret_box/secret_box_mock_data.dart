import 'package:saa2025/pages/secret_box/secret_box_models.dart';

class SecretBoxMockData {
  SecretBoxMockData._();

  static const initialUnopenedCount = 5;

  static const rewards = [
    SecretBoxReward(
      title: 'Huy hiệu Root Further',
      prizeLabel: 'Huy hiệu Root Further',
      description: 'Bạn đã nhận huy hiệu đặc biệt SAA 2025. Tiếp tục lan tỏa năng lượng tích cực!',
    ),
    SecretBoxReward(
      title: '+50 điểm Kudos',
      prizeLabel: '+50 điểm Kudos',
      description: 'Điểm thưởng đã được cộng vào tài khoản của bạn.',
    ),
    SecretBoxReward(
      title: 'Khăn Root Further',
      prizeLabel: 'Khăn Root Further',
      description: 'BTC sẽ liên hệ gửi quà đến bạn vào cuối sự kiện.',
    ),
  ];

  static List<SecretBoxActivityItem> initialActivities() => [
        const SecretBoxActivityItem(
          id: 'a1',
          type: SecretBoxActivityType.kudosReceived,
          body: 'Sunner Huỳnh Dương Xuân Nhật vừa gửi đến bạn lời ghi nhận đầy yêu thương!',
          timeLabel: '15 phút trước',
          isUnread: true,
        ),
        const SecretBoxActivityItem(
          id: 'a2',
          type: SecretBoxActivityType.kudosLiked,
          body: 'Wow! Lời nhắn gửi của bạn cho Sunner Nguyễn Văn A vừa nhận thêm lượt tim!',
          timeLabel: '1 giờ trước',
        ),
        const SecretBoxActivityItem(
          id: 'a3',
          type: SecretBoxActivityType.secretBoxEarned,
          body: 'Chúc mừng! Bạn vừa nhận được lượt mở Secret Box mới! Click vào đây để mở ngay nhé!',
          timeLabel: '1 ngày trước',
          isUnread: true,
        ),
        const SecretBoxActivityItem(
          id: 'a4',
          type: SecretBoxActivityType.levelUp,
          body:
              'Bạn nhận được 12 lời nhắn gửi từ đồng nghiệp và thăng hạng Silver!\n'
              'Tiếp tục lan tỏa năng lượng tích cực đến đồng nghiệp nhé!',
          timeLabel: '1 ngày trước',
        ),
        const SecretBoxActivityItem(
          id: 'a5',
          type: SecretBoxActivityType.kudosHidden,
          body:
              'Tiếc quá! Bạn có một lời nhắn bị tạm ẩn vì "vướng" một số tiêu chuẩn! '
              'Hãy xem các tiêu chuẩn và gửi lại cho đồng đội nhé!',
          timeLabel: '1 tháng trước',
          actionLabel: 'Tiêu chuẩn cộng đồng',
        ),
        const SecretBoxActivityItem(
          id: 'a6',
          type: SecretBoxActivityType.badgeComplete,
          body:
              'Chúc mừng bạn đã thu thập đủ 6 huy hiệu của SAA. '
              'Bạn đã nhận được phần quà từ BTC. BTC sẽ liên hệ để gửi quà đến bạn vào cuối sự kiện.',
          timeLabel: '2 tháng trước',
        ),
      ];
}
