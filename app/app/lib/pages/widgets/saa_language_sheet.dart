import 'package:base_core/localization/localization_service.dart';
import 'package:base_core/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/app_localizations.dart';
import 'package:saa2025/pages/app_pages.locator.dart';
import 'package:saa2025/pages/login/login.dart';
import 'package:saa2025/theme/app_colors.dart';

/// Language dropdown — MoMorph `uUvW6Qm1ve`.
Future<void> showSaaLanguageSheet({
  required BuildContext context,
  required String currentCode,
  required ValueChanged<String> onLanguageChanged,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (ctx) {
      final tr = AppLocalizations.of(ctx);
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                tr.languageSheetTitle,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            for (final lang in LoginLanguage.values)
              ListTile(
                title: Text(
                  _languageLabel(lang, tr),
                  style: const TextStyle(color: AppColors.textPrimary),
                ),
                trailing: currentCode == lang.code ? const Icon(Icons.check, color: AppColors.accent) : null,
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

String _languageLabel(LoginLanguage lang, AppLocalizations tr) {
  switch (lang) {
    case LoginLanguage.vn:
      return tr.languageVietnamese;
    case LoginLanguage.en:
      return tr.languageEnglish;
    case LoginLanguage.ja:
      return tr.languageJapanese;
  }
}
