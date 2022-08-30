import 'package:burgernook/new_code/util/app/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'new_code/util/helper/notification_helper.dart';
import 'new_code/util/resources/PreferenceManger.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('_firebaseMessagingBackgroundHandler');
  // Log.i('_firebaseMessagingBackgroundHandler',
  //     tag: '_firebaseMessagingBackgroundHandler');
}
late PackageInfo packageInfo;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  packageInfo =await PackageInfo.fromPlatform();

  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);




  NotificationsHelper mNotificationSettings = NotificationsHelper();
  mNotificationSettings.configLocalNotification();
  mNotificationSettings.registerNotification();
  await PreferenceManager.init();
  isArabic = (await PreferenceManager.getIsArabic())!;
  isDark = (await PreferenceManager.getBoolean('isDark'))!;

  runApp(MyApp());
}

bool isArabic = true;
bool isDark = false;