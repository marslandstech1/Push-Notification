// step 1 -> Create a flutter app
//
// step 2 -> create views folder inside -> lib folder after that -> go inside views folder and create a stateful widget like ->
// home_screen.dart (it must be stateful widget) -> because we need initState() method to work with PushNotification
//
// step 3 -> Render home_screen.dart from main.dart as first screen from home: (Named Argument)
//
// Now all setup is done to work with Pushnotification
//
// step 4 -> add these 3 Dependencies in pubspec.yaml
// 1.firebase_core: ^1.12.0
// 2.firebase_messaging: ^11.2.6
// 3.flutter_local_notifications: ^9.2.0
//
// Step 5 -> Setup firebase project at  https://console.firebase.google.com/
//
// NOTE : -> After setup firebase project you can receive simple pushnotification from firebase cloud messaging
//
// Step 6.Add this lines to main() method
//
// 1. WidgetsFlutterBinding.ensureInitialized();
// 2. await Firebase.initializeApp();
//
// Step 7. Now write some code in main.dart to start firebase background services
// 1. add this method after import statement in main.dart
//
// Future<void> backgroundHandler(RemoteMessage message) async {
// print(message.data.toString());
// print(message.notification!.title);
// }
//
// 2. call this method from main method after await Firebase.initializeApp();
//
// FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//
//
// Step 8. Go to the home_screen.dart and start work inside initState() Method
//
// @override
// void initState() {
// super.initState();
//
// // 1. This method call when app in terminated state and you get a notification
// // when you click on notification app open from terminated state and you can get notification data in this method
//
// FirebaseMessaging.instance.getInitialMessage().then(
// (message) {
// print("FirebaseMessaging.instance.getInitialMessage");
// if (message != null) {
// print("New Notification");
// // if (message.data['_id'] != null) {
// //   Navigator.of(context).push(
// //     MaterialPageRoute(
// //       builder: (context) => DemoScreen(
// //         id: message.data['_id'],
// //       ),
// //     ),
// //   );
// // }
// }
// },
// );
//
// // 2. This method only call when App in forground it mean app must be opened
// FirebaseMessaging.onMessage.listen(
// (message) {
// print("FirebaseMessaging.onMessage.listen");
// if (message.notification != null) {
// print(message.notification!.title);
// print(message.notification!.body);
// print("message.data11 ${message.data}");
// // LocalNotificationService.display(message);
//
// }
// },
// );
//
// // 3. This method only call when App in background and not terminated(not closed)
// FirebaseMessaging.onMessageOpenedApp.listen(
// (message) {
// print("FirebaseMessaging.onMessageOpenedApp.listen");
// if (message.notification != null) {
// print(message.notification!.title);
// print(message.notification!.body);
// print("message.data22 ${message.data['_id']}");
// }
// },
// );
// }
//
// Step 9. after all these you send a notification when your app in background then you see some warning in console when you tap on notification like this
// Missing Default Notification Channel metadata in AndroidManifest. Default value will be used.
// (Because of this warning you are not getting notification like we get in youtube and other app)
// to solve this add below line in AndroidManifest.xml
// <meta-data
// android:name="com.google.firebase.messaging.default_notification_channel_id"
// android:value="pushnotificationapp"/>
//
// Step 10
// After donign this you get another warning (this warning will show when you send notification with channel name pushnotificationapp
// Notification Channel requested (pushnotificationapp) has not been created by the app. Manifest configuration, or default, value will be used
// so now we need to create a channel with name pushnotificationapp  we do it with the help of flutter local notification
//
// step
// 11 go inside lib -> create folder -> notificationservice ->