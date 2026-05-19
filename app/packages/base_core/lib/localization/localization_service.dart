import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LocalizationService with ListenableServiceMixin {
  Locale _locale = const Locale(BaseConst.defaultLangue);

  Locale get locale => _locale;

  bool get isEN => locale.languageCode == 'en';

  void setLocale(Locale newLocale) {
    if (_locale == newLocale) return;
    _locale = newLocale;
    notifyListeners();
  }
}
