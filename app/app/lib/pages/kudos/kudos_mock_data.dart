import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';

class KudosMockData {
  KudosMockData._();

  static const stats = KudosStats(
    totalKudos: 388,
    totalReceivers: 156,
    totalSenders: 142,
    topReceivers: [
      'Đỗ Hoàng Hiệp',
      'Dương Thúy An',
      'Mai Phương Thúy',
      'Nguyễn Văn Quy',
      'Lê Kiều Trang',
    ],
  );

  static const spotlight = [
    SpotlightEntry(name: 'Đỗ Hoàng Hiệp', kudosCount: 42),
    SpotlightEntry(name: 'Dương Thúy An', kudosCount: 38),
    SpotlightEntry(name: 'Mai Phương Thúy', kudosCount: 35),
    SpotlightEntry(name: 'Nguyễn Văn Quy', kudosCount: 31),
    SpotlightEntry(name: 'Lê Kiều Trang', kudosCount: 28),
    SpotlightEntry(name: 'Nguyễn Bá Chức', kudosCount: 24),
    SpotlightEntry(name: 'Nguyễn Hoàng Linh', kudosCount: 22),
  ];

  static final highlights = [
    KudoItem(
      id: '1',
      senderName: 'Nguyễn Văn A',
      receiverName: 'Trần Thị B',
      title: 'NGƯỜI HÙNG CỦA LÒNG EM',
      message:
          'Cảm ơn bạn đã luôn đồng hành và hỗ trợ team trong suốt dự án. Sự nhiệt huyết của bạn thật sự truyền cảm hứng!',
      postedAt: '10:00 - 10/30/2025',
      senderAvatarAsset: Assets.kudosKudosAvatar1,
      receiverAvatarAsset: Assets.kudosKudosAvatar2,
      hashtags: ['#teamwork', '#gratitude'],
      likeCount: 24,
      commentCount: 5,
    ),
    KudoItem(
      id: '2',
      senderName: 'Lê Văn C',
      receiverName: 'Phạm Thị D',
      title: 'NGƯỜI TRUYỀN ĐỘNG LỰC',
      message: 'Bạn luôn mang năng lượng tích cực đến mọi cuộc họp. Cảm ơn vì đã là người đồng đội tuyệt vời!',
      postedAt: '14:30 - 10/29/2025',
      senderAvatarAsset: Assets.kudosKudosAvatar2,
      receiverAvatarAsset: Assets.kudosKudosAvatar1,
      hashtags: ['#motivation'],
      likeCount: 18,
      commentCount: 3,
    ),
    KudoItem(
      id: '3',
      senderName: 'Ẩn danh',
      receiverName: 'Hoàng Văn E',
      title: 'CHIẾN BINH BẤT KHUẤT',
      message: 'Lời cảm ơn chân thành đến đồng đội đã cùng vượt qua deadline khó khăn nhất năm.',
      postedAt: '09:15 - 10/28/2025',
      isAnonymous: true,
      receiverAvatarAsset: Assets.kudosKudosAvatar1,
      hashtags: ['#deadline', '#team'],
      likeCount: 31,
      commentCount: 8,
    ),
  ];

  static final allKudos = [
    ...highlights,
    KudoItem(
      id: '4',
      senderName: 'Phạm Minh K',
      receiverName: 'Võ Thị L',
      title: 'NGÔI SAO SÁNG TẠO',
      message: 'Ý tưởng của bạn đã giúp team vượt qua rào cản kỹ thuật. Cảm ơn vì sự sáng tạo không ngừng!',
      postedAt: '16:45 - 10/27/2025',
      senderAvatarAsset: Assets.kudosKudosAvatar1,
      receiverAvatarAsset: Assets.kudosKudosAvatar2,
      hashtags: ['#creative', '#innovation'],
      likeCount: 12,
      commentCount: 2,
    ),
    KudoItem(
      id: '5',
      senderName: 'Trương Văn M',
      receiverName: 'Đinh Thị N',
      title: 'ĐỒNG ĐỘI ĐÁNG TIN CẬY',
      message: 'Luôn hoàn thành đúng cam kết và hỗ trợ mọi người khi cần. Bạn là chỗ dựa vững chắc của team.',
      postedAt: '11:20 - 10/26/2025',
      senderAvatarAsset: Assets.kudosKudosAvatar2,
      receiverAvatarAsset: Assets.kudosKudosAvatar1,
      hashtags: ['#reliable', '#team'],
      likeCount: 20,
      commentCount: 4,
    ),
    KudoItem(
      id: '6',
      senderName: 'Ẩn danh',
      receiverName: 'Bùi Văn P',
      title: 'TẤM LÒNG VÀNG',
      message: 'Cảm ơn bạn đã luôn lắng nghe và chia sẻ kinh nghiệm quý báu với mọi người trong team.',
      postedAt: '08:00 - 10/25/2025',
      isAnonymous: true,
      receiverAvatarAsset: Assets.kudosKudosAvatar2,
      hashtags: ['#mentor'],
      likeCount: 15,
      commentCount: 1,
    ),
    // Kudos for current user profile
    KudoItem(
      id: '7',
      senderName: 'Huỳnh Văn Sunner',
      receiverName: 'Đỗ Hoàng Hiệp',
      title: 'IDOL GIỚI TRẺ',
      message:
          'Cảm ơn người em bình thường nhưng phi thường :D Cảm ơn sự chăm chỉ, cần mẫn của em đã tạo động lực rất nhiều cho team, để luôn nhắc mình luôn phải nỗ lực hơn nữa trong công việc. <3 và cuộc sống',
      postedAt: '10:00 - 10/30/2025',
      senderAvatarAsset: Assets.kudosKudosAvatar1,
      receiverAvatarAsset: Assets.kudosKudosAvatar2,
      hashtags: ['#Dedicated', '#Inspiring'],
      likeCount: 1000,
      commentCount: 12,
    ),
    KudoItem(
      id: '8',
      senderName: 'Dương Thúy An',
      receiverName: 'Huỳnh Văn Sunner',
      title: 'NGƯỜI HÙNG CỦA LÒNG EM',
      message:
          'Cảm ơn anh đã luôn hỗ trợ và hướng dẫn em trong suốt thời gian qua. Kiến thức và kinh nghiệm của anh thật sự quý báu!',
      postedAt: '15:30 - 10/29/2025',
      senderAvatarAsset: Assets.kudosKudosAvatar2,
      receiverAvatarAsset: Assets.kudosKudosAvatar1,
      hashtags: ['#mentor', '#gratitude'],
      likeCount: 856,
      commentCount: 8,
    ),
    KudoItem(
      id: '9',
      senderName: 'Huỳnh Văn Sunner',
      receiverName: 'Mai Phương Thúy',
      title: 'NGÔI SAO SÁNG TẠO',
      message: 'Design của bạn đã làm nổi bật sản phẩm một cách tuyệt vời. Cảm ơn vì sự tỉ mỉ và sáng tạo!',
      postedAt: '09:15 - 10/28/2025',
      senderAvatarAsset: Assets.kudosKudosAvatar1,
      receiverAvatarAsset: Assets.kudosKudosAvatar2,
      hashtags: ['#creative', '#design'],
      likeCount: 642,
      commentCount: 5,
    ),
    KudoItem(
      id: '10',
      senderName: 'Nguyễn Văn Quy',
      receiverName: 'Huỳnh Văn Sunner',
      title: 'ĐỒNG ĐỘI ĐÁNG TIN CẬY',
      message:
          'Anh luôn sẵn sàng giúp đỡ và chia sẻ kinh nghiệm với team. Cảm ơn anh đã là người đồng đội tuyệt vời!',
      postedAt: '14:00 - 10/27/2025',
      senderAvatarAsset: Assets.kudosKudosAvatar2,
      receiverAvatarAsset: Assets.kudosKudosAvatar1,
      hashtags: ['#teamwork', '#reliable'],
      likeCount: 523,
      commentCount: 6,
    ),
    KudoItem(
      id: '11',
      senderName: 'Huỳnh Văn Sunner',
      receiverName: 'Lê Kiều Trang',
      title: 'NGƯỜI TRUYỀN ĐỘNG LỰC',
      message:
          'Năng lượng tích cực của bạn đã giúp team vượt qua những thời điểm khó khăn. Cảm ơn vì sự lạc quan!',
      postedAt: '11:30 - 10/26/2025',
      senderAvatarAsset: Assets.kudosKudosAvatar1,
      receiverAvatarAsset: Assets.kudosKudosAvatar2,
      hashtags: ['#motivation', '#positive'],
      likeCount: 412,
      commentCount: 4,
    ),
  ];

  static KudoItem? findById(String id) {
    try {
      return allKudos.firstWhere((k) => k.id == id);
    } catch (_) {
      return null;
    }
  }

  static const periodFilters = ['Tháng này', 'Tuần này', '3 tháng qua', 'Tất cả'];

  static const hashtagFilters = ['Tất cả', '#teamwork', '#gratitude', '#motivation', '#creative'];

  static const departmentFilters = ['Phòng ban', 'CEV', 'Engineering', 'Design', 'HR', 'Sales'];

  static const suggestedHashtags = [
    '#teamwork',
    '#gratitude',
    '#motivation',
    '#creative',
    '#reliable',
    '#mentor',
    '#deadline',
    '#innovation',
  ];

  static const recentSearches = ['Đỗ Hoàng Hiệp', 'Dương Thúy An', 'CEV'];

  static const currentUserId = 'me';

  static const currentUser = SunnerProfile(
    id: currentUserId,
    name: 'Huỳnh Văn Sunner',
    department: 'CEV',
    employeeCode: 'CECV01',
    avatarAsset: Assets.kudosKudosAvatar1,
    heroTitle: 'Legend Hero',
    kudosReceived: 42,
    kudosSent: 38,
    badges: ['🏆', '⭐', '💡', '🎯', '🔥', '❤️'],
  );

  static final sunners = [
    const SunnerProfile(
      id: 's1',
      name: 'Đỗ Hoàng Hiệp',
      department: 'CEV',
      employeeCode: 'CECV10',
      avatarAsset: Assets.kudosKudosAvatar1,
      heroTitle: 'Legend Hero',
      kudosReceived: 42,
      kudosSent: 35,
      badges: ['🏆', '⭐', '💡', '🎯', '🔥', '❤️'],
    ),
    const SunnerProfile(
      id: 's2',
      name: 'Dương Thúy An',
      department: 'Engineering',
      employeeCode: 'ENG042',
      avatarAsset: Assets.kudosKudosAvatar2,
      heroTitle: 'Tech Champion',
      kudosReceived: 38,
      kudosSent: 29,
      badges: ['💻', '⚡', '🌟'],
    ),
    const SunnerProfile(
      id: 's3',
      name: 'Mai Phương Thúy',
      department: 'Design',
      employeeCode: 'DSN018',
      avatarAsset: Assets.kudosKudosAvatar1,
      heroTitle: 'Creative Star',
      kudosReceived: 35,
      kudosSent: 31,
      badges: ['🎨', '✨'],
    ),
    const SunnerProfile(
      id: 's4',
      name: 'Nguyễn Văn Quy',
      department: 'CEV',
      employeeCode: 'CECV22',
      avatarAsset: Assets.kudosKudosAvatar2,
      heroTitle: 'Team Player',
      kudosReceived: 31,
      kudosSent: 27,
      badges: ['🤝', '⭐'],
    ),
    const SunnerProfile(
      id: 's5',
      name: 'Lê Kiều Trang',
      department: 'HR',
      employeeCode: 'HR007',
      avatarAsset: Assets.kudosKudosAvatar1,
      heroTitle: 'Culture Builder',
      kudosReceived: 28,
      kudosSent: 33,
      badges: ['❤️', '🌱'],
    ),
    const SunnerProfile(
      id: 's6',
      name: 'Nguyễn Bá Chức',
      department: 'Sales',
      employeeCode: 'SLS011',
      avatarAsset: Assets.kudosKudosAvatar2,
      heroTitle: 'Deal Maker',
      kudosReceived: 24,
      kudosSent: 22,
      badges: ['📈', '🔥'],
    ),
  ];

  static SunnerProfile? findSunnerById(String id) {
    if (id == currentUserId) return currentUser;
    try {
      return sunners.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<KudoItem> kudosForSunner(String sunnerId) {
    final profile = findSunnerById(sunnerId);
    if (profile == null) return [];
    return allKudos.where((k) => k.receiverName == profile.name || k.senderName == profile.name).toList();
  }

  static List<SunnerProfile> searchSunners(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return sunners;
    return sunners
        .where(
          (s) =>
              s.name.toLowerCase().contains(q) ||
              s.department.toLowerCase().contains(q) ||
              (s.employeeCode?.toLowerCase().contains(q) ?? false),
        )
        .toList();
  }

  static const communityStandardsIntro =
      'Sun* Kudos là không gian ghi nhận và cảm ơn đồng đội. Mọi lời gửi cần mang tính xây dựng, tôn trọng và chân thành.';

  static const communityStandardsRules = [
    'Ghi nhận cụ thể hành vi hoặc đóng góp thực tế.',
    'Không sử dụng ngôn từ xúc phạm, phân biệt hoặc quấy rối.',
    'Tôn trọng quyền riêng tư khi gửi ẩn danh.',
    'Hashtag phản ánh đúng nội dung lời cảm ơn.',
  ];

  static const privacyStandards = [
    'Thông tin người nhận chỉ hiển thị trong phạm vi công ty.',
    'Kudos ẩn danh không tiết lộ danh tính người gửi.',
    'Không chia sẻ nội dung Kudos ra bên ngoài khi chưa được phép.',
  ];
}
