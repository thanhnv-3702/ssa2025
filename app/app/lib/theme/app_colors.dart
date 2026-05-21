import 'package:flutter/material.dart';

/// SAA 2025 design palette — single source of truth for app colors.
abstract final class AppColors {
  AppColors._();

  // --- Backgrounds ---
  static const Color background = Color(0xFF00101A);
  static const Color backgroundTransparent = Color(0x0000101A);
  static const Color containerDark = Color(0xFF00070C);
  static const Color fieldBackground = Color(0xFF0A1F2E);
  static const Color surfaceDark = Color(0xFF1A2530);
  static const Color avatarPlaceholder = Color(0xFF1A3A4A);
  static const Color panelOverlay = Color(0x9900070C);

  // --- Accent / gold ---
  static const Color accent = Color(0xFFFFE99E);
  static const Color accentGold = Color(0xFFFFEA9E);
  static const Color accentOrange = Color(0xFFEA9E1A);
  static const Color glowGold = Color(0xFFFAE287);
  static const Color beige = Color(0xFFDBD1C1);

  /// 10% accent fill (`#1A` alpha).
  static const Color accentSurface10 = Color(0x1AFFEA9E);

  /// 15% accent tint (bottom nav bar).
  static const Color accentSurface15 = Color(0x26FFEA9E);

  /// 20% accent border.
  static const Color accentBorder20 = Color(0x33FFE99E);

  /// 40% accent (kudos message highlight).
  static const Color accentHighlight40 = Color(0x66FFEA9E);

  // --- Text ---
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textOnDark = textPrimary;
  static const Color textMuted = Color(0xB3FFFFFF);
  static const Color textBlack = background;
  static const Color gray = Color(0xFF999999);

  // --- Borders & dividers ---
  static const Color divider = Color(0xFF2E3940);
  static const Color borderMuted = Color(0xFF998C5F);
  static const Color borderWhite8 = Color(0x14FFFFFF);

  // --- Semantic ---
  static const Color communityLink = Color(0xFFE46060);
  static const Color error = Color(0xFFD4271D);
  static const Color errorMaterial = Color(0xFFE53935);
  static const Color errorBannerBackground = Color(0x33E53935);
  static const Color notificationDot = error;
  static const Color unreadDot = error;
  static const Color risingHero = Color(0xFFCDFF60);
  static const Color likeActive = errorMaterial;

  // --- Kudos cards ---
  static const Color kudosCardBackground = Color(0xFFFFF8E1);
  static const Color kudosCardBorder = accentGold;
  static const Color kudosCardAvatar = Color(0xFFE8E0C8);
  static const Color kudosHighlightSurface = kudosCardBackground;

  // --- Honor badge ---
  static const Color honorBadgeDark = Color(0xFF092432);

  // --- Bottom navigation ---
  static const Color bottomNavActive = accentGold;
  static const Color bottomNavInactive = textPrimary;
  static const Color bottomNavBarTint = accentSurface15;

  // --- Flags (VN) ---
  static const Color flagVnRed = Color(0xFFDA251D);
  static const Color flagVnYellow = Color(0xFFFFD700);

  // --- Skeleton / loading ---
  static const Color skeletonFlash = Color(0xFF171717);
  static const Color skeletonBackground = Color(0xFF2C2C2C);

  // --- Misc UI ---
  static const Color transparent = Color(0x00000000);
  static const Color main = transparent;
  static const Color black = Color(0xFF000000);
  static const Color iconCircleGray = Color(0xFF323231);
  static const Color shadowBlack25 = Color(0x40000000);
  static const Color black10 = Color(0x1A000000);
  static const Color overlayBlack70 = Color(0xB3000000);
  static const Color textShadow = black;
  static const Color white = Color(0xFFFFFFFF);
  static const Color white4 = Color(0x0AFFFFFF);
  static const Color white8 = borderWhite8;
  static const Color white10 = Color(0x1AFFFFFF);
  static const Color white15 = Color(0x26FFFFFF);
  static const Color white20 = Color(0x33FFFFFF);
  static const Color white30 = Color(0x4DFFFFFF);
  static const Color white70 = textMuted;
  static const Color digitGlassHighlight = Color(0x1AFFFFFF);

  // --- Form / light UI (legacy widgets) ---
  static const Color inkDarkest = Color(0xFF090A0A);
  static const Color inkBase = Color(0xFF404446);
  static const Color inkLight = Color(0xFF6C7072);
  static const Color inkLighter = Color(0xFF72777A);
  static const Color skyBase = Color(0xFFCDCFD0);
  static const Color skyLight = Color(0xFFE3E5E5);
  static const Color skyLighter = Color(0xFFF2F4F5);
  static const Color skyLightest = Color(0xFFF7F9FA);
  static const Color greenBase = Color(0xFF23C16B);
  static const Color greenLightest = Color(0xFFECFCE5);
  static const Color greenLightest2 = Color(0xFFF8FFF2);

  // --- Header overlay gradient (login, home, app header) ---
  static const Color headerGradientStop30 = Color(0x4D00101A);
  static const Color headerGradientStop20 = Color(0x3300101A);
  static const Color headerGradientStop15 = Color(0x2600101A);
  static const Color headerGradientStop10 = Color(0x1A00101A);
  static const Color headerGradientStop5 = Color(0x0D00101A);

  static const LinearGradient headerOverlayGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      background,
      headerGradientStop30,
      headerGradientStop20,
      headerGradientStop15,
      headerGradientStop10,
      headerGradientStop5,
      backgroundTransparent,
    ],
    stops: [0.0, 0.7644, 0.8462, 0.887, 0.9279, 0.9639, 1.0],
  );

  static const LinearGradient headerOverlayGradientShort = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      background,
      headerGradientStop30,
      headerGradientStop20,
      backgroundTransparent,
    ],
  );

  /// Full-screen fade behind scroll content.
  static const List<Color> scaffoldFadeGradientColors = [
    background,
    background,
    backgroundTransparent,
  ];

  static const LinearGradient scaffoldFadeGradient = LinearGradient(
    colors: scaffoldFadeGradientColors,
  );

  static const LinearGradient digitGlassGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [white, digitGlassHighlight],
  );

  static List<Color> backgroundFadeEdge({double midAlpha = 0.5}) => [
        background,
        background.withValues(alpha: midAlpha),
        background.withValues(alpha: 0),
      ];

  static List<Color> backgroundFadeEdgeReverse({double midAlpha = 0.5}) => [
        background.withValues(alpha: 0),
        background.withValues(alpha: midAlpha),
        background,
      ];

  static const Gradient gradient3 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 1.0],
    colors: [white, greenLightest],
  );
}
