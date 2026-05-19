part of '../resources.dart';

class AppShadows {
  AppShadows._();

  static const List<BoxShadow> smallShadow = [
    BoxShadow(color: Color(0x14141414), blurRadius: 8, offset: Offset(0, 0), spreadRadius: 0),
    BoxShadow(color: Color(0x0A141414), blurRadius: 1, offset: Offset(0, 0), spreadRadius: 0),
  ];
  static const List<BoxShadow> mediumShadow = [
    BoxShadow(color: Color(0x14141414), blurRadius: 8, offset: Offset(0, 0), spreadRadius: 2),
    BoxShadow(color: Color(0x14141414), blurRadius: 1, offset: Offset(0, 0), spreadRadius: 0),
  ];
  static const List<BoxShadow> largeShadow = [
    BoxShadow(color: Color(0x14141414), blurRadius: 24, offset: Offset(0, 0), spreadRadius: 8),
  ];
}
