import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/app_localizations.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/secret_box/secret_box_models.dart';
import 'package:saa2025/theme/app_colors.dart';

/// Secret box hero — Figma `3:20877` Open secret box (chưa mở).
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

  bool get _isStandby => visualState == SecretBoxVisualState.standby;

  static const double _hairline = 0.456;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    return Column(
      children: [
        if (_isStandby) ...[
          Text(
            tr.secretBoxStandbyTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: BaseConst.fontBold,
              fontSize: 18.sp,
              height: 24 / 18,
              color: AppColors.accent,
            ),
          ),
          Gap(8.h),
          Text(
            tr.secretBoxStandbySubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: BaseConst.fontMedium,
              fontSize: 14.sp,
              height: 20 / 14,
              color: AppColors.textOnDark,
            ),
          ),
        ] else
          _closedHeader(tr),
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
              child: _boxImage(tr),
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
              color: AppColors.accent,
            ),
          ),
        ],
        if (_isStandby && onStandbyContinue != null) ...[
          Gap(20.h),
          TextButton(
            onPressed: onStandbyContinue,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.accent,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            child: Text(
              tr.secretBoxContinueButton,
              style: TextStyle(fontFamily: BaseConst.fontBold, fontSize: 15.sp),
            ),
          ),
        ],
        if (!_isStandby) ...[
          Gap(24.h),
          const Divider(color: AppColors.divider, height: _hairline, thickness: _hairline),
          Gap(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tr.secretBoxUnopenedLabel,
                style: TextStyle(
                  fontFamily: BaseConst.fontRegular,
                  fontSize: 12.sp,
                  height: 16 / 12,
                  color: AppColors.textOnDark,
                ),
              ),
              Gap(5.w),
              Text(
                unopenedCount.toString().padLeft(2, '0'),
                style: TextStyle(
                  fontFamily: BaseConst.fontBold,
                  fontSize: 18.sp,
                  height: 24 / 18,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _closedHeader(AppLocalizations tr) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            tr.secretBoxExploreTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: BaseConst.fontBold,
              fontSize: 18.sp,
              height: 24 / 18,
              color: AppColors.accent,
            ),
          ),
        ),
        Gap(8.h),
        const Divider(color: AppColors.divider, height: _hairline, thickness: _hairline),
        Gap(8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            _subtitle(tr),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: BaseConst.fontMedium,
              fontSize: 14.sp,
              height: 20 / 14,
              color: AppColors.textOnDark,
            ),
          ),
        ),
      ],
    );
  }

  String _subtitle(AppLocalizations tr) {
    switch (visualState) {
      case SecretBoxVisualState.closed:
        return unopenedCount > 0 ? tr.secretBoxTapToOpen : tr.secretBoxAllOpened;
      case SecretBoxVisualState.opening:
        return tr.secretBoxOpening;
      case SecretBoxVisualState.revealed:
        return tr.secretBoxRevealed;
      case SecretBoxVisualState.standby:
        return tr.secretBoxStandbySubtitle;
    }
  }

  Widget _standbyGift() => _boxAsset(Assets.secretBoxSecretBoxGift, glow: true);

  Widget _boxImage(AppLocalizations tr) {
    final isOpening = visualState == SecretBoxVisualState.opening;
    return _boxAsset(
      Assets.secretBoxSecretBoxClosed,
      glow: isOpening,
      overlay: isOpening ? Icon(Icons.auto_awesome, size: 64.sp, color: AppColors.accent.withValues(alpha: 0.9)) : null,
    );
  }

  Widget _boxAsset(String asset, {bool glow = false, Widget? overlay}) {
    return SizedBox(
      width: 320.w,
      height: 320.w,
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.glowGold.withValues(alpha: glow ? 0.45 : 0.2),
              blurRadius: glow ? 28 : 10,
              spreadRadius: glow ? 2 : 0,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(asset, width: 320.w, height: 320.w, fit: BoxFit.contain),
            if (overlay != null) overlay,
          ],
        ),
      ),
    );
  }
}
