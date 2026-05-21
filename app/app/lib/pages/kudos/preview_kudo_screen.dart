import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/kudos/preview_kudo.dart';
import 'package:saa2025/pages/kudos/widgets/kudos_highlight_card.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/theme/app_colors.dart';

class PreviewKudoScreen extends BaseScreen<PreviewKudo> {
  PreviewKudoScreen(super.main, super.context);

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
            tr.previewKudoTitle,
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
              height: 160.h,
              child: Image.asset(Assets.homeHomeBg, fit: BoxFit.cover),
            ),
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        children: [
                          KudosHighlightCard(item: main.previewItem, width: double.infinity),
                          if (main.draft.imageCount > 0) ...[
                            Gap(12.h),
                            Text(
                              '${main.draft.imageCount} ảnh đính kèm',
                              style: TextStyle(color: AppColors.textMuted, fontSize: 13.sp),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: main.onBack,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.textPrimary,
                              side: BorderSide(color: AppColors.white30),
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                            ),
                            child: Text(tr.previewKudoEditButton),
                          ),
                        ),
                        Gap(12.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: main.isSending ? null : () => main.onSendTap(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: AppColors.background,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                            ),
                            child: Text(main.isSending ? tr.previewKudoSendingButton : tr.previewKudoSendButton),
                          ),
                        ),
                      ],
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
}
