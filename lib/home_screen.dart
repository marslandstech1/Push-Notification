import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gtribe/api_services/network.dart';
import 'package:gtribe/create_notification.dart';
import 'package:gtribe/notification_screen.dart';
import 'package:gtribe/push_notification/push_notification_class.dart';
import 'package:gtribe/widgets/custom_button.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    PushNotificationClass.setServerKey();
    PushNotificationClass.requestPermission();
    PushNotificationClass.setterDeviceToken();
    PushNotificationClass.fcmForegroundState(context);
    PushNotificationClass.fcmBackgroundState(context);
    PushNotificationClass.fcmTerminateState(context);
    PushNotificationClass.initializeSettingAndroidAndIos(context);
    // LocalNotification.initialize(context);
    // fetchFcmApi();
    fetchNotifyCount();
  }
  RemoteMessage remoteMessage = RemoteMessage();
  int notificationCount = 0;
  fetchNotifyCount()async{
    CollectionReference firebaseFirestore = FirebaseFirestore.instance.collection("alam");
    firebaseFirestore.where("isSeen", isEqualTo: false).snapshots().listen((QuerySnapshot querySnapshot){
      setState(() {
      notificationCount = querySnapshot.docs.length;
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        centerTitle: true,
        backgroundColor: Colors.pink[100],
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -10, end: -12),
              showBadge: notificationCount > 0,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationScreen()));
              },
              badgeContent: Text("$notificationCount",style: TextStyle(color: Colors.white),),
              child: Icon(Icons.notifications),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(PushNotificationClass.getDeviceToken, overflow: TextOverflow.ellipsis,),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(PushNotificationClass.getServerKey, overflow: TextOverflow.ellipsis,),
            ),
          ),
          CustomButton(
            onTap: (){
              // fetchFcmApi();
            },
            text: "Hit Notification API",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[100],
        onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>CreateNotification()));
        },
        child: Icon(Icons.notification_add),
      ),
    );
    
  }
}
