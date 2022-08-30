import 'dart:async';
import 'dart:io';

import 'package:burgernook/new_code/features/delivery_screen/presentation/views/delivery_screen.dart';
import 'package:burgernook/new_code/features/home/presentation/views/home_screen.dart';
import 'package:burgernook/new_code/features/on_boarding/presentation/on_boarding_screen.dart';
import 'package:burgernook/new_code/util/resources/Constants.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:animated_background/animated_background.dart';
import 'package:animated_background/particles.dart';
import 'package:burgernook/new_code/util/resources/app_assets.dart';
import 'package:flutter/material.dart';

import '../../../util/resources/PreferenceManger.dart';
import '../../Auth/presentation/controllers/login_controller.dart';

class SplashController extends GetxController{
  @override
  void onInit() {
    super.onInit();
    //  checkInternet();
    //handleFCM();
    // getToken();
    check();
    Timer(Duration(seconds: 4), () async {

      bool? isFirst =await PreferenceManager.getBoolean(AppConstants.isFirst);
      if (isFirst == null)  isFirst = false;
      if(!isFirst){
        Get.offAll(OnBoardingScreen());
      }else{
        if (isLogin) {
          if (isEmployee) {
            // Get.offAll(EmployeeScreen());

          } else if (isUser) {
             Get.offAll(HomeScreen());
          } else if (isDelivery) {
            Get.offAll(DeliveryViewScreen());
          } else if (isOwner) {
            // Get.offAll(OwnerScreen());

          }
        } else {
          // Get.offAll(UserScreen());
          Get.offAll(HomeScreen());

        }
      }

    });
  }

  void handleFCM() {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.subscribeToTopic('burger');
    if (Platform.isIOS) {
      _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }
  }


  ParticleOptions particleOptions = ParticleOptions(
    image: Image.asset(AppAssets.burger),
    baseColor: Colors.blue,
    spawnOpacity: 0.0,
    opacityChangeRate: 0.25,
    minOpacity: 0.1,
    maxOpacity: 0.4,
    spawnMinSpeed: 30.0,
    spawnMaxSpeed: 70.0,
    spawnMinRadius: 7.0,
    spawnMaxRadius: 15.0,
    particleCount: 20,
  );

  var particlePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;
}