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
  });

  final String id;
  final SecretBoxActivityType type;
  final String body;
  final String timeLabel;
  final bool isUnread;
  final String? actionLabel;
}
