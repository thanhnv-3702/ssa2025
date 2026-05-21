import 'package:base_core/res/widgets/text.dart';
import 'package:base_core/resources.dart' hide AppColors;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/theme/app_colors.dart';

class InfoRowWidget extends StatelessWidget {
  final String label;
  final String? value;
  final double? labelWidth;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final double? gap;

  const InfoRowWidget({
    super.key,
    required this.label,
    required this.value,
    this.labelWidth,
    this.labelStyle,
    this.valueStyle,
    this.gap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: labelWidth ?? 100.w,
          child: TextCs(
            text: label,
            style: labelStyle ??
                AppFonts.small500.copyWith(
                  color: AppColors.inkLight,
                  fontSize: 12.sp,
                ),
          ),
        ),
        if (gap != null) Gap(gap!),
        Expanded(
          child: TextCs(
            text: value ?? '',
            style: valueStyle ??
                AppFonts.small500.copyWith(
                  color: AppColors.inkDarkest,
                  fontSize: 12.sp,
                ),
          ),
        ),
      ],
    );
  }
}
