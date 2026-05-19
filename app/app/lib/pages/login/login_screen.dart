import 'package:base_core/common/base_const.dart';
import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/login/login.dart';
import 'package:saa2025/theme/saa_design_tokens.dart';

/// SAA 2025 login — aligned with MoMorph screen `8HGlvYGJWq` ([iOS] Login).
class LoginScreen extends BaseScreen<Login> {
  LoginScreen(super.main, super.context);

  static const Color _background = SaaDesignTokens.background;
  static const Color _textOnDark = SaaDesignTokens.textOnDark;

  static const LinearGradient _headerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF00101A),
      Color(0x4D00101A),
      Color(0x3300101A),
      Color(0x2600101A),
      Color(0x1A00101A),
      Color(0x0D00101A),
      Color(0x0000101A),
    ],
    stops: [0.0, 0.7644, 0.8462, 0.887, 0.9279, 0.9639, 1.0],
  );

  @override
  Widget screen() {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: _background,
        body: _mainBody(),
      ),
    );
  }

  Widget _mainBody() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          Assets.loginLoginBg,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(148.h),
                      Image.asset(
                        Assets.loginLoginRootFurther,
                        width: 247.w,
                        fit: BoxFit.contain,
                      ),
                      Gap(24.h),
                      Text(
                        main.descriptionText,
                        style: TextStyle(
                          fontFamily: BaseConst.fontLight,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                          height: 20 / 14,
                          letterSpacing: 0.25,
                          color: _textOnDark,
                        ),
                      ),
                      const Spacer(),
                      Center(child: _buildGoogleButton()),
                      Gap(98.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Text(
                main.copyrightText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: BaseConst.fontRegular,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  height: 16 / 12,
                  color: _textOnDark,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 96.h,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 104.h,
            child: const DecoratedBox(
              decoration: BoxDecoration(gradient: _headerGradient),
            ),
          ),
          Positioned(
            left: 20.w,
            bottom: 8.h,
            child: Image.asset(
              Assets.loginLoginHeaderLogo,
              width: 48.w,
              height: 44.h,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            right: 20.w,
            bottom: 8.h,
            child: _buildLanguageSelector(),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: main.onLanguageTap,
        borderRadius: BorderRadius.circular(4.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFlag(main.selectedLanguageCode),
              Gap(4.w),
              Text(
                main.selectedLanguageCode,
                style: TextStyle(
                  fontFamily: BaseConst.fontMedium,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 20 / 14,
                  color: _textOnDark,
                ),
              ),
              Gap(4.w),
              SvgPicture.asset(
                Assets.commonIcDown,
                width: 24.w,
                height: 24.h,
                colorFilter: const ColorFilter.mode(_textOnDark, BlendMode.srcIn),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlag(String code) {
    if (code == 'VN') {
      return ClipRRect(
        borderRadius: BorderRadius.circular(2.r),
        child: SizedBox(
          width: 24.w,
          height: 18.h,
          child: Column(
            children: [
              Expanded(child: Container(color: const Color(0xFFDA251D))),
              Expanded(child: Container(color: const Color(0xFFFFD700))),
            ],
          ),
        ),
      );
    }
    return SizedBox(
      width: 24.w,
      height: 24.h,
      child: Center(
        child: Text(
          code,
          style: TextStyle(fontSize: 10.sp, color: _textOnDark, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildGoogleButton() {
    return Material(
      color: SaaDesignTokens.accent,
      borderRadius: BorderRadius.circular(4.r),
      child: InkWell(
        onTap: main.isGoogleLoginInProgress ? null : main.onGoogleLoginTap,
        borderRadius: BorderRadius.circular(4.r),
        child: SizedBox(
          width: 246.w,
          height: 40.h,
          child: main.isGoogleLoginInProgress
              ? Center(
                  child: SizedBox(
                    width: 22.w,
                    height: 22.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: _background,
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          main.googleButtonLabel,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: BaseConst.fontMedium,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            height: 20 / 14,
                            color: _background,
                          ),
                        ),
                      ),
                      Gap(8.w),
                      SvgPicture.asset(
                        Assets.loginLoginGoogleIcon,
                        width: 24.w,
                        height: 24.h,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
