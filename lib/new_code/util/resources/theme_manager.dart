import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


ThemeData getApplicationThemeLight() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: AppColors.mainColor,
          statusBarIconBrightness: Brightness.dark
      )
  );
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  return ThemeData(
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.mainColor,
            statusBarIconBrightness: Brightness.dark
        ),
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle:TextStyle(
              color: Colors.black,
              fontFamily: "GE_Dinar_One_Medium",
              fontSize: 23)
      ),
      primarySwatch: Colors.amber,

      fontFamily: "GE_Dinar_One_Medium");
}



