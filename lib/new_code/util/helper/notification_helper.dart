import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'awesome_notifications_helper.dart';



class NotificationsHelper {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void configLocalNotification() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/ic_launcher');

    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    FlutterLocalNotificationsPlugin().initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    FirebaseMessaging.instance.getToken().then((String? value) {
      printInfo(info: value!);
    });

    FirebaseMessaging.instance.subscribeToTopic('burger');
    // FirebaseMessaging.instance.subscribeToTopic('burger_test');
    AwesomeNotificationsHelper.init();
    AwesomeNotificationsHelper.setListeners();
  }

  void registerNotification() {
    debugPrint('-------------registerNotification----------');
    _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      debugPrint('getInitialMessage');
      debugPrint(message.toString());
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Log.i(message.toMap().toString());
      if (Platform.isIOS) {
        message = modifyNotificationJson(message);
      }
      AwesomeNotificationsHelper.showNotifications(message);
    });

    FirebaseMessaging.onBackgroundMessage(
        (RemoteMessage message) => AwesomeNotificationsHelper.showNotifications(message));

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // Log.i(message.toMap().toString());
      onSelectNotification(
        json.encode(message.data),
      );
    });

    // _firebaseMessaging.onTokenRefresh.listen((fcmToken) {
    //   BlocProvider(
    //       create: (context) => LoginCubit()..doSaveDeviceToken(fcmToken));
    // }).onError((err) {});
  }

  static RemoteMessage modifyNotificationJson(RemoteMessage message) {
    print('message    ${message.notification.toString()}');
    message.data['data'] = Map.from(message.data);
    return message;
  }

  // Future<void> showNotification(RemoteMessage message) async {
  //   var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
  //     'com.ingaz.shipiing_client',
  //     'shipiing_client',
  //     'shipiing_client description',
  //     playSound: true,
  //     enableVibration: true,
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //   var platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //     iOS: const IOSNotificationDetails(),
  //   );
  //   // show local notification //
  //   await flutterLocalNotificationsPlugin.show(
  //     DateTime.now().microsecond,
  //     message.data['title'],
  //     message.data['body'],
  //     platformChannelSpecifics,
  //     payload: json.encode(message),
  //   );
  // }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    debugPrint('onDidReceiveLocalNotification');

    debugPrint('Notification data');

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title ?? ''),
        content: Text(body ?? ''),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {
              // Get.to(() => const NotificationsScreen());
            },
          )
        ],
      ),
    );
  }

  Future onSelectNotification(String? payload) async {
    // Get.to(() => const NotificationsScreen());
  }

}
