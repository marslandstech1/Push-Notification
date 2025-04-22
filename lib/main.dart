import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gtribe/home_screen.dart';
import 'package:gtribe/push_notification/push_notification_class.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  log("Top Title: ${message.notification?.title}");
  log("Top Body: ${message.notification?.body}");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
Future<void> setupNotificationChannel() async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // Same as in AndroidManifest.xml
    'High Importance Notifications',
    importance: Importance.high,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('notification_sound'),
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

void main(context) async {
  WidgetsFlutterBinding.ensureInitialized();
  PushNotificationClass.initializeSettingAndroidAndIos(context);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
  await setupNotificationChannel();
  try {
    await dotenv.load(fileName: ".env"); // Load environment variables
  } catch (e) {
    throw Exception('Error loading .env file: $e'); // Print error if any
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    subscribe();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Push Notification',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
  subscribe()async{
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.subscribeToTopic("all");
    log("Notification To All User");
    //1.
    // In this section you handle accordingly like user, admin, pointment use.
    // where call fcm api  function instead of token use {"topic":"all"} and commit //token
    // and next in postmen commit token and add "topic":"all" to sent all user of app.


    //2.
    // sent notification according to req, cluster diff group etc.
  }
}
