import 'package:base_core/res/widgets/text.dart';
import 'package:base_core/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final Color? shadowColor;
  final double? minWidth;
  final double? height;
  final TextStyle? textStyle;
  final double? elevation;
  final double? horizontalPadding;
  final double? verticalPadding;

  const AppElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.foregroundColor,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.shadowColor,
    this.minWidth,
    this.height,
    this.textStyle,
    this.elevation,
    this.horizontalPadding,
    this.verticalPadding,
  });

  static const double _defaultHeight = 48.0;
  static const double _defaultHorizontalPadding = 16.0;
  static const double _defaultElevation = 0.0; // StadiumBorder usually looks better without elevation

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.greenBase,
        foregroundColor: foregroundColor ?? Colors.white,
        splashFactory: NoSplash.splashFactory,
        disabledBackgroundColor:
            disabledBackgroundColor ?? (backgroundColor ?? AppColors.greenBase).withValues(alpha: 0.5),
        disabledForegroundColor: disabledForegroundColor ?? Colors.white.withValues(alpha: 0.6),
        shadowColor: shadowColor,
        elevation: elevation ?? _defaultElevation,
        padding: EdgeInsets.symmetric(
          horizontal: (horizontalPadding ?? _defaultHorizontalPadding).w,
          vertical: (verticalPadding ?? 0).h,
        ),
        minimumSize: Size(
          minWidth ?? 0,
          (height ?? _defaultHeight).h,
        ),
        shape: const StadiumBorder(),
      ),
      child: isLoading
          ? SizedBox(
              height: 20.h,
              width: 20.h,
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
                strokeCap: StrokeCap.round,
              ),
            )
          : TextCs(
              text: title,
              style: textStyle ??
                  AppFonts.title3.copyWith(
                    color: foregroundColor,
                  ),
            ),
    );
  }
}
