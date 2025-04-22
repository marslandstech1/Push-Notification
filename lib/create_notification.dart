import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gtribe/home_screen.dart';
import 'package:gtribe/notification_screen.dart';
import 'package:gtribe/widgets/custom_button.dart';
import 'package:gtribe/widgets/custom_text_form_field.dart';

import 'api_services/network.dart';
import 'helper/utils.dart';

class CreateNotification extends StatefulWidget {
  const CreateNotification({super.key});

  @override
  State<CreateNotification> createState() => _CreateNotificationState();
}

class _CreateNotificationState extends State<CreateNotification> {
  TextEditingController titleCon = TextEditingController();
  TextEditingController bodyCon = TextEditingController();
  TextEditingController dataCon = TextEditingController();
  final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Notification"),
        backgroundColor: Colors.pink[100],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              CustomTextFormField(
                controller: titleCon,
                labelText: 'Title...',
                hintText: 'Enter your Title...',
                keyboardType: TextInputType.text,
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    Utils.toastMsg("Enter Title...");
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                controller: bodyCon,
                labelText: 'Body...',
                hintText: 'Enter your Body...',
                keyboardType: TextInputType.text,
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    Utils.toastMsg("Enter Body...");
                  }
                  return null;
                },
              ),
              CustomButton(
                text: "Create Notification",
                onTap: ()async{
                  try{
                  final fcmTitle = titleCon.text.toString();
                  final fcmBody = bodyCon.text.toString();
                  final token = "dL4AhASZSFiraSwflFkTg7:APA91bGYap-JlvB7xNxklxwegU1xaD_8bt8qn2P77uz3jZJJsoT1s9IEG6_8CrAQM833L9MxWx-SnsWx0jFJ9e93HtA-G8I9qK7jIU5qG8SCWhHvdmX-dBY";
                  final apiResponse = await Network.fcmApiMethod(
                    context,
                      // token,
                      "all",
                      fcmBody,
                      fcmTitle
                  );
                  if(apiResponse != null && apiResponse != ""){
                    Utils.toastMsg("Api Response");
                    log("Api Res: $apiResponse");
                    log("Api Res Name: ${apiResponse["name"]}");
                    FirebaseFirestore.instance.collection("alam").doc("$id").set({
                      "alam":false,
                      "isSeen":false,
                      "isActive":false,
                      "screen":"notification",
                      "fcmTitle":fcmTitle,
                      "fcmBody":fcmBody,
                    }).then((value){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
                      // Navigator.pop(context);
                    }).onError((e,s){
                      log("Error: $e");
                      log("Error Line: $s");
                    });
                  }
                  }catch(e){
                    log("Error $e");
                  }


                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
