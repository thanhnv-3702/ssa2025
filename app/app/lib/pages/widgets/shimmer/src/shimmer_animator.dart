import 'package:flutter/material.dart';
import 'package:saa2025/pages/widgets/shimmer/shimmer_animation.dart';

import 'custom_shimmer_animation.dart';

class ShimmerAnimator extends StatefulWidget {
  final Color color;
  final double opacity;
  final Duration duration;
  final Duration interval;
  final ShimmerDirection direction;
  final Widget child;

  ShimmerAnimator({
    required this.child,
    required this.color,
    required this.opacity,
    required this.duration,
    required this.interval,
    required this.direction,
  });

  @override
  State<ShimmerAnimator> createState() => _ShimmerAnimatorState();
}

//Animator state controls the animation using all the parameters defined
class _ShimmerAnimatorState extends State<ShimmerAnimator> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: widget.duration);
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    )..addListener(() async {
        if (controller.isCompleted) {
          controller.repeat();
        }

        setState(() {});
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: CustomSplashAnimation(
        context: context,
        position: animation.value,
        color: widget.color,
        opacity: widget.opacity,
        begin: widget.direction.begin,
        end: widget.direction.end,
      ),
      child: widget.child,
    );
  }
}
