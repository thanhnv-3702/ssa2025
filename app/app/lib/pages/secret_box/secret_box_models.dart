enum SecretBoxVisualState {
  /// MoMorph `kQk65hSYF2` — box chưa mở.
  closed,

  /// MoMorph `KUmv414uC9` — đang mở / animation.
  opening,

  /// Hiển thị phần thưởng sau khi mở (mock).
  revealed,

  /// MoMorph Standby frames (`-LIblaeusT` … `xptNUunBS_`) — một state sau khi mở.
  standby,
}

enum SecretBoxActivityType {
  kudosReceived,
  kudosLiked,
  secretBoxEarned,
  levelUp,
  kudosHidden,
  kudosModerationReview,
  badgeComplete,
}

class SecretBoxReward {
  const SecretBoxReward({
    required this.title,
    required this.prizeLabel,
    required this.description,
  });

  final String title;
  final String prizeLabel;
  final String description;
}

class SecretBoxActivityItem {
  const SecretBoxActivityItem({
    required this.id,
    required this.type,
    required this.body,
    required this.timeLabel,
    this.isUnread = false,
    this.actionLabel,
    this.communityLinkAction = false,
  });

  final String id;
  final SecretBoxActivityType type;

  /// Body copy; use `\n` for multiple lines (Figma notification rows).
  final String body;
  final String timeLabel;
  final bool isUnread;
  final String? actionLabel;

  /// Underlined white link + trailing icon (Figma `Button tiêu chuẩn cộng đồng`).
  final bool communityLinkAction;
}
