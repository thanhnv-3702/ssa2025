import 'package:base_core/presenter/base_screen.dart';
import 'package:base_core/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/splash/splash.dart';

class SplashScreen extends BaseScreen<Splash> {
  SplashScreen(super.main, super.context);

  @override
  Widget screen() {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: _mainBody(),
      ),
    );
  }

  Widget _mainBody() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: AppColors.gradient3,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            Assets.splashIcLogo,
            width: 193.w,
          ),
        ],
      ),
    );
  }
}
