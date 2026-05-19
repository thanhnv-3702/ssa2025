class HomeCountdown {
  final int days;
  final int hours;
  final int minutes;

  const HomeCountdown({
    required this.days,
    required this.hours,
    required this.minutes,
  });

  static const zero = HomeCountdown(days: 0, hours: 0, minutes: 0);
}

class HomeAwardItem {
  final String title;
  final String description;
  final String imageAsset;

  const HomeAwardItem({
    required this.title,
    required this.description,
    required this.imageAsset,
  });
}
