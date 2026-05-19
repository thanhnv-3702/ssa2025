import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

/// Figma filter chip — `rgba(255,234,158,0.10)` fill, border `#998C5F`.
class KudosFilterDropdown extends StatelessWidget {
  const KudosFilterDropdown({
    super.key,
    required this.label,
    required this.onTap,
    this.width,
  });

  final String label;
  final VoidCallback onTap;
  final double? width;

  static const Color _border = Color(0xFF998C5F);
  static const Color _fill = Color(0x1AFFEA9E);
  static const Color _text = Color(0xFFFFE99E);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4.r),
        child: Container(
          width: width ?? 129.w,
          height: 40.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: _fill,
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: _border, width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: _text, fontSize: 13.sp, fontWeight: FontWeight.w500),
                ),
              ),
              Gap(4.w),
              Icon(Icons.keyboard_arrow_down, color: _text, size: 18.sp),
            ],
          ),
        ),
      ),
    );
  }
}
