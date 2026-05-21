import 'dart:async';

import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saa2025/theme/app_colors.dart';

/// Dropdown menu overlay — MoMorph `mms_A_Dropdown-Hashtag` design.
Future<String?> showKudosDropdown({
  required BuildContext context,
  required GlobalKey buttonKey,
  required List<String> options,
  String? selected,
}) async {
  final RenderBox? renderBox = buttonKey.currentContext?.findRenderObject() as RenderBox?;
  if (renderBox == null) return null;

  final offset = renderBox.localToGlobal(Offset.zero);
  final size = renderBox.size;

  final completer = Completer<String?>();
  late final OverlayEntry overlayEntry;

  void closeDropdown([String? result]) {
    if (!completer.isCompleted) {
      completer.complete(result);
    }
    overlayEntry.remove();
  }

  overlayEntry = OverlayEntry(
    builder: (context) => GestureDetector(
      onTap: () => closeDropdown(),
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Positioned(
            left: offset.dx,
            top: offset.dy + size.height + 4.h,
            width: size.width,
            child: Material(
              color: AppColors.transparent,
              child: Container(
                constraints: BoxConstraints(maxHeight: 280.h),
                decoration: BoxDecoration(
                  color: AppColors.containerDark,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.borderMuted),
                ),
                padding: EdgeInsets.all(6.w),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: options.map((opt) {
                      final isSelected = opt == selected;
                      return GestureDetector(
                        onTap: () => closeDropdown(opt),
                        child: Container(
                          height: 40.h,
                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.accentSurface10 : AppColors.transparent,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            opt,
                            style: TextStyle(
                              fontFamily: isSelected ? BaseConst.fontBold : BaseConst.fontMedium,
                              fontSize: 14.sp,
                              height: 20 / 14,
                              letterSpacing: 0.1,
                              color: AppColors.textPrimary,
                              shadows: isSelected
                                  ? [
                                      const Shadow(color: AppColors.glowGold, blurRadius: 6),
                                      const Shadow(color: AppColors.shadowBlack25, offset: Offset(0, 4), blurRadius: 4),
                                    ]
                                  : null,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Overlay.of(context).insert(overlayEntry);

  return completer.future;
}

/// Bottom sheet for filters without an anchor button (e.g. period).
Future<String?> showKudosFilterBottomSheet({
  required BuildContext context,
  required String title,
  required List<String> options,
  String? selected,
}) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: AppColors.background,
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
                  color: AppColors.textPrimary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ...options.map(
              (opt) {
                final isSelected = opt == selected;
                return ListTile(
                  tileColor: isSelected ? AppColors.accentSurface10 : null,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: isSelected ? AppColors.borderMuted : AppColors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  title: Text(
                    opt,
                    style: TextStyle(
                      color: isSelected ? AppColors.accent : AppColors.textPrimary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  trailing: isSelected ? const Icon(Icons.check, color: AppColors.accent) : null,
                  onTap: () => Navigator.pop(ctx, opt),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}

/// Bottom sheet chọn một option — deprecated, use [showKudosDropdown] or [showKudosFilterBottomSheet].
@Deprecated('Use showKudosDropdown or showKudosFilterBottomSheet instead')
Future<String?> showKudosOptionSheet({
  required BuildContext context,
  required String title,
  required List<String> options,
  String? selected,
}) =>
    showKudosFilterBottomSheet(
      context: context,
      title: title,
      options: options,
      selected: selected,
    );
