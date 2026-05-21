import 'package:base_core/res/extension.dart';
import 'package:base_core/res/widgets/text.dart';
import 'package:base_core/resources.dart' hide AppColors;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/theme/app_colors.dart';

class AppTitleBar extends StatelessWidget {
  final Color? bgColor;
  final Function() onTapBack;
  final String? title;
  final Widget? child;
  final bool isClose;
  final bool isShowBack;
  final EdgeInsets? padding;

  AppTitleBar({
    this.bgColor,
    this.child,
    this.title,
    this.isClose = false,
    this.isShowBack = true,
    this.padding,
    required this.onTapBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.h,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 12.w),
      color: bgColor,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          isShowBack
              ? Container(
                  height: double.infinity,
                  color: AppColors.transparent,
                  padding: EdgeInsets.only(right: 10.w),
                  child: SvgPicture.asset(
                    isClose ? Assets.commonIcClose : Assets.commonIcBack,
                    width: 24.w,
                  ),
                ).inkWell(
                  onTap: onTapBack,
                )
              : SizedBox(),
          child ??
              Align(
                alignment: Alignment.center,
                child: TextCs(
                  text: title ?? '',
                  style: AppFonts.large400,
                ),
              ),
        ],
      ),
    );
  }
}
