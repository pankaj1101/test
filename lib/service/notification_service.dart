import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> saveTokenToFirestore() async {
    String? uid = _auth.currentUser?.uid;
    if (uid == null) return;
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        await _firestore.collection("users").doc(uid).set({
          "fcmToken": token,
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print('Error: $e');
      print("Error saving FCM token: $e");
    }
  }

  Future<void> setupFirebaseMessaging() async {
    await initLocalNotifications();

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Notification permission granted!");
    } else {
      print("Notification permission denied!");
    }
    onMessageReceive(); // Move this here
  }

  void onMessageReceive() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
        "Message received: ${message.notification?.title}, ${message.notification?.body}",
      );
      // if (message.notification != null) {
      //   // Handle the notification data
      //   print("Notification Data: ${message.data}");
      // }
      if (message.notification != null) {
        print("Notification Data: ${message.data}");

        // Show notification when app is in foreground
        showLocalNotification(message);
      }
    });
  }

  void showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.high,
          priority: Priority.high,
          ticker: 'ticker',
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? "No Title",
      message.notification?.body ?? "No Body",
      platformChannelSpecifics,
    );
  }
}
