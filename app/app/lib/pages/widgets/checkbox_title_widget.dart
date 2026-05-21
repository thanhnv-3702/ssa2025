import 'package:base_core/res/widgets/text.dart';
import 'package:base_core/resources.dart' hide AppColors;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/theme/app_colors.dart';

/// A checkbox with optional internal padding and a title label.
class CheckBoxTitleWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String title;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? checkboxPadding;
  final double spacingBetweenCheckboxAndTitle;
  final Color? activeColor;

  const CheckBoxTitleWidget({
    super.key,
    required this.value,
    required this.title,
    this.onChanged,
    this.titleStyle,
    this.checkboxPadding,
    this.spacingBetweenCheckboxAndTitle = 12,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: Padding(
        padding: checkboxPadding ?? EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor: activeColor ?? AppColors.greenBase,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            Gap(spacingBetweenCheckboxAndTitle.w),
            Expanded(
              child: TextCs(
                text: title,
                style: titleStyle ?? AppFonts.small500.copyWith(color: AppColors.inkDarkest),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
