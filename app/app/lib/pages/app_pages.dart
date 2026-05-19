import 'package:base_core/localization/localization_service.dart';
import 'package:base_core/storage/storage.dart';
import 'package:saa2025/pages/login/login.dart';
import 'package:saa2025/pages/register/register.dart';
import 'package:saa2025/pages/splash/splash.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'errors/access_denied.dart';
import 'errors/not_found.dart';
import 'home/home.dart';
import 'main_tab/main_tab.dart';
import 'notification/notification_list.dart';
import 'notification/setup_notification.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashState, initial: true),
    MaterialRoute(page: MainTabState),
    MaterialRoute(page: HomeState),
    MaterialRoute(page: LoginState),
    MaterialRoute(page: RegisterState),
    MaterialRoute(page: NotificationSetupState, path: '/notification-setup-state'),
    MaterialRoute(page: NotificationListState),
    MaterialRoute(page: AccessDeniedState),
    MaterialRoute(page: NotFoundState),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: StorageService),
    LazySingleton(classType: LocalizationService),
  ],
)
class AppPages {}
