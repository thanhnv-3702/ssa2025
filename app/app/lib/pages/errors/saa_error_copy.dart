import 'package:base_core/storage/storage.dart';
import 'package:saa2025/pages/app_pages.locator.dart';
import 'package:saa2025/pages/login/login.dart';

class SaaErrorStrings {
  const SaaErrorStrings({
    required this.notFoundTitle,
    required this.notFoundMessage,
    required this.accessDeniedTitle,
    required this.accessDeniedMessage,
    required this.goHomeLabel,
  });

  final String notFoundTitle;
  final String notFoundMessage;
  final String accessDeniedTitle;
  final String accessDeniedMessage;
  final String goHomeLabel;
}

/// Localized error copy — aligned with MoMorph Not Found / Access denied.
abstract final class SaaErrorCopy {
  static SaaErrorStrings current() {
    final saved = locator<StorageService>().getString(StorageKey.keySelectedLanguage.name);
    final lang = switch (saved) {
      'en' => LoginLanguage.en,
      'ja' => LoginLanguage.ja,
      _ => LoginLanguage.vn,
    };
    return forLanguage(lang);
  }

  static SaaErrorStrings forLanguage(LoginLanguage lang) {
    switch (lang) {
      case LoginLanguage.en:
        return const SaaErrorStrings(
          notFoundTitle: 'NOT FOUND',
          notFoundMessage:
              "The resource you're looking for doesn't exist\nor has been removed.",
          accessDeniedTitle: 'ACCESS DENIED',
          accessDeniedMessage: "You don't have permission to access this resource.",
          goHomeLabel: 'Go back to Home',
        );
      case LoginLanguage.ja:
        return const SaaErrorStrings(
          notFoundTitle: 'NOT FOUND',
          notFoundMessage: 'お探しのリソースは存在しないか、\n削除されました。',
          accessDeniedTitle: 'ACCESS DENIED',
          accessDeniedMessage: 'このリソースへのアクセス権限がありません。',
          goHomeLabel: 'ホームに戻る',
        );
      case LoginLanguage.vn:
        return const SaaErrorStrings(
          notFoundTitle: 'NOT FOUND',
          notFoundMessage:
              'Tài nguyên bạn tìm không tồn tại\nhoặc đã bị gỡ bỏ.',
          accessDeniedTitle: 'ACCESS DENIED',
          accessDeniedMessage: 'Bạn không có quyền truy cập tài nguyên này.',
          goHomeLabel: 'Về trang chủ',
        );
    }
  }
}
