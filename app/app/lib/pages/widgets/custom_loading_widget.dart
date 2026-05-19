import 'dart:math' as math;

import 'package:base_core/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoadingWidget extends StatefulWidget {
  const CustomLoadingWidget({super.key});

  @override
  State<CustomLoadingWidget> createState() => _CustomLoadingWidgetState();
}

class _CustomLoadingWidgetState extends State<CustomLoadingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _getActiveIndex(double value) {
    if (value < 0.33) {
      return 0;
    } else if (value < 0.66) {
      return 1;
    } else {
      return 2;
    }
  }

  double _getVerticalOffset(int index, double value) {
    final phase = index * 0.33;
    final adjustedValue = (value + phase) % 1.0;
    final radians = adjustedValue * 2 * math.pi;
    return 4.h * math.sin(radians);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final activeIndex = _getActiveIndex(_controller.value);
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(3, (index) {
              final isActive = index == activeIndex;
              final verticalOffset = _getVerticalOffset(index, _controller.value);
              return Transform.translate(
                offset: Offset(0, -verticalOffset),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.5.w),
                  width: 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive ? AppColors.greenBase : AppColors.skyBase,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
