import 'dart:async';

import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              color: Colors.transparent,
              child: Container(
                constraints: BoxConstraints(maxHeight: 280.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF00070C),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFF998C5F)),
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
                            color: isSelected ? const Color(0x1AFFEA9E) : Colors.transparent,
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
                              color: Colors.white,
                              shadows: isSelected
                                  ? [
                                      const Shadow(color: Color(0xFFFAE287), blurRadius: 6),
                                      const Shadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 4),
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

/// Bottom sheet chọn một option (filter, hashtag, phòng ban…) - deprecated, use showKudosDropdown.
@Deprecated('Use showKudosDropdown instead')
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
                  trailing: isSelected ? const Icon(Icons.check, color: Color(0xFFFFE99E)) : null,
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
