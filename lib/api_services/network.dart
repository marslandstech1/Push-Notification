import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gtribe/notification_screen.dart';
import 'package:gtribe/push_notification/push_notification_class.dart';
import 'package:http/http.dart' as http;
class Network{
  static fcmApiMethod(context,String token,fcmBody, fcmTitle, String topic)async {
    final url = Uri.parse("https://fcm.googleapis.com/v1/projects/push-notification-14cd2/messages:send");
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${PushNotificationClass.getServerKey}',
      "Accept":"application/json",
    };
    final body = {
      "message": {
        // "token": token,
        "topic":topic,
        "notification": {
          "body": fcmBody,
          "title": fcmTitle,
        },
      }
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
      );
    if(response.statusCode == 200){
      log("FCM Api Hit Success");
      final data = jsonDecode(response.body);
      return data;
    }else{
      log("FCM Api Hit Fail");
      return;
    }
  }
}