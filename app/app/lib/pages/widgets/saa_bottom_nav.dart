import 'package:base_core/common/base_const.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saa2025/generated/assets.dart';

/// Bottom navigation — MoMorph `mms_7_nav bar` on [iOS] Home.
class SaaBottomNav extends StatelessWidget {
  const SaaBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const Color _active = Color(0xFFFFEA9E);
  static const Color _inactive = Color(0xFFFFFFFF);
  static const Color _barTint = Color(0x26FFEA9E);

  static const _items = [
    _NavItem('SAA 2025', Assets.homeHomeNavHome),
    _NavItem('Awards', Assets.homeHomeNavAwards),
    _NavItem('Kudos', Assets.homeHomeNavKudos),
    _NavItem('Profile', Assets.homeHomeNavProfile),
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: const BoxDecoration(
            color: _barTint,
            border: Border(top: BorderSide(color: Color(0x14FFFFFF))),
          ),
          padding: EdgeInsets.only(top: 8.h, bottom: MediaQuery.paddingOf(context).bottom + 4.h),
          child: Row(
            children: List.generate(_items.length, (index) {
              final item = _items[index];
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
                        colorFilter: ColorFilter.mode(active ? _active : _inactive, BlendMode.srcIn),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontFamily: BaseConst.fontRegular,
                          fontSize: 12.sp,
                          height: 16 / 12,
                          color: active ? _active : _inactive,
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
