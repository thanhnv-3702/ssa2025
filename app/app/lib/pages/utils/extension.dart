import 'package:base_core/presenter/base_screen.dart';
import 'package:base_core/presenter/base_screen_state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:saa2025/generated/app_localizations.dart';
import 'package:intl/intl.dart';

extension BaseScreenExt on BaseScreen {
  AppLocalizations get tr => AppLocalizations.of(context);
}

extension BaseScreenStateExt on BaseScreenState {
  AppLocalizations get tr => AppLocalizations.of(context);
}

extension StringExt on String {
  bool isEmail() {
    return EmailValidator.validate(this);
  }
}

extension DateTimeExtension on DateTime {
  String toMMMddyyyy(BuildContext context) {
    final localizations = CupertinoLocalizations.of(context);
    final String monthName = localizations.datePickerMonth(month);
    return '$monthName/${day < 10 ? '0$day' : '$day'}/$year';
  }

  String toYYYYMMddSlash() {
    return '$year-${month < 10 ? '0$month' : '$month'}-${day < 10 ? '0$day' : '$day'}';
  }

  /// Format date as localized short weekday + month + day (e.g. "Mon, Dec 3" / "H, dec 3").
  String toAppointmentDate(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final weekdayStr = DateFormat('EEE', locale).format(this);
    final monthStr = DateFormat('MMM', locale).format(this);
    return '$weekdayStr, $monthStr $day';
  }
}

extension WidgetExt on Widget {
  Widget background(Color bgColor) {
    return Container(child: this, color: bgColor);
  }
}
