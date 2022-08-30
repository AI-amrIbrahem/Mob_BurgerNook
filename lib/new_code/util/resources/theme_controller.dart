

import 'package:burgernook/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import 'ColorsUtils.dart';
import 'PreferenceManger.dart';

class ThemeController extends GetxController {

  late bool _isDarkMode;
  bool get isDarkMode => _isDarkMode;

  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  ThemeController() {
    _isDarkMode = isDark;
    if (isDarkMode) {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
              statusBarColor: AppColors.darkColor,
              statusBarIconBrightness: Brightness.light
          )
      );
    }else{
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
              statusBarColor: AppColors.mainColor,
              statusBarIconBrightness: Brightness.dark
          )
      );
    }
  }

  // TextTheme get _textTheme {
  //   return GoogleFonts.latoTextTheme();
  // }

  ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      drawerTheme: DrawerThemeData(
        backgroundColor:  AppColors.White,
      ),
      appBarTheme:  AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: AppColors.lightColor,
        ),
        titleTextStyle:TextStyle(
            fontFamily: "GE_Dinar_One_Medium",
            fontSize: 23.sp),
      ),

      // textTheme: _textTheme,
      primaryColorLight: AppColors.lightColor,
      // colorScheme: ColorScheme.fromSwatch(
      //   primarySwatch: MaterialColor(AppColors.lightColor.value, AppColors.swatch),
      //   accentColor:  MaterialColor(AppColors.lightColor.value, AppColors.swatch),
      //   primaryColorDark: MaterialColor(AppColors.lightColor.value, AppColors.swatch),
      // ),
      toggleableActiveColor: AppColors.mainColor,

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: AppColors.darkColor,
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      drawerTheme: DrawerThemeData(
        backgroundColor:  AppColors.darkColor,
      ),
      appBarTheme:  AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: AppColors.darkColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle:TextStyle(
            fontFamily: "GE_Dinar_One_Medium",
            fontSize: 23.sp),
      ),
      // textTheme: _textTheme
      //     .merge(
      //   ThemeData.dark().textTheme,
      // ),
      //     .apply(
      //   fontFamily: _textTheme.bodyText1!.fontFamily,
      // ),

      scaffoldBackgroundColor: AppColors.darkColor,
      primaryColorDark: AppColors.darkColor,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.darkColor,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Colors.white,
        ),
      ),
      // ),
      toggleableActiveColor: AppColors.mainColor,

      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(AppColors.acentColor),
        trackColor: MaterialStateProperty.all(
          AppColors.acentColor.withOpacity(0.6),
        ),
      ),
    );
  }

   void toggle() {

     var x = Get.isDarkMode;

     Get.changeTheme(
       x ? lightTheme:  darkTheme,
     );

     Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
     PreferenceManager.setIsArabic(true);



    if (!x) {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
              statusBarColor: AppColors.darkColor,
              statusBarIconBrightness: Brightness.light
          )
      );
    }else{
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
              statusBarColor: AppColors.mainColor,
              statusBarIconBrightness: Brightness.dark
          )
      );
    }
     isDark=!x;
     print('!x ${!x}');
     PreferenceManager.saveBoolean('isDark',!x);
    // notifyListeners();
  }
}