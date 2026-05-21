import 'package:flutter/material.dart';
import 'package:saa2025/generated/app_localizations.dart';
import 'package:stacked_services/stacked_services.dart';

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
    final ctx = StackedService.navigatorKey?.currentContext;
    if (ctx == null) {
      return const SaaErrorStrings(
        notFoundTitle: 'NOT FOUND',
        notFoundMessage: "The resource you're looking for doesn't exist\nor has been removed.",
        accessDeniedTitle: 'ACCESS DENIED',
        accessDeniedMessage: "You don't have permission to access this resource.",
        goHomeLabel: 'Go back to Home',
      );
    }
    return _fromTr(AppLocalizations.of(ctx));
  }

  static SaaErrorStrings fromContext(BuildContext context) => _fromTr(AppLocalizations.of(context));

  static SaaErrorStrings _fromTr(AppLocalizations tr) {
    return SaaErrorStrings(
      notFoundTitle: tr.errorNotFoundTitle,
      notFoundMessage: tr.errorNotFoundMessage,
      accessDeniedTitle: tr.errorAccessDeniedTitle,
      accessDeniedMessage: tr.errorAccessDeniedMessage,
      goHomeLabel: tr.errorGoHome,
    );
  }
}
