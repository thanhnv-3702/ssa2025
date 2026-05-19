part of '../resources.dart';

class AppColors {
  AppColors._();

  static const black = Colors.black;
  static const white = Colors.white;
  static const main = Colors.transparent;
  static const transparent = Colors.transparent;

  static const Color inkDarkest = Color(0xFF090A0A);
  static const Color inkDarker = Color(0xFF202325);
  static const Color inkDark = Color(0xFF303437);
  static const Color inkBase = Color(0xFF404446);
  static const Color inkLight = Color(0xFF6C7072);
  static const Color inkLighter = Color(0xFF72777A);

  static const Color skyDark = Color(0xFF979C9E);
  static const Color skyBase = Color(0xFFCDCFD0);
  static const Color skyLight = Color(0xFFE3E5E5);
  static const Color skyLighter = Color(0xFFF2F4F5);
  static const Color skyLightest = Color(0xFFF7F9FA);
  static const Color skyWhite = Color(0xFFFFFFFF);

  // Card background colors
  static const Color cardBackground = Color(0xFFFDFFFC); // Card container background
  static const Color cardItemBackground = Color(0xFFF9FDF9); // Card item background

  static const Color cD8F7DB = Color(0xFFD8F7DB);
  static const Color cF2F4F5 = Color(0xFFF2F4F5);
  static const Color cFDFFFC = Color(0xFFFDFFFC);
  static const Color cF9FDF9 = Color(0xFFF9FDF9);
  static const Color greenDarkest = Color(0xFF198155);
  static const Color greenBase = Color(0xFF23C16B);
  static const Color greenLight = Color(0xFF4CD471);
  static const Color greenLighter = Color(0xFF7DDE86);
  static const Color greenLightest = Color(0xFFECFCE5);
  static const Color greenLightest2 = Color(0xFFF8FFF2);

  static const Color purpleDarkest = Color(0xFF5538EE);
  static const Color purpleBase = Color(0xFF6B4EFF);
  static const Color purpleLight = Color(0xFF9990FF);
  static const Color purpleLighter = Color(0xFFC6C4FF);
  static const Color purpleLightest = Color(0xFFE7E7FF);

  static const Color redDarkest = Color(0xFFD3180C);
  static const Color redBase = Color(0xFFFF5247);
  static const Color redLight = Color(0xFFFF6D6D);
  static const Color redLighter = Color(0xFFFF9898);
  static const Color redLightest = Color(0xFFFFE5E5);

  static const Color blueDarkest = Color(0xFF0065D0);
  static const Color blueBase = Color(0xFF48A7F8);
  static const Color blueLight = Color(0xFF6EC2FB);
  static const Color blueLighter = Color(0xFF9BDCFD);
  static const Color blueLightest = Color(0xFFC9F0FF);

  static const Color yellowDarkest = Color(0xFFA05E03);
  static const Color yellowBase = Color(0xFFFFB323);
  static const Color yellowLight = Color(0xFFFFC462);
  static const Color yellowLighter = Color(0xFFFFD188);
  static const Color yellowLightest = Color(0xFFFFEFD7);

  static const Gradient gradient6 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 100],
    colors: [
      skyWhite,
      purpleLightest,
    ],
  );
  static const Gradient gradient5 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 100],
    colors: [
      skyWhite,
      blueLightest,
    ],
  );
  static const Gradient gradient4 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      greenBase,
      greenLightest,
      skyWhite,
    ],
  );

  static const Gradient gradient3 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 100],
    colors: [
      white,
      greenLightest,
    ],
  );
  static const Gradient gradient2 = LinearGradient(
    end: Alignment.bottomCenter,
    begin: Alignment.topCenter,
    stops: [0, 100],
    colors: [
      greenLightest2,
      greenLightest,
    ],
  );
}
