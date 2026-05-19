import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';

/// Kudos promo block on award detail screens — MoMorph `mms_2.4_kudos`.
class AwardKudosPromo extends StatelessWidget {
  const AwardKudosPromo({super.key, required this.onDetailTap});

  final VoidCallback onDetailTap;

  static const Color _accent = Color(0xFFFFE99E);
  static const Color _background = Color(0xFF00101A);
  static const Color _textOnDark = Color(0xFFFFFFFF);

  static const String _note =
      'ĐIỂM MỚI CỦA SAA 2025\n'
      'Hoạt động ghi nhận và cảm ơn đồng nghiệp - lần đầu tiên được diễn ra dành cho tất cả Sunner. '
      'Hoạt động sẽ được triển khai vào tháng 11/2025, khuyến khích người Sun* chia sẻ những lời ghi nhận, '
      'cảm ơn đồng nghiệp trên hệ thống do BTC công bố. Đây sẽ là chất liệu để Hội đồng Heads tham khảo '
      'trong quá trình lựa chọn người đạt giải.';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phong trào ghi nhận',
          style: TextStyle(
            fontFamily: BaseConst.fontMedium,
            fontSize: 12.sp,
            color: _accent,
          ),
        ),
        Gap(4.h),
        Text(
          'Sun* Kudos',
          style: TextStyle(
            fontFamily: BaseConst.fontSemiBold,
            fontSize: 20.sp,
            color: _textOnDark,
          ),
        ),
        Gap(16.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.asset(Assets.homeHomeKudosBanner, width: double.infinity, fit: BoxFit.cover),
        ),
        Gap(16.h),
        Text(
          _note,
          style: TextStyle(
            fontFamily: BaseConst.fontLight,
            fontSize: 13.sp,
            height: 20 / 13,
            color: _textOnDark.withValues(alpha: 0.9),
          ),
        ),
        Gap(16.h),
        Material(
          color: _accent,
          borderRadius: BorderRadius.circular(4.r),
          child: InkWell(
            onTap: onDetailTap,
            borderRadius: BorderRadius.circular(4.r),
            child: SizedBox(
              width: double.infinity,
              height: 40.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Chi tiết',
                    style: TextStyle(
                      fontFamily: BaseConst.fontMedium,
                      fontSize: 14.sp,
                      color: _background,
                    ),
                  ),
                  Gap(8.w),
                  SvgPicture.asset(Assets.homeHomeIcArrow, width: 20.w, height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
