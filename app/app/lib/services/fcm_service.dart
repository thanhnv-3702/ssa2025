import 'dart:io';

import 'package:base_core/common/config.dart';
import 'package:base_core/storage/storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stacked/stacked.dart';

/// FCM (Firebase Cloud Messaging) service: token, permission, foreground/background handlers.
/// Requires [Firebase.initializeApp] before [init].
class FcmService with ListenableServiceMixin {
  FcmService._();

  static final FcmService _instance = FcmService._();

  static FcmService get instance => _instance;

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Call after [Firebase.initializeApp]. Requests permission (iOS), gets token, subscribes to messages.
  Future<void> init(StorageService storageService) async {
    try {
      await _requestPermission();
      await _subscribeToTokenRefresh(storageService);
      await _getAndSaveToken(storageService);
    } catch (e) {
      logger.e('FcmService init error: $e');
    }
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    logger.d('FCM permission: ${settings.authorizationStatus}');
  }

  Future<void> _subscribeToTokenRefresh(StorageService storageService) async {
    _messaging.onTokenRefresh.listen((String token) {
      logger.d('FCM token refreshed');
      storageService.setString(StorageKey.keyFCMToken.name, token);
    });
  }

  /// Get current FCM token and save to storage. Call after login to register with backend.
  Future<String?> getAndSaveToken(StorageService storageService) async {
    return _getAndSaveToken(storageService);
  }

  Future<String?> _getAndSaveToken(StorageService storageService) async {
    try {
      final apnsToken = Platform.isIOS ? await _messaging.getAPNSToken() : null;
      logger.d(
        'FCM token fetch: platform=${Platform.operatingSystem}, '
        'apns=${apnsToken != null ? 'present(${apnsToken.length})' : 'null'}',
      );
      final token = await _messaging.getToken();
      logger.d(
        'FCM getToken: ${token != null ? 'present(${token.length} chars)' : 'null'}',
      );
      if (token != null && token.isNotEmpty) {
        await storageService.setString(StorageKey.keyFCMToken.name, token);
        logger.d('FCM token saved (${token.length} chars)');
        return token;
      }
    } catch (e) {
      logger.e('FCM getToken error: $e');
    }
    return null;
  }

  /// Foreground: when a message is received while app is in foreground.
  void onForegroundMessage(void Function(RemoteMessage message) handler) {
    FirebaseMessaging.onMessage.listen(handler);
  }

  /// When user taps notification (app opened from terminated or background).
  void onMessageOpenedApp(void Function(RemoteMessage message) handler) {
    FirebaseMessaging.onMessageOpenedApp.listen(handler);
  }

  /// Call to get initial message if app was opened from terminated state by tapping notification.
  Future<RemoteMessage?> getInitialMessage() {
    return _messaging.getInitialMessage();
  }
}
