import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saa2025/theme/app_colors.dart';

class SaaTabPlaceholder extends StatelessWidget {
  const SaaTabPlaceholder({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: AppColors.white70, fontSize: 16.sp),
        ),
      ),
    );
  }
}
