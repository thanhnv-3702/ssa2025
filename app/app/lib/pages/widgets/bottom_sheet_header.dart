import 'package:base_core/res/extension.dart';
import 'package:base_core/res/widgets/text.dart';
import 'package:base_core/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saa2025/generated/assets.dart';

class BottomSheetHeader extends StatelessWidget {
  final bool showIcon;
  final String title;
  final TextAlign textAlign;
  final VoidCallback? onClose;

  const BottomSheetHeader({
    super.key,
    required this.title,
    this.onClose,
    this.showIcon = true,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        TextCs(
          text: title,
          textAlign: textAlign,
          style: AppFonts.large600.copyWith(
            color: AppColors.inkDarkest,
            fontSize: 20.sp,
          ),
        ),
        showIcon
            ? Align(
                child: SvgPicture.asset(
                  Assets.commonIcClose,
                  width: 24.w,
                  height: 24.w,
                ).inkWell(
                  onTap: onClose ?? () => Navigator.pop(context),
                ),
                alignment: Alignment.centerRight,
              )
            : SizedBox(),
      ],
    );
  }
}
