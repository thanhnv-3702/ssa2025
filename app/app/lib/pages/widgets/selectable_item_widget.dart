import 'package:base_core/res/extension.dart';
import 'package:base_core/res/widgets/text.dart';
import 'package:base_core/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectableItemWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const SelectableItemWidget({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: padding ?? EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.greenLightest : AppColors.white,
        border: Border.all(
          color: isSelected ? AppColors.greenBase : AppColors.skyLighter,
          width: isSelected ? 2.w : 1.w,
        ),
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextCs(
              text: text,
              style: AppFonts.regular400.copyWith(
                color: isSelected ? AppColors.inkDarkest : AppColors.inkLighter,
              ),
            ),
          ),
        ],
      ),
    ).inkWell(
      onTap: onTap,
    );
  }
}
