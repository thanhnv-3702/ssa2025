import 'dart:async';
import 'dart:io';

import 'package:base_core/common/base_const.dart';
import 'package:base_core/common/config.dart';
import 'package:base_core/common/event_bus.dart';
import 'package:base_core/localization/localization_service.dart';
import 'package:base_core/resources.dart';
import 'package:base_core/storage/storage.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:country_codes/country_codes.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:https/vn/sun/https/inject/injection.dart';
import 'package:saa2025/config/app_environment.dart';
import 'package:saa2025/firebase_options.dart';
import 'package:saa2025/generated/app_localizations.dart';
import 'package:saa2025/pages/app_pages.locator.dart';
import 'package:saa2025/pages/app_pages.router.dart';
import 'package:saa2025/pages/login/login.dart';
import 'package:saa2025/pages/utils/const.dart';
import 'package:saa2025/pages/utils/saa_route_guard.dart';
import 'package:saa2025/pages/utils/utils.dart';
import 'package:saa2025/pages/widgets/firebase_messaging/firebase_messaging_background_handler.dart';
import 'package:saa2025/pages/widgets/privacy_overlay_widget.dart';
import 'package:saa2025/services/auth/auth_service.dart';
import 'package:saa2025/services/fcm_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

late AppLifecycleState stateApp;

Future<bool> checkIpad() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  IosDeviceInfo info = await deviceInfo.iosInfo;
  if (info.name.toLowerCase().contains('ipad')) {
    return true;
  }
  return false;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BotToastNavigatorObserver();
  await setupLocator();
  await locator<StorageService>().init();
  final storage = locator<StorageService>();
  final storedEnv = storage.getString(StorageKey.keySelectedEnv.name);
  final env =
      storedEnv != null && storedEnv.isNotEmpty ? storedEnv : String.fromEnvironment('ENV', defaultValue: 'dev');
  Utils.setEnvPath(env);
  await dotenv.load(fileName: Utils.envPath);
  logger.d('SAA startup: ${AppEnvironment.summary}');
  await configureDependencies(env);
  await initFirebase();
  if (Platform.isIOS) {
    Utils.isIpad = await checkIpad();
  }
  runApp(const MyApp());
}

Future<void> initFirebase() async {
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    FirebaseMessaging.onMessage.listen(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await FcmService.instance.init(locator<StorageService>());
  } catch (e, st) {
    logger.e('Firebase/FCM init failed (app will run without push): $e');
    logger.d('Stack: $st');
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  final Widget? home;
  final ThemeData? theme;

  const MyApp({super.key, this.home, this.theme});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool _isPrivacyOverlayVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // AC5: Listen for logout notification (e.g., when refresh token is revoked)
    EventBus.instance.addListener(
      (parameter) {
        logger.d('AC5: Logout notification received: $parameter');
        logout();
      },
      name: logoutNotification,
    );
    // Load saved language preference
    _loadSavedLanguage(StackedLocator.instance<LocalizationService>());
  }

  void _loadSavedLanguage(LocalizationService localizationService) {
    final storageService = locator<StorageService>();
    final saved = storageService.getString(StorageKey.keySelectedLanguage.name);
    final supportedCodes = AppLocalizations.supportedLocales.map((l) => l.languageCode.toLowerCase()).toSet();
    Locale locale = Locale(BaseConst.defaultLangue);

    if (saved != null && saved.isNotEmpty) {
      final languageCode = saved.split(RegExp(r'[-_]')).first.toLowerCase();
      if (supportedCodes.contains(languageCode)) {
        locale = Locale(languageCode);
      } else {
        storageService.setString(StorageKey.keySelectedLanguage.name, locale.languageCode);
      }
    }
    localizationService.setLocale(locale);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final isInForeground = state == AppLifecycleState.resumed;
    final service = locator<StorageService>();
    service.setBool('isInForeground', isInForeground);
    logger.d('NEO: isInForeground = $isInForeground');

    setState(() {
      _isPrivacyOverlayVisible = state == AppLifecycleState.paused || state == AppLifecycleState.inactive;
    });

    final now = DateTime.now().millisecondsSinceEpoch;
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      logger.d('NEON lastActive = $now');
      final lastActiveTrack = service.getInt(StorageKey.keyLastActiveTime.name);
      if (lastActiveTrack == null) {
        service.setInt(StorageKey.keyLastActiveTime.name, now);
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final ThemeData _theme = ThemeData(
    canvasColor: AppColors.white,
    fontFamily: BaseConst.fontMedium,
    visualDensity: VisualDensity.standard,
  );

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.main,
      ),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: false,
        child: ListenableBuilder(
          listenable: StackedLocator.instance<LocalizationService>(),
          builder: (context, child) {
            final localizationService = StackedLocator.instance<LocalizationService>();
            return MaterialApp(
              title: Const.defaultTitle,
              theme: _theme,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: localizationService.locale,
              navigatorKey: StackedService.navigatorKey,
              onGenerateRoute: saaOnGenerateRoute,
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.splashState,
              builder: (context, child) {
                final childInternal = botToastBuilder(context, child);
                return Stack(
                  children: [
                    FlutterEasyLoading(
                      child: MediaQuery(
                        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
                        child: childInternal,
                      ),
                    ),
                    // AC1: Privacy overlay to hide sensitive data when app is in background
                    PrivacyOverlayWidget(
                      isVisible: _isPrivacyOverlayVisible,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

void logout({String? sms, BuildContext? context, bool isForceToLoginWithUserName = true}) async {
  final navigationService = locator<NavigationService>();
  await AuthService().signOut();
  if (isForceToLoginWithUserName) {
    navigationService.clearStackAndShow(Routes.loginState);
    return;
  }
  navigationService.clearStackAndShow(Routes.loginState, arguments: LoginStateArguments(rootBack: LoginRootBack.root));
}

String? countryCode() {
  final Locale? deviceLocale = CountryCodes.getDeviceLocale();
  String? countryCode = deviceLocale?.countryCode;
  logger.d('Country code: $countryCode');
  return countryCode?.toLowerCase();
}
