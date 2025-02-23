import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:local_notif_wrapper/local_notif_wrapper.dart';
import 'package:nb_utils/nb_utils.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  debugPrint('Title: ${message.notification?.title}');
  debugPrint('Body: ${message.notification?.body}');
  debugPrint('Payload: ${message.data}');
}

class FirebaseMessagingService {
  FirebaseMessagingService._();

  static final _firebaseMessaging = FirebaseMessaging.instance;

  static void _handleMessage(RemoteMessage? message) {
    if (message == null) return;
  }

  static Future<void> _initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      LocalNotifWrapper.showSimpleNotification(
        id: notification.hashCode,
        title: notification.title ?? '',
        body: notification.body ?? '',
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  static Future<void> initNotifications() async {
    if (!getBoolAsync("kIsFirebaseMessagingInitedKey")) {
      bool result = await InternetConnection().hasInternetAccess;
      if (!result) return;
    }
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null && fcmToken.trim().isNotEmpty) {
      setValue("kIsFirebaseMessagingInitedKey", true);
    }
    debugPrint('fcmToken: ${fcmToken}');
    _initPushNotifications();
  }
}
