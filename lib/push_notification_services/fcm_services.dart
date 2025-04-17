import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FCMServices{
  static fcmServices()async{
     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Message data: ${message.data}');
      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
        log('Notification title: ${message.notification?.title}');
        log('Notification body: ${message.notification?.body}');
      }
    });
  }
}