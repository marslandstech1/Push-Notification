import 'dart:developer';
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gtribe/home_screen.dart';
import 'package:gtribe/notification_screen.dart';

import 'get_server_key.dart';

class PushNotificationClass {
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static String _deviceToken = "";
  static String _serverKey ="";
  static String get getServerKey => _serverKey;
  static String get getDeviceToken => _deviceToken;
  static bool isMsgPopup = false;
  static void requestPermission() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
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
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
      Future.delayed(const Duration(seconds: 2), () {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      });
    }
  }
  // static Future<void> handlerMsg(BuildContext context, RemoteMessage remoteMessage) async {
  //   if(isMsgPopup == true || remoteMessage.data["screen"] == "notification"){
  //     Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationScreen(remoteMessage: remoteMessage)));
  //     isMsgPopup = false;
  //   }else{
  //     Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
  //   }
  // }
  static Future<String?> setterDeviceToken()async{
    requestPermission();
    String? token = await firebaseMessaging.getToken();
    if(token != null && token.isNotEmpty){
      _deviceToken = token.toString();
      log("Device Token: $token");
    }
    return _deviceToken;
  }
  static Future<String> setServerKey()async{
    _serverKey = await GetServerKey.getServerKeyToken();
    log("Server Key: $_serverKey");
    return _serverKey;
  }
  // This method call when app foreground or running state.
  static fcmForegroundState(context)async{
    FirebaseMessaging.onMessage.listen((foregroundMsg){
      log("On Message or App Running State");
      log("This Method Of Foreground State");
      if(foregroundMsg.notification != null){
        log("Foreground State Notification Ok");
        log("Notification Title: ${foregroundMsg.notification?.title}");
        log("Notification Body: ${foregroundMsg.notification?.body}");
       // LocalNotification.createanddisplaynotification(foregroundMsg);
        if(Platform.isIOS){
          FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          );

        }
        if(Platform.isAndroid){
          displayNotification(foregroundMsg);
        }
      }

    });
  }
 // 2. This method call when app background state.
static fcmBackgroundState(context){
    FirebaseMessaging.onMessageOpenedApp.listen((bgStateMsg){
      log("On Message Open App");
      log("This Method Of Background State");
      if(bgStateMsg.notification != null){
        log('Background State Notification Ok');
        log("Notification Title: ${bgStateMsg.notification?.title}");
        log("Notification Body: ${bgStateMsg.notification?.body}");
       // isMsgPopup = true;
       // handlerMsg(context, bgStateMsg);

      }

    });
}
  // 3. This method call when app is terminate state.
  static fcmTerminateState(context){
    FirebaseMessaging.instance.getInitialMessage().then((terminateStateMsg){
      log("Get Initial Message");
      log("This Method Of Terminate State");
      if(terminateStateMsg != null){
        log("Terminate State Notification OK");
        log("Notification Title: ${terminateStateMsg.notification?.title}");
        log("Notification Body: ${terminateStateMsg.notification?.body}");
       // isMsgPopup = true;
       // handlerMsg(context, terminateStateMsg);

      }
    });
  }
  // This method call for initialize setting of android & ios.
static void initializeSettingAndroidAndIos(context)async{
    final AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("@mipmap/ic_launcher");
    final DarwinInitializationSettings darwinInitializationSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestProvisionalPermission: true,
      requestSoundPermission: true,

    );
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse notificationResponse){
          isMsgPopup = true;
          log("Notification Response ${notificationResponse.id}");
          log("Notification Response ${notificationResponse.data}");
          log("Notification Response ${notificationResponse.data["screen"]}");
          Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationScreen()));

        }
    );
}
static void displayNotification(RemoteMessage remoteMessage)async{
  final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
    "push_notification",
    "Alam Notify",
    importance: Importance.max,
    playSound: true,

  );
  final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      androidNotificationChannel.id,
      androidNotificationChannel.name,
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,

  );
  final DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentBanner: true,
    presentSound: true,
  );
  NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: darwinNotificationDetails,
  );
  Future.delayed(Duration.zero, (){
    flutterLocalNotificationsPlugin.show(
        id,
        remoteMessage.notification?.title.toString(),
        remoteMessage.notification?.body.toString(),
        notificationDetails
    );
  });
}
}
