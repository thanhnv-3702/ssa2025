import 'package:base_core/presenter/base_screen.dart';
import 'package:base_core/res/extension.dart';
import 'package:base_core/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'register.dart';

class RegisterScreen extends BaseScreen<Register> {
  RegisterScreen(super.main, super.context);

  @override
  Widget screen() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: AppColors.gradient3,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ).paddingSymmetric(horizontal: 20.w),
    );
  }
}
