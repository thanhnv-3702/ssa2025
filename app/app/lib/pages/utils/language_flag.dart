import 'package:saa2025/generated/assets.dart';

/// Flag SVG for language chip (`EN` → [Assets.flagsEn], `VN`/`JA` → [Assets.flagsVn]).
String languageFlagAsset(String languageCode) {
  if (languageCode == 'EN') return Assets.flagsEn;
  return Assets.flagsVn;
}
