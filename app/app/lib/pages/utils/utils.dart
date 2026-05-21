import 'package:base_core/resources.dart' hide AppColors;
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/theme/app_colors.dart';

class Utils {
  Utils._();

  static final Utils _instance = Utils._();

  static Utils get instance => _instance;
  static bool isIpad = false;
  static String envPath = 'packages/https/.env';

  Listenable get appDataListenable => Listenable.merge([]);

  static void setEnvPath(String env) {
    switch (env.toLowerCase()) {
      case 'dev':
        envPath = 'packages/https/.env';
        break;
      case 'stag':
      case 'staging':
        envPath = 'packages/https/.stag.env';
        break;
      case 'prod':
      case 'production':
        envPath = 'packages/https/.prod.env';
        break;
      default:
        envPath = 'packages/https/.env';
    }
  }

  static void showToast(
    String text, {
    bool isSuccess = false,
    Duration? duration,
  }) {
    BotToast.showSimpleNotification(
      title: text,
      align: Alignment.topCenter,
      duration: duration ?? Duration(seconds: 2),
      dismissDirections: [DismissDirection.up, DismissDirection.horizontal],
      wrapToastAnimation: (controller, onClose, child) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Opacity(opacity: controller.value, child: child);
          },
          child: Container(
            margin: EdgeInsets.only(
              top: 56,
              left: 12,
              right: 12,
            ),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isSuccess ? AppColors.greenBase : AppColors.inkDarkest,
            ),
            child: !isSuccess
                ? Text(text, style: AppFonts.regular500.copyWith(color: AppColors.white))
                : Row(
                    children: [
                      SvgPicture.asset(Assets.commonIcCheckCircle),
                      Gap(5),
                      Expanded(
                        child: Text(text, style: AppFonts.regular500.copyWith(color: AppColors.white)),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
