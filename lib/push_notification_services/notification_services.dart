import 'dart:developer';
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gtribe/notification_screen.dart';


class NotificationServices {
  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //initialising firebase message plugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //initialising the token
  String? _token;
  String? get token => _token;

  // Request permission for notifications
  //send notifications request
  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
      providesAppNotificationSettings: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
      Future.delayed(const Duration(seconds: 2), () {
        AppSettings.openAppSettings(
          type: AppSettingsType.notification,
        );
      });
    }
  }

  // Get the device token
  Future<String?> getDeviceToken() async {
    requestPermission();
    _token = await messaging.getToken();
    log("Device Token: $_token");
    return _token;
  }

  // Setting Local Notification Plugin for Android and IOS & package initialization.
  // RemoteMessage get from firebase messaging pacakage.
  // when my app in running state then this function execution and working.
  void initializeFlutterLocalNotificationPlugin(
      BuildContext context, RemoteMessage remoteMessage) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
   var initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestAlertPermission: true,
      requestBadgePermission: true,
    );
     InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      handlerMsg(context, remoteMessage);
    });
  }

  // This is use to set notification when app in the running state like forground state.
  void firebaseMessageListener(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      RemoteNotification? remoteNotification = remoteMessage.notification;
      AndroidNotification? androidNotification =
          remoteMessage.notification?.android;

      if (kDebugMode) {
        print("notifications title:${remoteNotification!.title}");
        print("notifications body:${remoteNotification.body}");
        print('count:${androidNotification!.count}');
        print('data:${remoteMessage.data.toString()}');
      }
      // if platform is ios
      if (Platform.isIOS) {
        // make method for ios forground message
        iosForgroundMessage();
      }
      if (Platform.isAndroid) {
        initializeFlutterLocalNotificationPlugin(context, remoteMessage);
        showPopupOfNotificationOnPhoneBar(remoteMessage);
      }
    });
  }

  void iosForgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // For background or terminate state.
  Future<void> setUpNotifyMessageForBackgroundTerminateState(context) async {
    // Background State
    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      handlerMsg(context, remoteMessage);
    });

    // Terminate state
    // my app is close or end.
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null && remoteMessage.data.isNotEmpty) {
        handlerMsg(context, remoteMessage);
      }
    });
  }

  // handler Msg.
  Future<void> handlerMsg(
    BuildContext context,
    RemoteMessage remoteMessage,
  ) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => NotificationScreen()));
  }

  // This function show popup of notification msg on mobile bar.
  Future<void> showPopupOfNotificationOnPhoneBar(RemoteMessage message) async {
    // Create channel of msg
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      "push_notification",
      importance: Importance.max,
      showBadge: true,
      playSound: true,
      // sound: const RawResourceAndroidNotificationSound('jetsons_doorbell'),
    );
// setup android setting detail.
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: 'your channel description',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            ticker: 'ticker',
            sound: channel.sound
            //     sound: RawResourceAndroidNotificationSound('jetsons_doorbell')
            //  icon: largeIconPath
            );

// setup ios setting detail.
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    // Marging ios & android details setting.
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    // finally show notification in phone bar.
    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
        204,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
        payload: "Azan Notification",
      );
    });
  }
}
