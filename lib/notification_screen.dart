import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  final RemoteMessage? remoteMessage;
  final VoidCallback? refreshCallback;
  const NotificationScreen({super.key, this.remoteMessage, this.refreshCallback});
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  // update
  Future<void> updateIsSeenStatus(String docId,){
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('alam');
    return collectionReference.doc(docId).update({'isSeen': true})
        .then((value) => log("User See Notification & Update Status"))
        .catchError((error) => log("Failed : $error"));
  }
  // del
  Future<void> deleteDoc(String docId) {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('alam');
    return collectionReference.doc(docId).delete()
        .then((value) => log("Doc deleted successfully!"))
        .catchError((error) => log("Failed to delete doc: $error"));
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> alam = FirebaseFirestore.instance.collection('alam').snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification UI"),
        centerTitle: true,
        backgroundColor: Colors.pink[100],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: alam,
        builder: (BuildContext context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error state
          if (snapshot.hasError) {
            return Center(
              child: Text("Error occurred: ${snapshot.error}"),
            );
          }

          // Empty data state
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No notifications available"),
            );
          }

          // Data loaded successfully
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            final documents = snapshot.data!.docs;


            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final data = documents[index].data() as Map<String, dynamic>;
                final docId = documents[index].id;
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                    log("Doc ID: $docId");
                    updateIsSeenStatus(docId);
                  },
                  child: Card(
                    elevation: data["isSeen"] == true ? 0 : 10,
                    color: data["isSeen"] == true ? Colors.green[100] : Colors.pink[100],
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        data['fcmTitle'] ?? 'No title',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(data['fcmBody'] ?? 'No content'),
                      leading:  Icon(data["isSeen"] == true ? Icons.done :Icons.notifications, color: Colors.pink),
                      trailing: data["isSeen"] == true ? IconButton(onPressed: (){
                        log("Del ID: $docId");
                        if(data["isSeen"] == true)deleteDoc(docId);
                      }, icon: Icon(Icons.delete, color: Colors.pink,)): null,
                    ),
                  ),
                );
              },
            );
          }
          // Default fallback (shouldn't normally reach here)
          return const Center(child: Text("Loading..."));
        },
      ),
    );
  }
}