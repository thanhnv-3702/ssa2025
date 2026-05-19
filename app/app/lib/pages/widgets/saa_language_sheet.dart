import 'package:base_core/localization/localization_service.dart';
import 'package:base_core/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/pages/app_pages.locator.dart';
import 'package:saa2025/pages/login/login.dart';

/// Language dropdown — MoMorph `uUvW6Qm1ve`.
Future<void> showSaaLanguageSheet({
  required BuildContext context,
  required String currentCode,
  required ValueChanged<String> onLanguageChanged,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: const Color(0xFF00101A),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (ctx) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                'Ngôn ngữ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            for (final lang in LoginLanguage.values)
              ListTile(
                title: Text(
                  _languageLabel(lang),
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: currentCode == lang.code ? const Icon(Icons.check, color: Color(0xFFFFE99E)) : null,
                onTap: () {
                  locator<StorageService>().setString(
                    StorageKey.keySelectedLanguage.name,
                    lang.locale.languageCode,
                  );
                  locator<LocalizationService>().setLocale(lang.locale);
                  onLanguageChanged(lang.code);
                  Navigator.pop(ctx);
                },
              ),
            Gap(8.h),
          ],
        ),
      );
    },
  );
}

String _languageLabel(LoginLanguage lang) {
  switch (lang) {
    case LoginLanguage.vn:
      return 'Tiếng Việt (VN)';
    case LoginLanguage.en:
      return 'English (EN)';
    case LoginLanguage.ja:
      return '日本語 (JA)';
  }
}
