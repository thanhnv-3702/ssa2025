import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/secret_box/secret_box_models.dart';

/// Secret box hero — MoMorph `mms_Box image` + Standby (`-LIblaeusT` … `xptNUunBS_`).
class SecretBoxPanel extends StatelessWidget {
  const SecretBoxPanel({
    super.key,
    required this.visualState,
    required this.unopenedCount,
    required this.onBoxTap,
    this.lastRewardLabel,
    this.onStandbyContinue,
  });

  final SecretBoxVisualState visualState;
  final int unopenedCount;
  final VoidCallback onBoxTap;
  final String? lastRewardLabel;
  final VoidCallback? onStandbyContinue;

  static const Color _accent = Color(0xFFFFE99E);
  static const Color _textOnDark = Color(0xFFFFFFFF);
  static const Color _divider = Color(0xFF2E3940);

  bool get _isStandby => visualState == SecretBoxVisualState.standby;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _isStandby ? 'SECRET BOX' : 'KHÁM PHÁ SECRET BOX CỦA BẠN',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: BaseConst.fontBold,
            fontSize: 18.sp,
            height: 24 / 18,
            color: _accent,
          ),
        ),
        Gap(8.h),
        Text(
          _subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: BaseConst.fontMedium,
            fontSize: 14.sp,
            height: 20 / 14,
            color: _textOnDark,
          ),
        ),
        Gap(24.h),
        if (_isStandby)
          _standbyGift()
        else
          GestureDetector(
            onTap: unopenedCount > 0 && visualState != SecretBoxVisualState.opening ? onBoxTap : null,
            child: AnimatedScale(
              scale: visualState == SecretBoxVisualState.opening ? 1.08 : 1.0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
              child: _boxImage(),
            ),
          ),
        if (_isStandby && lastRewardLabel != null) ...[
          Gap(16.h),
          Text(
            lastRewardLabel!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: BaseConst.fontBold,
              fontSize: 16.sp,
              color: _accent,
            ),
          ),
        ],
        if (_isStandby && onStandbyContinue != null) ...[
          Gap(20.h),
          TextButton(
            onPressed: onStandbyContinue,
            style: TextButton.styleFrom(
              foregroundColor: _accent,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            child: Text(
              'Tiếp tục',
              style: TextStyle(fontFamily: BaseConst.fontBold, fontSize: 15.sp),
            ),
          ),
        ],
        Gap(24.h),
        const Divider(color: _divider, height: 1),
        Gap(16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Secret box chưa mở',
              style: TextStyle(
                fontFamily: BaseConst.fontRegular,
                fontSize: 12.sp,
                color: _textOnDark.withValues(alpha: 0.9),
              ),
            ),
            Gap(6.w),
            Text(
              unopenedCount.toString().padLeft(2, '0'),
              style: TextStyle(
                fontFamily: BaseConst.fontBold,
                fontSize: 18.sp,
                color: _accent,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String get _subtitle {
    switch (visualState) {
      case SecretBoxVisualState.closed:
        return unopenedCount > 0 ? 'Click vào box để mở' : 'Bạn đã mở hết secret box';
      case SecretBoxVisualState.opening:
        return 'Đang mở hộp quà...';
      case SecretBoxVisualState.revealed:
        return 'Chúc mừng! Bạn đã nhận phần thưởng';
      case SecretBoxVisualState.standby:
        return 'Chúc mừng bạn đã nhận được phần quà từ BTC SAA 2025';
    }
  }

  Widget _standbyGift() => _boxAsset(Assets.secretBoxSecretBoxGift, glow: true);

  Widget _boxImage() {
    final isOpening = visualState == SecretBoxVisualState.opening;
    return _boxAsset(
      Assets.secretBoxSecretBoxClosed,
      glow: isOpening,
      overlay: isOpening
          ? Icon(Icons.auto_awesome, size: 64.sp, color: _accent.withValues(alpha: 0.9))
          : null,
    );
  }

  Widget _boxAsset(String asset, {bool glow = false, Widget? overlay}) {
    return Container(
      width: 280.w,
      height: 280.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFAE287).withValues(alpha: glow ? 0.45 : 0.2),
            blurRadius: glow ? 28 : 10,
            spreadRadius: glow ? 2 : 0,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(asset, width: 280.w, height: 280.w, fit: BoxFit.contain),
          if (overlay != null) overlay,
        ],
      ),
    );
  }
}
