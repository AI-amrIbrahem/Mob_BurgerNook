import 'package:burgernook/new_code/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../../main.dart';
import '../lang/translaion_file.dart';
import '../resources/theme_controller.dart';

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  static var theme = ThemeController();

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
          translations: Languages(),
          locale: isArabic ?     Locale('ar', 'AR') :Locale('en') ,// Get.deviceLocale,
          fallbackLocale: isArabic ?  Locale('ar', 'AR') : Locale('en')  ,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          themeMode: ThemeController().themeMode,
          theme: ThemeController().lightTheme,
          darkTheme: ThemeController().darkTheme,
          home: SplashScreen()
      ),
    );
 }
}