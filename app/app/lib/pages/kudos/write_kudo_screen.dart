import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/kudos/write_kudo.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/theme/app_colors.dart';

/// Viết Kudo — MoMorph `7fFAb-K35a`.
class WriteKudoScreen extends BaseScreen<WriteKudo> {
  WriteKudoScreen(super.main, super.context);

  @override
  Widget screen() {
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
            tr.writeKudoTitle,
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
              height: 200.h,
              child: Image.asset(Assets.homeHomeBg, fit: BoxFit.cover),
            ),
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr.writeKudoSubtitle,
                            style: TextStyle(color: AppColors.accent, fontSize: 16.sp, fontWeight: FontWeight.w700),
                          ),
                          if (main.showValidationError) ...[
                            Gap(16.h),
                            _validationBanner(),
                          ],
                          Gap(24.h),
                          _requiredLabel(tr.writeKudoRecipientLabel),
                          Gap(8.h),
                          GestureDetector(
                            onTap: main.onRecipientTap,
                            child: AbsorbPointer(
                              child: _textField(
                                controller: main.recipientController,
                                hint: tr.writeKudoRecipientHint,
                                suffix: Icons.keyboard_arrow_down,
                              ),
                            ),
                          ),
                          Gap(20.h),
                          _requiredLabel(tr.writeKudoTitleLabel),
                          Gap(8.h),
                          _textField(
                            controller: main.titleController,
                            hint: tr.writeKudoTitleHint,
                          ),
                          Gap(8.h),
                          GestureDetector(
                            onTap: main.onCommunityStandardsTap,
                            child: Text(
                              tr.writeKudoCommunityStandardsLink,
                              style: TextStyle(
                                color: AppColors.accent,
                                fontSize: 13.sp,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Gap(20.h),
                          _formatToolbar(),
                          Gap(8.h),
                          _textField(
                            controller: main.messageController,
                            hint: tr.writeKudoMessageHint,
                            maxLines: 6,
                          ),
                          Gap(8.h),
                          Text(
                            tr.writeKudoMentionHint,
                            style: TextStyle(color: AppColors.textMuted, fontSize: 12.sp),
                          ),
                          Gap(20.h),
                          _requiredLabel(tr.writeKudoHashtagLabel),
                          Gap(8.h),
                          _hashtagSection(),
                          Gap(20.h),
                          _label(tr.image),
                          Gap(8.h),
                          _imageSection(),
                          Gap(20.h),
                          _anonymousToggle(),
                        ],
                      ),
                    ),
                  ),
                  _buildActions(),
                ],
              ),
            ),
          ],
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
              style: TextStyle(color: AppColors.textPrimary, fontSize: 13.sp, height: 1.35),
            ),
          ),
          InkWell(
            onTap: main.dismissValidationError,
            child: Icon(Icons.close, color: AppColors.textMuted, size: 18.sp),
          ),
        ],
      ),
    );
  }

  Widget _requiredLabel(String text) {
    return Text(
      '$text *',
      style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp, fontWeight: FontWeight.w600),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp, fontWeight: FontWeight.w600),
    );
  }

  Widget _formatToolbar() {
    final actions = <(String, VoidCallback)>[
      ('B', main.onFormatBold),
      ('I', main.onFormatItalic),
      ('S', main.onFormatStrike),
      ('❝', main.onFormatQuote),
    ];
    return Row(
      children: actions
          .map(
            (a) => Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: InkWell(
                onTap: a.$2,
                borderRadius: BorderRadius.circular(6.r),
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.fieldBackground,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(color: AppColors.white15),
                  ),
                  child: Text(a.$1, style: TextStyle(color: AppColors.textPrimary, fontSize: 13.sp)),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _imageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (main.attachedImages.isNotEmpty)
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              for (var i = 0; i < main.attachedImages.length; i++)
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 72.w,
                      height: 72.w,
                      decoration: BoxDecoration(
                        color: AppColors.avatarPlaceholder,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
                      ),
                      child: Icon(Icons.image, color: AppColors.accent.withValues(alpha: 0.6), size: 28.sp),
                    ),
                    Positioned(
                      top: -6,
                      right: -6,
                      child: GestureDetector(
                        onTap: () => main.onRemoveImage(i),
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: const BoxDecoration(
                            color: AppColors.errorMaterial,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.close, size: 14.sp, color: AppColors.textPrimary),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        Gap(8.h),
        OutlinedButton.icon(
          onPressed: main.onAddImageTap,
          icon: Icon(Icons.add, color: AppColors.accent, size: 18.sp),
          label: Text(
            tr.writeKudoAddImageButton(WriteKudo.maxImages),
            style: TextStyle(color: AppColors.accent, fontSize: 13.sp),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.accent.withValues(alpha: 0.5)),
          ),
        ),
      ],
    );
  }

  Widget _hashtagSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            for (var i = 0; i < main.hashtags.length; i++)
              Chip(
                label: Text(main.hashtags[i], style: TextStyle(fontSize: 12.sp)),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () => main.onRemoveHashtag(i),
                backgroundColor: AppColors.fieldBackground,
                side: BorderSide(color: AppColors.accent.withValues(alpha: 0.4)),
                labelStyle: const TextStyle(color: AppColors.textPrimary),
              ),
            ActionChip(
              label: Text(tr.writeKudoAddHashtagChip, style: TextStyle(color: AppColors.accent, fontSize: 12.sp)),
              backgroundColor: AppColors.fieldBackground,
              side: BorderSide(color: AppColors.accent.withValues(alpha: 0.4)),
              onPressed: main.onAddHashtagTap,
            ),
          ],
        ),
      ],
    );
  }

  Widget _textField({
    TextEditingController? controller,
    required String hint,
    IconData? suffix,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14.sp),
        filled: true,
        fillColor: AppColors.fieldBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.white20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.white20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.accent),
        ),
        suffixIcon: suffix != null ? Icon(suffix, color: AppColors.textMuted) : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }

  Widget _anonymousToggle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: main.sendAnonymous,
          onChanged: (v) => main.onAnonymousChanged(v ?? false),
          activeColor: AppColors.accent,
          checkColor: AppColors.background,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              tr.writeKudoAnonymousCheckbox,
              style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.white10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: TextButton(
              onPressed: main.onPreviewTap,
              child: Text(
                tr.writeKudoPreviewButton,
                style: TextStyle(color: AppColors.accent, fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: main.onCancelTap,
                  icon: const Icon(Icons.close, size: 18),
                  label: Text(tr.writeKudoCancelButton, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    side: BorderSide(color: AppColors.white30),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
                  ),
                ),
              ),
              Gap(12.w),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: main.vm.isSubmitting ? null : () => main.onSendTap(),
                  icon: main.vm.isSubmitting
                      ? SizedBox(
                          width: 18.w,
                          height: 18.w,
                          child: const CircularProgressIndicator(strokeWidth: 2, color: AppColors.black),
                        )
                      : const Icon(Icons.send_rounded, size: 18),
                  label: Text(
                    main.vm.isSubmitting ? tr.writeKudoSendingButton : tr.writeKudoSendButton,
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.background,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
