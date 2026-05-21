import 'dart:ui';

import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saa2025/generated/app_localizations.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/theme/app_colors.dart';

/// Bottom navigation — MoMorph `mms_7_nav bar` on [iOS] Home.
class SaaBottomNav extends StatelessWidget {
  const SaaBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _icons = [
    Assets.homeHomeNavHome,
    Assets.homeHomeNavAwards,
    Assets.homeHomeNavKudos,
    Assets.homeHomeNavProfile,
  ];

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final items = [
      _NavItem(tr.bottomNavHome, _icons[0]),
      _NavItem(tr.bottomNavAwards, _icons[1]),
      _NavItem(tr.bottomNavKudos, _icons[2]),
      _NavItem(tr.bottomNavProfile, _icons[3]),
    ];
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.bottomNavBarTint,
            border: Border(top: BorderSide(color: AppColors.borderWhite8)),
          ),
          padding: EdgeInsets.only(top: 8.h, bottom: MediaQuery.paddingOf(context).bottom + 4.h),
          child: Row(
            children: List.generate(items.length, (index) {
              final item = items[index];
              final active = index == currentIndex;
              return Expanded(
                child: InkWell(
                  onTap: () => onTap(index),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        item.icon,
                        width: 24.w,
                        height: 24.h,
                        colorFilter: ColorFilter.mode(
                            active ? AppColors.bottomNavActive : AppColors.bottomNavInactive, BlendMode.srcIn),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontFamily: BaseConst.fontRegular,
                          fontSize: 12.sp,
                          height: 16 / 12,
                          color: active ? AppColors.bottomNavActive : AppColors.bottomNavInactive,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final String icon;

  const _NavItem(this.label, this.icon);
}
