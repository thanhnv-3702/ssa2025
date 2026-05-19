import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/kudos/preview_kudo.dart';
import 'package:saa2025/pages/kudos/widgets/kudos_highlight_card.dart';

class PreviewKudoScreen extends BaseScreen<PreviewKudo> {
  PreviewKudoScreen(super.main, super.context);

  static const Color _background = Color(0xFF00101A);
  static const Color _accent = Color(0xFFFFE99E);

  @override
  Widget screen() {
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
            'Xem trước Kudos',
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
                              style: TextStyle(color: const Color(0xB3FFFFFF), fontSize: 13.sp),
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
                              foregroundColor: Colors.white,
                              side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                            ),
                            child: const Text('Chỉnh sửa'),
                          ),
                        ),
                        Gap(12.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: main.isSending ? null : () => main.onSendTap(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _accent,
                              foregroundColor: _background,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                            ),
                            child: Text(main.isSending ? 'Đang gửi...' : 'Gửi đi'),
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
