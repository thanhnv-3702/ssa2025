import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextCs extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color color;
  final double fontSize;
  final double letterSpacing;
  final TextOverflow? overflow;
  final double height;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final String? fontFamily;
  final int maxLines;
  final TextDecoration textDecoration;
  final Color decorationColor;

  const TextCs({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.overflow = TextOverflow.ellipsis,
    this.fontSize = 12.0,
    this.letterSpacing = 0.0,
    this.height = 0.0,
    this.fontWeight = FontWeight.w600,
    this.textAlign = TextAlign.start,
    this.maxLines = 1000,
    this.textDecoration = TextDecoration.none,
    this.decorationColor = Colors.black,
    this.fontFamily,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
      softWrap: true,
      style: style ??
          TextStyle(
            decorationColor: decorationColor,
            decoration: textDecoration,
            color: color,
            fontSize: fontSize.sp,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
            fontFamily: fontFamily,
          ),
    );
  }
}
