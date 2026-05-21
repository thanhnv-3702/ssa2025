class KudoItem {
  const KudoItem({
    required this.id,
    required this.senderName,
    required this.receiverName,
    required this.title,
    required this.message,
    required this.postedAt,
    this.isAnonymous = false,
    this.senderAvatarAsset,
    this.receiverAvatarAsset,
    this.hashtags = const [],
    this.likeCount = 0,
    this.commentCount = 0,
  });

  final String id;
  final String senderName;
  final String receiverName;
  final String title;
  final String message;
  final String postedAt;
  final bool isAnonymous;
  final String? senderAvatarAsset;
  final String? receiverAvatarAsset;
  final List<String> hashtags;
  final int likeCount;
  final int commentCount;
}

class KudosStats {
  const KudosStats({
    required this.totalKudos,
    required this.totalReceivers,
    required this.totalSenders,
    required this.topReceivers,
  });

  final int totalKudos;
  final int totalReceivers;
  final int totalSenders;
  final List<String> topReceivers;
}

class SpotlightEntry {
  const SpotlightEntry({required this.name, required this.kudosCount});

  final String name;
  final int kudosCount;
}

/// Live activity line on the spotlight board (Figma `2038:4891`).
class SpotlightActivity {
  const SpotlightActivity({
    required this.time,
    required this.personName,
  });

  final String time;
  final String personName;
}

class SunnerProfile {
  const SunnerProfile({
    required this.id,
    required this.name,
    required this.department,
    this.avatarAsset,
    this.employeeCode,
    this.heroTitle,
    this.kudosReceived = 0,
    this.kudosSent = 0,
    this.badges = const [],
  });

  final String id;
  final String name;
  final String department;
  final String? avatarAsset;
  final String? employeeCode;
  final String? heroTitle;
  final int kudosReceived;
  final int kudosSent;
  final List<String> badges;
}

/// Draft kudo for preview before send.
class KudoDraft {
  const KudoDraft({
    required this.recipient,
    required this.title,
    required this.message,
    required this.hashtags,
    required this.isAnonymous,
    this.imageCount = 0,
  });

  final SunnerProfile recipient;
  final String title;
  final String message;
  final List<String> hashtags;
  final bool isAnonymous;
  final int imageCount;

  KudoItem toPreviewItem() {
    return KudoItem(
      id: 'preview',
      senderName: isAnonymous ? 'Ẩn danh' : 'Bạn',
      receiverName: recipient.name,
      title: title.toUpperCase(),
      message: message,
      postedAt: 'Vừa xong',
      isAnonymous: isAnonymous,
      receiverAvatarAsset: recipient.avatarAsset,
      hashtags: hashtags,
    );
  }
}

enum KudosFilterKind { period, hashtag, department }
