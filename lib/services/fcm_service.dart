import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FCMService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> initFCM() async {
    var s = await getDeviceToken();
    print("token: $s");
    NotificationSettings settings = await messaging.requestPermission();
    if (!(settings.authorizationStatus == AuthorizationStatus.authorized)) {
      return;
    }
    forGroundMessaging();
    print('User granted permission: ${settings.authorizationStatus}');
  }

  static Future<String?> getDeviceToken() async {
    return await messaging.getToken();
  }

  void forGroundMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {}
      await AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 10,
              channelKey: 'basic_channel',
              actionType: ActionType.Default,
              title: message.notification!.title,
              body: message.notification!.body,
              backgroundColor: Colors.green,
              color: Colors.red));
      addNotification(message.data, message.notification!.title!,
          message.notification!.body!);
    });
  }
}


Future<void> addNotification(dynamic data, String title, String body) async {
  var db = FirebaseFirestore.instance;
  var notificationsCollection = db.collection("notifications");
  await notificationsCollection.doc().set(
    {
      "title": title,
      "body": body,
      "data": data,
    },
  );
}
