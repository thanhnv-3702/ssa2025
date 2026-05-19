import 'package:saa2025/pages/awards/awards_models.dart';

class AwardsJsonParser {
  AwardsJsonParser._();

  static List<AwardItem> parseList(Map<String, dynamic> json) {
    final root = _unwrapData(json);
    final list = root['items'] ?? root['awards'] ?? root;
    if (list is! List) return [];
    return list.map((e) => _parseAward(e as Map<String, dynamic>)).toList();
  }

  static Map<String, dynamic> _unwrapData(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map<String, dynamic>) return data;
    if (data is List) return {'items': data};
    return json;
  }

  static AwardItem _parseAward(Map<String, dynamic> m) {
    final prizes = m['prize_values'] ?? m['prizeValues'];
    return AwardItem(
      id: m['id']?.toString() ?? '',
      title: m['title']?.toString() ?? '',
      displayTitle: m['display_title']?.toString() ?? m['displayTitle']?.toString() ?? m['title']?.toString() ?? '',
      subtitle: m['subtitle']?.toString() ?? '',
      longDescription: m['long_description']?.toString() ?? m['longDescription']?.toString() ?? '',
      imageAsset: m['image_asset']?.toString() ?? m['imageAsset']?.toString() ?? '',
      prizeQuantity: m['prize_quantity']?.toString() ?? m['prizeQuantity']?.toString() ?? '',
      prizeQuantityUnit: m['prize_quantity_unit']?.toString() ?? m['prizeQuantityUnit']?.toString() ?? '',
      prizeValues: _parsePrizes(prizes),
    );
  }

  static List<AwardPrizeValue> _parsePrizes(dynamic raw) {
    if (raw is! List) return [];
    return raw
        .map((e) {
          final m = e as Map<String, dynamic>;
          return AwardPrizeValue(
            amount: m['amount']?.toString() ?? '',
            suffix: m['suffix']?.toString() ?? '',
          );
        })
        .toList();
  }
}
