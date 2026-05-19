import 'package:base_core/res/widgets/text.dart';
import 'package:base_core/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Dumb pill/chip widget. Caller passes [backgroundColor] and [foregroundColor].
class StatusPill extends StatelessWidget {
  const StatusPill({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
    this.fontSize,
    this.padding,
  });

  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final effectiveFontSize = fontSize ?? 12.sp;
    final effectivePadding = padding ?? EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h);

    return Container(
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextCs(
        text: text,
        style: AppFonts.small500.copyWith(
          color: foregroundColor,
          fontSize: effectiveFontSize,
        ),
      ),
    );
  }
}
