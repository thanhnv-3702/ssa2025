import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saa2025/theme/app_colors.dart';

/// Figma tokens for [iOS] Home (`6885:8978`).
abstract final class HomeStyles {
  static const String fontDigitalNumbers = 'DigitalNumbers';

  static TextStyle get comingSoon => TextStyle(
        fontFamily: BaseConst.fontLight,
        fontSize: 14.sp,
        height: 20 / 14,
        letterSpacing: 0.25,
        color: AppColors.textPrimary,
      );

  static TextStyle get countdownLabel => TextStyle(
        fontFamily: BaseConst.fontRegular,
        fontSize: 18.sp,
        height: 24 / 18,
        letterSpacing: 0.5,
        color: AppColors.textPrimary,
      );

  static TextStyle get countdownDigit => TextStyle(
        fontFamily: fontDigitalNumbers,
        fontSize: 32.sp,
        height: 35 / 32,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      );

  static TextStyle get infoLabel => TextStyle(
        fontFamily: BaseConst.fontLight,
        fontSize: 14.sp,
        height: 20 / 14,
        letterSpacing: 0.25,
        color: AppColors.textPrimary,
      );

  static TextStyle get infoValue => TextStyle(
        fontFamily: BaseConst.fontRegular,
        fontSize: 18.sp,
        height: 24 / 18,
        letterSpacing: 0.5,
        color: AppColors.accentGold,
      );

  static TextStyle get bodyLight => TextStyle(
        fontFamily: BaseConst.fontLight,
        fontSize: 14.sp,
        height: 20 / 14,
        letterSpacing: 0.25,
        color: AppColors.textPrimary,
      );

  static TextStyle get kudosNoteTitle => TextStyle(
        fontFamily: BaseConst.fontSemiBold,
        fontSize: 14.sp,
        height: 20 / 14,
        letterSpacing: 0.25,
        color: AppColors.textPrimary,
      );

  static TextStyle get buttonLabel => TextStyle(
        fontFamily: BaseConst.fontMedium,
        fontSize: 14.sp,
        height: 20 / 14,
        color: AppColors.background,
      );

  static TextStyle get buttonLabelOutline => TextStyle(
        fontFamily: BaseConst.fontMedium,
        fontSize: 14.sp,
        height: 20 / 14,
        color: AppColors.textPrimary,
      );

  static TextStyle get sectionEyebrow => TextStyle(
        fontFamily: BaseConst.fontRegular,
        fontSize: 12.sp,
        height: 16 / 12,
        color: AppColors.textPrimary,
      );

  static TextStyle get sectionTitle => TextStyle(
        fontFamily: BaseConst.fontMedium,
        fontSize: 22.sp,
        height: 28 / 22,
        color: AppColors.accentGold,
      );

  static TextStyle get awardTitle => TextStyle(
        fontFamily: BaseConst.fontMedium,
        fontSize: 14.sp,
        height: 20 / 14,
        color: AppColors.accentGold,
      );

  static TextStyle get linkLabel => TextStyle(
        fontFamily: BaseConst.fontMedium,
        fontSize: 14.sp,
        height: 20 / 14,
        color: AppColors.textPrimary,
      );

  static TextStyle get languageCode => TextStyle(
        fontFamily: BaseConst.fontMedium,
        fontSize: 14.sp,
        height: 20 / 14,
        color: AppColors.textPrimary,
      );
}
