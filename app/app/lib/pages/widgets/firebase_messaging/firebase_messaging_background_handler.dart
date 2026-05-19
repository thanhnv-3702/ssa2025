import 'dart:io';

import 'package:base_core/common/config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  logger.d(
    'firebaseMessagingBackgroundHandler: title=${message.notification?.title}, '
    'data=${message.data}, from=${message.from}, map=${message.toMap()}',
  );
  await _showNotificationForMessage(message);
}

const int _kBackgroundFcmNotificationId = 0x0;

FlutterLocalNotificationsPlugin? _notificationsPlugin;

Future<FlutterLocalNotificationsPlugin> _getNotificationsPlugin() async {
  if (_notificationsPlugin != null) return _notificationsPlugin!;
  _notificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings iosInit = DarwinInitializationSettings(
    requestAlertPermission: true,
  );
  const InitializationSettings initSettings = InitializationSettings(
    android: androidInit,
    iOS: iosInit,
  );
  await _notificationsPlugin?.initialize(initSettings);
  if (Platform.isAndroid) {
    await _notificationsPlugin
        ?.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
  return _notificationsPlugin!;
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'fcm_background_channel',
  'SAA 2025',
  description: 'Thông báo SAA 2025',
  importance: Importance.defaultImportance,
);

Future<void> _showNotificationForMessage(RemoteMessage message) async {
  try {
    final RemoteNotification? notification = message.notification;
    final String title = notification?.title ?? message.data['title'] ?? 'Notification';
    final String body = notification?.body ?? message.data['body'] ?? '';

    final plugin = await _getNotificationsPlugin();

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'fcm_background_channel',
      'SAA 2025',
      channelDescription: 'Thông báo SAA 2025',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await plugin.show(
      _kBackgroundFcmNotificationId,
      title,
      body,
      details,
    );
  } catch (e, st) {
    debugPrint('firebaseMessagingBackgroundHandler: failed to show notification: $e\n$st');
  }
}
