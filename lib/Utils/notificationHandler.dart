import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
Map<String, dynamic> message;
String tokenID;
class notificationHandler{
  final FirebaseMessaging _fcm = FirebaseMessaging();
  Future initialize() async {
    _fcm.getToken().then((deviceToken){
      print("DeviceToken: $deviceToken");
      tokenID = deviceToken;
      Firestore.instance.collection('DeviceTokens').document().setData({'tokenID': tokenID , 'platform': Platform.operatingSystem , 'creation_time': ServerValue.timestamp});
    });
    _fcm.configure(
      //Foreground Notification
        onMessage: (message) async {
          print("onMessage: $message");
        },
        //Notification for cold start of app
        onLaunch: (message) async {
          print("onLaunch: $message");
        },
        //Notification for resuming the app from background
        onResume: (message) async {
          print("onResume: $message");
        }
    );
  }
}