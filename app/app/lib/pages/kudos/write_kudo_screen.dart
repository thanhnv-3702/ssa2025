import 'package:base_core/common/base_const.dart';
import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/kudos/write_kudo.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/theme/app_colors.dart';

/// Viết Kudo — Figma `6885:9271` / MoMorph `7fFAb-K35a`.
class WriteKudoScreen extends BaseScreen<WriteKudo> {
  WriteKudoScreen(super.main, super.context);

  static const double _fieldWidth = 210;

  @override
  Widget screen() {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(Assets.homeHomeBg, fit: BoxFit.cover),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.scaffoldFadeGradientColors,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 120.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppColors.headerOverlayGradientShort,
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
                        onPressed: main.onBack,
                      ),
                      Expanded(
                        child: Text(
                          tr.writeKudoTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 56,
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _formCard(),
                          Gap(24.h),
                          _actionButtons(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: AppColors.kudosCardBackground,
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            tr.writeKudoSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: BaseConst.fontMedium,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              height: 20 / 14,
              color: AppColors.textBlack,
            ),
          ),
          if (main.showValidationError) ...[
            Gap(16.h),
            _validationBanner(),
          ],
          Gap(16.h),
          _inlineFieldRow(
            label: tr.writeKudoRecipientLabel,
            required: true,
            child: GestureDetector(
              onTap: main.onRecipientTap,
              child: AbsorbPointer(
                child: _cardTextField(
                  controller: main.recipientController,
                  hint: tr.writeKudoRecipientHint,
                  suffix: Assets.commonIcDown,
                ),
              ),
            ),
          ),
          Gap(16.h),
          _inlineFieldRow(
            label: tr.writeKudoTitleLabel,
            required: true,
            child: _cardTextField(
              controller: main.titleController,
              hint: tr.writeKudoTitleHint,
            ),
          ),
          Gap(4.h),
          Text(
            tr.writeKudoTitleHelper,
            style: _hintStyle(12),
          ),
          Gap(16.h),
          _messageSection(),
          Gap(16.h),
          _hashtagRow(),
          Gap(16.h),
          _imageRow(),
          Gap(16.h),
          _anonymousRow(),
        ],
      ),
    );
  }

  Widget _inlineFieldRow({
    required String label,
    required Widget child,
    bool required = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _inlineLabel(label, required: required),
        Gap(8.w),
        SizedBox(width: _fieldWidth.w, child: child),
      ],
    );
  }

  Widget _inlineLabel(String text, {bool required = false}) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: BaseConst.fontMedium,
                fontSize: 14.sp,
                height: 1.2,
                color: AppColors.textBlack,
              ),
            ),
          ),
          if (required)
            Text(
              ' *',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.error,
              ),
            ),
        ],
      ),
    );
  }

  Widget _messageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _formatToolbar(),
        _cardTextField(
          controller: main.messageController,
          hint: tr.writeKudoMessageHint,
          maxLines: 12,
          minHeight: 89,
          topRadius: false,
        ),
        Gap(2.h),
        Text(
          tr.writeKudoMentionHint,
          textAlign: TextAlign.center,
          style: _hintStyle(10),
        ),
      ],
    );
  }

  Widget _formatToolbar() {
    final buttons = <(IconData, VoidCallback)>[
      (Icons.format_bold, main.onFormatBold),
      (Icons.format_italic, main.onFormatItalic),
      (Icons.format_strikethrough, main.onFormatStrike),
      (Icons.format_list_numbered, main.onFormatNumber),
    ];

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < buttons.length; i++)
            _toolbarIconButton(
              icon: buttons[i].$1,
              onTap: buttons[i].$2,
              roundedLeft: i == 0,
              roundedRight: false,
            ),
          _toolbarSvgButton(
            asset: Assets.kudosLink,
            onTap: main.onFormatLink,
          ),
          _toolbarIconButton(
            icon: Icons.format_quote,
            onTap: main.onFormatQuote,
            roundedLeft: false,
            roundedRight: false,
          ),
          Expanded(
            child: _toolbarCommunityLink(),
          ),
        ],
      ),
    );
  }

  Widget _toolbarIconButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool roundedLeft,
    required bool roundedRight,
  }) {
    return _toolbarCell(
      onTap: onTap,
      roundedLeft: roundedLeft,
      roundedRight: roundedRight,
      child: Icon(icon, size: 16.sp, color: AppColors.textBlack),
    );
  }

  Widget _toolbarSvgButton({
    required String asset,
    required VoidCallback onTap,
  }) {
    return _toolbarCell(
      onTap: onTap,
      child: SvgPicture.asset(
        asset,
        width: 16.w,
        height: 16.h,
        colorFilter: const ColorFilter.mode(AppColors.textBlack, BlendMode.srcIn),
      ),
    );
  }

  Widget _toolbarCell({
    required Widget child,
    VoidCallback? onTap,
    bool roundedLeft = false,
    bool roundedRight = false,
  }) {
    final radius = BorderRadius.only(
      topLeft: Radius.circular(roundedLeft ? 4.r : 0),
      topRight: Radius.circular(roundedRight ? 4.r : 0),
    );
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 24.h,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderMuted, width: 0.5),
          borderRadius: radius,
        ),
        child: child,
      ),
    );
  }

  Widget _toolbarCommunityLink() {
    return InkWell(
      onTap: main.onCommunityStandardsTap,
      child: Container(
        height: 24.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderMuted, width: 0.5),
          borderRadius: BorderRadius.only(topRight: Radius.circular(4.r)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Text(
          tr.writeKudoCommunityStandardsLink,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: BaseConst.fontRegular,
            fontSize: 10.sp,
            height: 16 / 10,
            color: AppColors.communityLink,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.communityLink,
          ),
        ),
      ),
    );
  }

  Widget _hashtagRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _inlineLabel(tr.writeKudoHashtagLabel, required: true),
        Gap(12.w),
        Expanded(
          child: Wrap(
            spacing: 4.w,
            runSpacing: 4.h,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              for (var i = 0; i < main.hashtags.length; i++)
                _tagChip(
                  label: main.hashtags[i],
                  onDelete: () => main.onRemoveHashtag(i),
                ),
              _addChipButton(
                label: tr.writeKudoAddHashtagChip,
                onTap: main.onAddHashtagTap,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _imageRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Text(
            tr.image,
            style: TextStyle(
              fontFamily: BaseConst.fontRegular,
              fontSize: 14.sp,
              color: AppColors.textBlack,
            ),
          ),
        ),
        Gap(12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (main.attachedImages.isNotEmpty)
                Wrap(
                  spacing: 4.w,
                  runSpacing: 4.h,
                  children: [
                    for (var i = 0; i < main.attachedImages.length; i++) _imageThumbnail(i),
                  ],
                ),
              if (main.attachedImages.isNotEmpty) Gap(8.h),
              _addChipButton(
                label: tr.writeKudoAddImageButton(WriteKudo.maxImages),
                onTap: main.onAddImageTap,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _imageThumbnail(int index) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.borderMuted, width: 0.5),
          ),
          child: Icon(Icons.image, size: 18.sp, color: AppColors.borderMuted),
        ),
        Positioned(
          top: -4.h,
          right: -4.w,
          child: GestureDetector(
            onTap: () => main.onRemoveImage(index),
            child: Container(
              width: 8.w,
              height: 8.w,
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, size: 6.sp, color: AppColors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _addChipButton({required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4.r),
      child: Container(
        height: 32.h,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: AppColors.borderMuted, width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, size: 16.sp, color: AppColors.borderMuted),
            Gap(4.w),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: BaseConst.fontRegular,
                  fontSize: 12.sp,
                  height: 16 / 12,
                  color: AppColors.textBlack,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tagChip({required String label, required VoidCallback onDelete}) {
    return Container(
      height: 32.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: AppColors.borderMuted, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: BaseConst.fontRegular,
              fontSize: 12.sp,
              color: AppColors.textBlack,
            ),
          ),
          Gap(4.w),
          GestureDetector(
            onTap: onDelete,
            child: Icon(Icons.close, size: 14.sp, color: AppColors.gray),
          ),
        ],
      ),
    );
  }

  Widget _anonymousRow() {
    return Row(
      children: [
        InkWell(
          onTap: () => main.onAnonymousChanged(!main.sendAnonymous),
          borderRadius: BorderRadius.circular(4.r),
          child: Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: AppColors.borderMuted),
            ),
            child: main.sendAnonymous ? Icon(Icons.check, size: 16.sp, color: AppColors.textBlack) : null,
          ),
        ),
        Gap(8.w),
        Expanded(
          child: Text(
            tr.writeKudoAnonymousCheckbox,
            style: _hintStyle(12),
          ),
        ),
      ],
    );
  }

  Widget _actionButtons() {
    return Row(
      children: [
        Expanded(
          child: _actionButton(
            label: tr.writeKudoCancelButton,
            icon: SvgPicture.asset(
              Assets.commonIcClose,
              width: 24.w,
              height: 24.h,
              colorFilter: const ColorFilter.mode(AppColors.textPrimary, BlendMode.srcIn),
            ),
            backgroundColor: AppColors.accentSurface10,
            foregroundColor: AppColors.textPrimary,
            borderColor: AppColors.borderMuted,
            onTap: main.onCancelTap,
          ),
        ),
        Gap(16.w),
        Expanded(
          child: _actionButton(
            label: main.vm.isSubmitting ? tr.writeKudoSendingButton : tr.writeKudoSendButton,
            icon: main.vm.isSubmitting
                ? SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.textBlack,
                    ),
                  )
                : Icon(Icons.send_rounded, size: 24.sp, color: AppColors.textBlack),
            backgroundColor: AppColors.accentGold,
            foregroundColor: AppColors.textBlack,
            onTap: main.vm.isSubmitting ? null : () => main.onSendTap(),
          ),
        ),
      ],
    );
  }

  Widget _actionButton({
    required String label,
    required Widget icon,
    required Color backgroundColor,
    required Color foregroundColor,
    required VoidCallback? onTap,
    Color? borderColor,
  }) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(4.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4.r),
        child: Container(
          height: 40.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: borderColor != null ? Border.all(color: borderColor) : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: BaseConst.fontMedium,
                    fontSize: 14.sp,
                    height: 20 / 14,
                    color: foregroundColor,
                  ),
                ),
              ),
              Gap(8.w),
              icon,
            ],
          ),
        ),
      ),
    );
  }

  Widget _validationBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.errorBannerBackground,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.errorMaterial),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, color: AppColors.errorMaterial, size: 20.sp),
          Gap(8.w),
          Expanded(
            child: Text(
              tr.writeKudoValidationBanner,
              style: TextStyle(
                color: AppColors.textBlack,
                fontSize: 13.sp,
                height: 1.35,
              ),
            ),
          ),
          InkWell(
            onTap: main.dismissValidationError,
            child: Icon(Icons.close, color: AppColors.gray, size: 18.sp),
          ),
        ],
      ),
    );
  }

  Widget _cardTextField({
    TextEditingController? controller,
    required String hint,
    String? suffix,
    int maxLines = 1,
    double? minHeight,
    bool topRadius = true,
  }) {
    final borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(4.r),
      bottomRight: Radius.circular(4.r),
      topLeft: Radius.circular(topRadius ? 0 : 4.r),
      topRight: Radius.circular(topRadius ? 0 : 4.r),
    );

    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: BaseConst.fontRegular,
        color: AppColors.textBlack,
        fontSize: 12.sp,
        height: 16 / 12,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontFamily: BaseConst.fontRegular,
          color: AppColors.gray,
          fontSize: 12.sp,
          height: 16 / 12,
        ),
        filled: true,
        fillColor: AppColors.white,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 8.h),
        constraints: minHeight != null ? BoxConstraints(minHeight: minHeight.h) : null,
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: AppColors.borderMuted, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: AppColors.borderMuted, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: AppColors.accentGold, width: 0.5),
        ),
        suffixIcon: suffix != null
            ? Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: SvgPicture.asset(
                  suffix,
                  width: 24.w,
                  height: 24.h,
                  colorFilter: const ColorFilter.mode(AppColors.gray, BlendMode.srcIn),
                ),
              )
            : null,
        suffixIconConstraints: BoxConstraints(minWidth: 24.w, minHeight: 24.h),
      ),
    );
  }

  TextStyle _hintStyle(double size) {
    return TextStyle(
      fontFamily: BaseConst.fontRegular,
      fontSize: size.sp,
      height: 16 / size,
      color: AppColors.gray,
    );
  }
}
