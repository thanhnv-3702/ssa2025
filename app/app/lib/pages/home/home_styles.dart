import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Figma tokens for [iOS] Home (`6885:8978`).
abstract final class HomeStyles {
  static const String fontDigitalNumbers = 'DigitalNumbers';

  static const Color background = Color(0xFF00101A);
  static const Color accent = Color(0xFFFFEA9E);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFF2E3940);
  static const Color borderMuted = Color(0xFF998C5F);
  static const Color notificationDot = Color(0xFFD4271D);
  static const Color accentSurface10 = Color(0x1AFFEA9E);

  static TextStyle get comingSoon => TextStyle(
        fontFamily: BaseConst.fontLight,
        fontSize: 14.sp,
        height: 20 / 14,
        letterSpacing: 0.25,
        color: textPrimary,
      );

  static TextStyle get countdownLabel => TextStyle(
        fontFamily: BaseConst.fontRegular,
        fontSize: 18.sp,
        height: 24 / 18,
        letterSpacing: 0.5,
        color: textPrimary,
      );

  static TextStyle get countdownDigit => TextStyle(
        fontFamily: fontDigitalNumbers,
        fontSize: 32.sp,
        height: 35 / 32,
        letterSpacing: 0,
        color: textPrimary,
      );

  static TextStyle get infoLabel => TextStyle(
        fontFamily: BaseConst.fontLight,
        fontSize: 14.sp,
        height: 20 / 14,
        letterSpacing: 0.25,
        color: textPrimary,
      );

  static TextStyle get infoValue => TextStyle(
        fontFamily: BaseConst.fontRegular,
        fontSize: 18.sp,
        height: 24 / 18,
        letterSpacing: 0.5,
        color: accent,
      );

  static TextStyle get bodyLight => TextStyle(
        fontFamily: BaseConst.fontLight,
        fontSize: 14.sp,
        height: 20 / 14,
        letterSpacing: 0.25,
        color: textPrimary,
      );

  static TextStyle get kudosNoteTitle => TextStyle(
        fontFamily: BaseConst.fontSemiBold,
        fontSize: 14.sp,
        height: 20 / 14,
        letterSpacing: 0.25,
        color: textPrimary,
      );

  static TextStyle get buttonLabel => TextStyle(
        fontFamily: BaseConst.fontMedium,
        fontSize: 14.sp,
        height: 20 / 14,
        color: background,
      );

  static TextStyle get buttonLabelOutline => TextStyle(
        fontFamily: BaseConst.fontMedium,
        fontSize: 14.sp,
        height: 20 / 14,
        color: textPrimary,
      );

  static TextStyle get sectionEyebrow => TextStyle(
        fontFamily: BaseConst.fontRegular,
        fontSize: 12.sp,
        height: 16 / 12,
        color: textPrimary,
      );

  static TextStyle get sectionTitle => TextStyle(
        fontFamily: BaseConst.fontMedium,
        fontSize: 22.sp,
        height: 28 / 22,
        color: accent,
      );

  static TextStyle get awardTitle => TextStyle(
        fontFamily: BaseConst.fontMedium,
        fontSize: 14.sp,
        height: 20 / 14,
        color: accent,
      );

  static TextStyle get linkLabel => TextStyle(
        fontFamily: BaseConst.fontMedium,
        fontSize: 14.sp,
        height: 20 / 14,
        color: textPrimary,
      );

  static TextStyle get languageCode => TextStyle(
        fontFamily: BaseConst.fontMedium,
        fontSize: 14.sp,
        height: 20 / 14,
        color: textPrimary,
      );
}
