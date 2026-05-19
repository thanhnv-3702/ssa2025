import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/kudos/view_kudo.dart';

/// View kudo detail — MoMorph screen `T0TR16k0vH`.
class ViewKudoScreen extends BaseScreen<ViewKudo> {
  ViewKudoScreen(super.main, super.context);

  static const Color _background = Color(0xFF00101A);
  static const Color _accent = Color(0xFFFFE99E);
  static const Color _cardBg = Color(0xFF0A1F2E);
  static const Color _textMuted = Color(0xB3FFFFFF);

  @override
  Widget screen() {
    final kudo = main.kudo;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: _background,
        appBar: AppBar(
          backgroundColor: _background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: main.onBack,
          ),
          title: Text(
            'Chi tiết Kudos',
            style: TextStyle(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w600),
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
                    _buildPeopleHeader(kudo),
                    Gap(16.h),
                    Text(kudo.postedAt, style: TextStyle(color: _textMuted, fontSize: 12.sp)),
                    Gap(8.h),
                    Text(
                      kudo.title,
                      style: TextStyle(
                        color: _accent,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Gap(16.h),
                    Text(
                      kudo.message,
                      style: TextStyle(color: Colors.white, fontSize: 15.sp, height: 1.5),
                    ),
                    if (kudo.hashtags.isNotEmpty) ...[
                      Gap(16.h),
                      Wrap(
                        spacing: 8.w,
                        children: kudo.hashtags
                            .map(
                              (tag) => Text(
                                tag,
                                style: TextStyle(color: _accent.withValues(alpha: 0.9), fontSize: 13.sp),
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
                        _actionButton(Icons.link, 'Copy Link', main.onCopyLinkTap),
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

  Widget _buildPeopleHeader(KudoItem kudo) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0x33FFE99E)),
      ),
      child: Row(
        children: [
          _avatar(kudo.senderAvatarAsset, kudo.senderName),
          Gap(12.w),
          Icon(Icons.arrow_forward, color: _accent, size: 18.sp),
          Gap(12.w),
          _avatar(kudo.receiverAvatarAsset, kudo.receiverName),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kudo.senderName,
                  style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '→ ${kudo.receiverName}',
                  style: TextStyle(color: _textMuted, fontSize: 12.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatar(String? asset, String name) {
    return CircleAvatar(
      radius: 28.r,
      backgroundColor: const Color(0xFF1A3A4A),
      backgroundImage: asset != null ? AssetImage(asset) : null,
      child: asset == null
          ? Text(
              name.isNotEmpty ? name[0] : '?',
              style: TextStyle(color: _accent, fontSize: 18.sp),
            )
          : null,
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
            Icon(icon, color: active ? const Color(0xFFE53935) : _textMuted, size: 22.sp),
            Gap(8.w),
            Text(label, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
          ],
        ),
      ),
    );
  }
}
