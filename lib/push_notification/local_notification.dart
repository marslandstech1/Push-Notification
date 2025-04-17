import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gtribe/notification_screen.dart';

class LocalNotification{

  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  static void initialize(context) {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );
    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload){
        log("On Did Receive Notification Move Notification UI");
        if(payload.id != null){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NotificationScreen(),
            ),
          );
        }
    }
    );
  }
  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "push_notification",
          "pushnotificationappchannel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['_id'],
      );
    } on Exception catch (e) {
      log("$e");
    }
  }
}