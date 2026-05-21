import 'package:flutter/material.dart';

class CustomSplashAnimation extends CustomPainter {
  final BuildContext context;
  double position, opacity;
  double width = 0.2;
  final Color color;
  final Alignment begin, end;

  CustomSplashAnimation({
    required this.context,
    required this.position,
    required this.color,
    required this.opacity,
    required this.begin,
    required this.end,
  });

  //Custom Painter to paint one frame of the animation. This is called in a loop to animate
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final stops = [
      // 0.0,
      position,
      (position + width) > 1 ? 1.0 : position + width,
      (position + (width * 1.5)) > 1 ? 1.0 : position + (width * 1.5),
      // 1.0
    ];
    // position = 0.7;
    paint.style = PaintingStyle.fill;
    paint.shader = LinearGradient(
      tileMode: TileMode.clamp,
      begin: begin,
      end: end,
      stops: stops,
      colors: [
        // AppColors.transparent,
        color.withValues(alpha: 0.2),
        color.withValues(alpha: opacity),
        color.withValues(alpha: 0.2),
        // AppColors.transparent,
      ],
    ).createShader(
      Rect.fromLTRB(
        size.width * -0.5,
        size.height * -.35,
        size.width * 1.5,
        size.height * 1.35,
      ),
    );
    // var path = Path();

    // path.lineTo(0, size.height);
    // path.lineTo(size.width, size.height);
    // path.lineTo(size.width, 0);
    // path.close();
    // canvas.drawPath(path, paint);
    canvas.drawPaint(paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
