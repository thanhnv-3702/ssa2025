class AwardPrizeValue {
  const AwardPrizeValue({
    required this.amount,
    required this.suffix,
  });

  final String amount;
  final String suffix;
}

class AwardItem {
  const AwardItem({
    required this.id,
    required this.title,
    required this.displayTitle,
    required this.subtitle,
    required this.longDescription,
    required this.imageAsset,
    required this.prizeQuantity,
    required this.prizeQuantityUnit,
    required this.prizeValues,
  });

  final String id;
  final String title;
  /// Section heading on detail (may differ from card title).
  final String displayTitle;
  final String subtitle;
  final String longDescription;
  final String imageAsset;
  final String prizeQuantity;
  final String prizeQuantityUnit;
  final List<AwardPrizeValue> prizeValues;
}
