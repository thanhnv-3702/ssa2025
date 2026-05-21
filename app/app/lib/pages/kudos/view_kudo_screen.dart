import 'package:base_core/common/base_const.dart';
import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/kudos/view_kudo.dart';

/// View kudo detail — MoMorph screen `T0TR16k0vH`.
class ViewKudoScreen extends BaseScreen<ViewKudo> {
  ViewKudoScreen(super.main, super.context);

  static const Color _background = Color(0xFF00101A);
  static const Color _primaryGold = Color(0xFFFFEA9E);
  static const Color _cardBg = Color(0xFFFFF8E1);
  static const Color _textBlack = Color(0xFF00101A);
  static const Color _textGray = Color(0xFF999999);
  static const Color _contentBg = Color(0x66FFEA9E);
  static const Color _redError = Color(0xFFD4271D);

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
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(Assets.homeHomeBg, fit: BoxFit.cover),
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF00101A),
                          Color(0xFF00101A),
                          Color(0x0000101A),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 444.h,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: const [0.0, 0.254, 1.0],
                          colors: [
                            _background,
                            _background,
                            _background.withValues(alpha: 0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.764, 0.846, 0.887, 0.928, 0.964, 1.0],
                      colors: [
                        _background,
                        _background.withValues(alpha: 0.3),
                        _background.withValues(alpha: 0.2),
                        _background.withValues(alpha: 0.15),
                        _background.withValues(alpha: 0.1),
                        _background.withValues(alpha: 0.05),
                        _background.withValues(alpha: 0),
                      ],
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        Container(
                          height: 42.h,
                          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 9.h),
                          child: Row(
                            children: [
                              // Back button
                              InkWell(
                                onTap: main.onBack,
                                child: SizedBox(
                                  width: 24.w,
                                  height: 24.h,
                                  child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.sp),
                                ),
                              ),
                              const Spacer(),
                              // Title
                              Text(
                                'Kudo',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const Spacer(),
                              SizedBox(width: 24.w),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: _buildKudoCard(kudo),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildKudoCard(KudoItem kudo) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: _primaryGold, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPeopleRow(kudo),
          Gap(8.h),
          Container(height: 0.463.h, color: _primaryGold),
          Gap(8.h),
          Text(
            kudo.postedAt,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: _textGray,
              height: 11.109 / 10,
              letterSpacing: 0.2314,
            ),
          ),
          Gap(8.h),
          Container(
            width: double.infinity,
            child: Text(
              kudo.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: _textBlack,
                height: 11.109 / 10,
                letterSpacing: 0.2314,
              ),
            ),
          ),
          Gap(8.h),
          _buildContentSection(kudo),
          Gap(8.h),
          _buildActionButtons(kudo),
          Gap(8.h),
          Container(height: 0.463.h, color: _primaryGold),
        ],
      ),
    );
  }

  Widget _buildPeopleRow(KudoItem kudo) {
    return Row(
      children: [
        _buildPersonInfo(kudo.senderAvatarAsset, kudo.senderName, showBoth: true),
        const Spacer(),
        Icon(Icons.arrow_forward, color: _textBlack, size: 16.sp),
        const Spacer(),
        _buildPersonInfo(kudo.receiverAvatarAsset, kudo.receiverName, showBoth: false),
      ],
    );
  }

  Widget _buildPersonInfo(String? avatarAsset, String name, {required bool showBoth}) {
    return Column(
      children: [
        if (showBoth)
          SizedBox(
            width: 24.w,
            height: 24.h,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: _avatar(avatarAsset, name),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: _avatar(avatarAsset, name),
                ),
              ],
            ),
          )
        else
          _avatar(avatarAsset, name),
        Gap(8.h),
        SizedBox(
          width: 108.983.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: _textBlack,
                  height: 16 / 10,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Gap(4.h),
              Row(
                children: [
                  Text(
                    'CECV10',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: _textGray,
                      height: 9.257 / 10,
                      letterSpacing: 0.0463,
                    ),
                  ),
                  Gap(4.w),
                  Container(
                    width: 1.851.w,
                    height: 1.851.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: _textGray,
                    ),
                  ),
                  Gap(4.w),
                  _honorBadge('Rising Hero'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _avatar(String? asset, String name) {
    return Container(
      width: 24.w,
      height: 24.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF1A3A4A),
        image: asset != null ? DecorationImage(image: AssetImage(asset), fit: BoxFit.cover) : null,
      ),
      child: asset == null
          ? Center(
              child: Text(
                name.isNotEmpty ? name[0] : '?',
                style: TextStyle(color: _primaryGold, fontSize: 12.sp),
              ),
            )
          : null,
    );
  }

  Widget _honorBadge(String title) {
    final isRising = title.contains('Rising');
    return Container(
      height: 9.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.217.r),
        border: Border.all(color: _primaryGold, width: 0.231),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF092432).withValues(alpha: 0.5),
            const Color(0xFF092432).withValues(alpha: 0.5),
          ],
        ),
      ),
      child: Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: isRising ? 'Rising ' : 'Legend ',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 6.sp,
                  fontWeight: FontWeight.w700,
                  color: isRising ? const Color(0xFFCDFF60) : _primaryGold,
                  height: 7.515 / 6,
                  letterSpacing: 0.0376,
                  shadows: [const Shadow(color: Colors.black, offset: Offset(0, 0.179), blurRadius: 0.714)],
                ),
              ),
              TextSpan(
                text: 'Hero',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 6.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 7.515 / 6,
                  letterSpacing: 0.0376,
                  shadows: [const Shadow(color: Colors.black, offset: Offset(0, 0.179), blurRadius: 0.714)],
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildContentSection(KudoItem kudo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Message content
        Container(
          height: 262.h,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: _contentBg,
            borderRadius: BorderRadius.circular(5.554.r),
            border: Border.all(color: _primaryGold, width: 0.463),
          ),
          child: SingleChildScrollView(
            child: Text(
              kudo.message,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: _textBlack,
                height: 14 / 10,
              ),
            ),
          ),
        ),
        Gap(8.h),
        // Image thumbnails
        Row(
          children: List.generate(
            5,
            (index) => Padding(
              padding: EdgeInsets.only(right: index < 4 ? 4.w : 0),
              child: Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.043.r),
                  border: Border.all(color: const Color(0xFF998C5F), width: 0.447),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.787.r),
                    border: Border.all(color: _primaryGold, width: 0.447),
                  ),
                ),
              ),
            ),
          ),
        ),
        Gap(8.h),
        // Hashtags
        if (kudo.hashtags.isNotEmpty)
          Text(
            kudo.hashtags.join(' '),
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: _redError,
              height: 11.109 / 10,
              letterSpacing: 0.2314,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }

  Widget _buildActionButtons(KudoItem kudo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Hearts
        Row(
          children: [
            Text(
              '${main.likeCount}',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: _textBlack,
                height: 14.811 / 10,
              ),
            ),
            Gap(1.851.w),
            InkWell(
              onTap: main.onLikeTap,
              child: Icon(
                main.isLiked ? Icons.favorite : Icons.favorite_border,
                color: main.isLiked ? const Color(0xFFE53935) : _textBlack,
                size: 16.sp,
              ),
            ),
          ],
        ),
        // Action buttons
        Row(
          children: [
            _actionButton('Copy Link', Assets.kudosLink),
            Gap(3.703.w),
            _actionButton('Xem chi tiết', Assets.kudosArrowCross),
          ],
        ),
      ],
    );
  }

  Widget _actionButton(String label, String icon) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: BaseConst.fontMedium,
              fontSize: 10.sp,
              height: 11.109 / 10,
              letterSpacing: 0.0694,
              color: _textBlack,
            ),
          ),
          Gap(4.w),
          SvgPicture.asset(icon, width: 16.w),
        ],
      ),
    );
  }
}
