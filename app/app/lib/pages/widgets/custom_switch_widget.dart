import 'package:base_core/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSwitchWidget extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final double? width;
  final double? height;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;

  const CustomSwitchWidget({
    super.key,
    required this.value,
    this.onChanged,
    this.width,
    this.height,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
  });

  @override
  State<CustomSwitchWidget> createState() => _CustomSwitchWidgetState();
}

class _CustomSwitchWidgetState extends State<CustomSwitchWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.value = widget.value ? 1.0 : 0.0;
  }

  @override
  void didUpdateWidget(CustomSwitchWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trackWidth = widget.width ?? 56.w;
    final trackHeight = widget.height ?? 32.h;
    final thumbSize = 28.w;
    final thumbMargin = 2.w;
    final maxThumbPosition = trackWidth - thumbSize - thumbMargin;

    final activeColor = widget.activeColor ?? AppColors.greenBase;
    final inactiveColor = widget.inactiveColor ?? AppColors.skyBase;
    final thumbColor = widget.thumbColor ?? AppColors.white;

    return GestureDetector(
      onTap: widget.onChanged != null
          ? () {
              widget.onChanged!(!widget.value);
            }
          : null,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final thumbPosition = _animation.value * maxThumbPosition + thumbMargin;
          final trackColor = Color.lerp(inactiveColor, activeColor, _animation.value) ?? inactiveColor;

          return Container(
            width: trackWidth,
            height: trackHeight,
            decoration: BoxDecoration(
              color: trackColor,
              borderRadius: BorderRadius.circular(trackHeight / 2),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: thumbPosition,
                  top: (trackHeight - thumbSize) / 2,
                  child: Container(
                    width: thumbSize,
                    height: thumbSize,
                    decoration: BoxDecoration(
                      color: thumbColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
