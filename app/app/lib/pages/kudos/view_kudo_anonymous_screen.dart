import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/kudos/view_kudo_anonymous.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/theme/app_colors.dart';

/// View kudo ẩn danh — MoMorph `5C2BL6GYXL`.
class ViewKudoAnonymousScreen extends BaseScreen<ViewKudoAnonymous> {
  ViewKudoAnonymousScreen(super.main, super.context);

  @override
  Widget screen() {
    final kudo = main.kudo;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
            onPressed: main.onBack,
          ),
          title: Text(
            tr.viewAnonymousKudoTitle,
            style: TextStyle(color: AppColors.textPrimary, fontSize: 17.sp, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 180.h,
              child: Image.asset(Assets.homeHomeBg, fit: BoxFit.cover),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildAnonymousHeader(kudo),
                    Gap(16.h),
                    Text(kudo.postedAt, style: TextStyle(color: AppColors.textMuted, fontSize: 12.sp)),
                    Gap(8.h),
                    Text(
                      kudo.title,
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Gap(16.h),
                    Text(
                      kudo.message,
                      style: TextStyle(color: AppColors.textPrimary, fontSize: 15.sp, height: 1.5),
                    ),
                    if (kudo.hashtags.isNotEmpty) ...[
                      Gap(16.h),
                      Wrap(
                        spacing: 8.w,
                        children: kudo.hashtags
                            .map(
                              (tag) => Text(
                                tag,
                                style: TextStyle(color: AppColors.accent.withValues(alpha: 0.9), fontSize: 13.sp),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                    Gap(24.h),
                    Row(
                      children: [
                        _actionButton(
                          main.isLiked ? Icons.favorite : Icons.favorite_border,
                          '$main.likeCount',
                          main.onLikeTap,
                          active: main.isLiked,
                        ),
                        Gap(24.w),
                        _actionButton(Icons.link, tr.copyLink, main.onCopyLinkTap),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnonymousHeader(KudoItem kudo) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.kudosCardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.accentBorder20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundColor: AppColors.avatarPlaceholder,
            child: Icon(Icons.visibility_off, color: AppColors.accent, size: 24.sp),
          ),
          Gap(12.w),
          Icon(Icons.arrow_forward, color: AppColors.accent, size: 18.sp),
          Gap(12.w),
          CircleAvatar(
            radius: 28.r,
            backgroundColor: AppColors.avatarPlaceholder,
            backgroundImage: kudo.receiverAvatarAsset != null ? AssetImage(kudo.receiverAvatarAsset!) : null,
            child: kudo.receiverAvatarAsset == null
                ? Text(
                    kudo.receiverName.isNotEmpty ? kudo.receiverName[0] : '?',
                    style: TextStyle(color: AppColors.accent, fontSize: 18.sp),
                  )
                : null,
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr.viewAnonymousKudoSenderLabel,
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12.sp, fontStyle: FontStyle.italic),
                ),
                Gap(4.h),
                Text(
                  kudo.receiverName,
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
                Text(
                  tr.viewAnonymousKudoReceiverLabel,
                  style: TextStyle(color: AppColors.textMuted, fontSize: 11.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String label, VoidCallback onTap, {bool active = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: active ? AppColors.errorMaterial : AppColors.textMuted, size: 22.sp),
            Gap(8.w),
            Text(label, style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp)),
          ],
        ),
      ),
    );
  }
}
