import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

/// Bottom sheet chọn một option (filter, hashtag, phòng ban…).
Future<String?> showKudosOptionSheet({
  required BuildContext context,
  required String title,
  required List<String> options,
  String? selected,
}) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: const Color(0xFF00101A),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (ctx) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ...options.map(
              (opt) {
                final isSelected = opt == selected;
                return ListTile(
                  tileColor: isSelected ? const Color(0x1AFFEA9E) : null,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: isSelected ? const Color(0xFF998C5F) : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  title: Text(
                    opt,
                    style: TextStyle(
                      color: isSelected ? const Color(0xFFFFE99E) : Colors.white,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: Color(0xFFFFE99E))
                      : null,
                  onTap: () => Navigator.pop(ctx, opt),
                );
              },
            ),
            Gap(8.h),
          ],
        ),
      );
    },
  );
}
