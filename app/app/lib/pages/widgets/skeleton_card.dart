// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:saa2025/pages/widgets/shimmer/shimmer_animation.dart';
import 'package:saa2025/theme/app_colors.dart';

class SkeletonCard extends StatelessWidget {
  final double? width;
  final Axis? animAxis;
  final double height;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final bool animated;
  final Color? flashColor, backgroundColor;

  const SkeletonCard({
    super.key,
    this.width = double.infinity,
    this.margin,
    this.flashColor,
    this.backgroundColor,
    this.animAxis,
    required this.height,
    this.borderRadius,
    this.animated = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isHorizontal =
        animAxis == Axis.horizontal || MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      child: Container(
        margin: margin,
        width: width,
        height: height,
        child: animated
            ? Shimmer(
                color: flashColor ?? AppColors.skeletonFlash,
                colorOpacity: .7,
                duration: Duration(milliseconds: 1800),
                // interval: Duration(milliseconds: 500),
                direction: isHorizontal
                    ? ShimmerDirection(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )
                    : ShimmerDirection(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                child: SizedBox(
                  width: width,
                  height: height,
                ),
              )
            : SizedBox(
                width: width,
                height: height,
              ),
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          color: backgroundColor ?? AppColors.skeletonBackground,
        ),
      ),
    );
  }
}
