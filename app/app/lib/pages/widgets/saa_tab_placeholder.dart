import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaaTabPlaceholder extends StatelessWidget {
  const SaaTabPlaceholder({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFF00101A),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white70, fontSize: 16.sp),
        ),
      ),
    );
  }
}
