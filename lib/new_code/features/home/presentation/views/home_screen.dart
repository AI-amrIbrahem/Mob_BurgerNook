import 'dart:io';

import 'package:burgernook/new_code/features/Auth/data/models/user_model.dart';
import 'package:burgernook/new_code/features/Auth/presentation/controllers/login_controller.dart';
import 'package:burgernook/new_code/features/Auth/presentation/views/login_screen.dart';
import 'package:burgernook/new_code/features/address/presentation/controllers/address_controller.dart';
import 'package:burgernook/new_code/features/basket/presentation/views/basket_screen.dart';
import 'package:burgernook/new_code/features/home/presentation/controllers/home_controller.dart';
import 'package:burgernook/new_code/features/orders/presentation/views/order_screen.dart';
import 'package:burgernook/new_code/util/app/my_app.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:burgernook/new_code/widgets/categoryWidget.dart';
import 'package:burgernook/new_code/widgets/version_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../util/resources/Constants.dart';
import '../../../../util/resources/PreferenceManger.dart';
import '../../../../util/resources/theme_controller.dart';
import '../../../../widgets/home_slider.dart';
import '../../../../widgets/second_category_widget.dart';
import '../../../about_us/presentation/views/about_us_view.dart';
import '../../../basket/presentation/controllers/basket_controller.dart';
import '../../../report/presentation/views/report.dart';
import '../../data/models/category_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  int counter = 0;
  final homeController = Get.put(HomeController());

  var basketController = Get.put(BasketController())
    ..getLockups()
    ..isResturantWork();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _globalKey,
      drawer: _drawer(),
      appBar: AppBar(

        centerTitle: true,
        title: Text(
          'burger'.tr,
          style: TextStyle(color: AppColors.White),
        ),
        leading: Container(
          padding: EdgeInsets.all(15),
          child: InkWell(
            onTap: () {
              _globalKey.currentState!.openDrawer();
            },
            child: Image.asset(
              "assets/menu.png",
              color:Get.isDarkMode? AppColors.lightColor :null,

            ),
          ),
        ),
        backgroundColor: Get.isDarkMode? AppColors.darkColor:AppColors.mainColor,
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BasketMainScreen()));
            },
            child: GetBuilder<BasketController>(
              builder: (_) => Container(
                margin: EdgeInsets.symmetric(horizontal: 15.h),
                child: basketController.orderDetails.isNotEmpty
                    ? Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/basket1.png",
                              color:Get.isDarkMode? AppColors.lightColor :null,
                              height: 30.h,
                              width: 30.w,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: AnimatedContainer(
                              curve: Curves.easeOutSine,
                              duration: Duration(milliseconds: 600),
                              width: basketController.widthBasket,
                              margin: EdgeInsets.only(bottom: 20),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: basketController.colorBasket,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${basketController.orderDetails.length}',
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontFamily: "arlrdbd",
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Image.asset(
                        "assets/basket1.png",
                  color:Get.isDarkMode? AppColors.lightColor :null,

                  height: 30.h,
                        width: 30.w,
                      ),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          children: <Widget>[
            Obx(() => homeController.isSliderLoading.value
                ? Container()
                : HomeSliderWidget(
                    slides: homeController.sliders,
                  )),
            Obx(() => homeController.isLading.value
                ? _ladingWidget()
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    children: homeController.isLading.value
                        ? [
                            _ladingWidget(),
                            _ladingWidget(),
                            _ladingWidget(),
                          ]
                        : homeController.categories
                            .map((CategoryModel category) {
                            if (category.products != null) {
                              if (category.products!.isNotEmpty) {
                                counter++;
                                if (counter % 2 == 0) {
                                  return SecondCategoryWidget(
                                    category: category,
                                  );
                                }
                                return CategoryWidget(
                                  category: category,
                                );
                              }
                            }
                            return Container();
                          }).toList(),
                  )),
          ],
        ),
      ),
    );
  }

  Widget _ladingWidget() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.h),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              height: 210.h,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Card(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child: CircularProgressIndicator(
                              color: AppColors.mainColor,
                            ),
                            width: 150.w,
                            height: 100.h,
                          ),
                          Text(''),
                          Text(''),
                          Text(''),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child: CircularProgressIndicator(
                              color: AppColors.mainColor,
                            ),
                            width: 150.w,
                            height: 100.h,
                          ),
                          Text(''),
                          Text(''),
                          Text(''),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child: CircularProgressIndicator(
                              color: AppColors.mainColor,
                            ),
                            width: 150.w,
                            height: 100.h,
                          ),
                          Text(''),
                          Text(''),
                          Text(''),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child: CircularProgressIndicator(
                              color: AppColors.mainColor,
                            ),
                            width: 150.w,
                            height: 100.h,
                          ),
                          Text(''),
                          Text(''),
                          Text(''),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child: CircularProgressIndicator(
                              color: AppColors.mainColor,
                            ),
                            width: 150.w,
                            height: 100.h,
                          ),
                          Text(''),
                          Text(''),
                          Text(''),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
// backgroundColor:Get.isDarkMode? AppColors.darkColor: AppColors.White,
        child: ListView(

      shrinkWrap: true,
      children: <Widget>[
        Container(
          height: 150.h,
          // color: Get.isDarkMode? AppColors.darkColor: AppColors.White,
          child: DrawerHeader(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            child: Image.asset('assets/logopng.png'),
          ),
        ),
        isLogin &&
                (userModelGlobal.employeeJob == '1' ||
                    userModelGlobal.employeeJob == '2')
            ? ListTile(

                onTap: () {
                  // Navigator.pop(context);
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => OwnerScreen()));
                },
                leading: Icon(
                  Icons.dashboard,
                  color: AppColors.mainColor,
                  size: 20.w,
                ),
                title: Container(
                  child: Text(
                    "Dashboard".tr,
                    style: TextStyle(
                     // color: Colors.black,
                        fontSize: 13.sp

                    ),
                  ),
                ),
              )
            : Container(),
        Container(
          // color: Get.isDarkMode? AppColors.darkColor: AppColors.White,
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: Image.asset(
                  "assets/home1.png",
                  height: 20.w,
                ),
                title: Text(
                  "Home".tr,
                  style: TextStyle(
                    // color: Colors.black,
                    fontSize: 13.sp
                  ),
                ),
              ),
              isLogin?
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrdersViewScreen()));
                },
                leading: Image.asset(
                  "assets/basket.png",
                  height: 20.w,
                ),
                title: Text(
                  "Follow Orders".tr,
                  style: TextStyle(
                    // color: Colors.black,
                      fontSize: 13.sp

                  ),
                ),
              ):Container(),
              isLogin?
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReportViewScreen()));
                },
                leading: Icon(
                  Icons.report,
                  color: AppColors.mainColor,
                  size: 20.w,

                ),
                title: Text(
                  "Complaints".tr,
                  style: TextStyle(
                   // color: Colors.black,
                      fontSize: 13.sp

                  ),
                ),
              ):Container(),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AboutUsViewScreen()));
                },
                leading: Icon(
                  Icons.message,
                  color: AppColors.mainColor,
                  size: 20.w,

                ),
                title: Text(
                  "about us".tr,
                  style: TextStyle(
                   // color: Colors.black,
                      fontSize: 13.sp

                  ),
                ),
              ),
              isLogin
                  ? Container()
                  : ListTile(
                      onTap: () {
                        // Navigator.pop(context);
                        Get.back();
                        Get.to(LoginViewScreen());
                        // Navigator.pushNamed(context, '/LoginScreen');
                      },
                      leading: Icon(
                        Icons.exit_to_app,
                        color: AppColors.mainColor,
                        size: 20.w,

                      ),
                      title: Text(
                        "login".tr,
                        style: TextStyle(
                        //  color: Colors.black,
                            fontSize: 13.sp

                        ),
                      ),
                    ),
              !isLogin
                  ? Container()
                  : ListTile(
                      onTap: () async {
                        if (await PreferenceManager.isLogin()) {
                          await PreferenceManager.setLogout();
                          await check();
                          userModelGlobal = UserModel();
                          Get.delete<AddressController>();
                          setState(() {});
                        }
                        Navigator.pop(context);
                      },
                      leading: Icon(
                        Icons.arrow_forward,
                        color: AppColors.mainColor,
                        size: 20.w,

                      ),
                      title: Text(
                        "logout".tr,
                        style: TextStyle(
                         // color: Colors.black,
                            fontSize: 13.sp

                        ),
                      ),
                    ),


              ListTile(
                onTap: () async {
                  Navigator.pop(context);

                  if (Get.locale!.languageCode == "en") {
                    Get.updateLocale(new Locale("ar", 'AR'));
                    PreferenceManager.setIsArabic(true);
                    // helper.onLocaleChanged(new Locale("ar"));
                    // await MySharedPreferences()
                    //     .saveProviderLangSharedPref(languageCode: "ar");
                  } else {
                    Get.updateLocale(new Locale("en", 'US'));
                    PreferenceManager.setIsArabic(false);
                    // helper.onLocaleChanged(new Locale("en"));
                    // await MySharedPreferences()
                    //     .saveProviderLangSharedPref(languageCode: "en");
                  }
                },
                leading: Icon(
                  Icons.language,
                  color: AppColors.mainColor,
                  size: 20.w,

                ),
                title: Text(
                  "lang".tr,
                  style: TextStyle(
                  //  color: Colors.black,
                      fontSize: 13.sp

                  ),
                ),
              ),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                   // ThemeController.toggle();
                  //Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
                  //Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                  // Get.changeTheme(Get.isDarkMode? ThemeData.light(): ThemeData.dark());
                  MyApp.theme.toggle();
                  //Phoenix.rebirth(context);

                  // FlutterRestart.restartApp();
                },
                leading: Icon(
                  context.isDarkMode ? Icons.sunny:Icons.nightlight_outlined,
                  color: AppColors.mainColor,
                  size: 20.w,

                ),
                title: Text(
                  "mode".tr,
                  style: TextStyle(
                 //   color: Colors.black,
                      fontSize: 13.sp

                  ),
                ),
              ),
              !isLogin
                  ? Container()
                  :Platform.isIOS ? ListTile(
                onTap: () async {
                  homeController.deactive(user_id: userModelGlobal.id,context: context).then((value) async{
                    if (await PreferenceManager.isLogin()) {
                      await PreferenceManager.setLogout();
                      await check();
                      userModelGlobal = UserModel();
                      Get.delete<AddressController>();
                      setState(() {});
                    }
                    Navigator.pop(context);
                  });
                },
                leading: Icon(
                  Icons.lock,
                  color: AppColors.mainColor,
                  size: 20.w,

                ),
                title: Text(
                  "deactive".tr,
                  style: TextStyle(
                    //   color: Colors.black,
                      fontSize: 13.sp

                  ),
                ),
              ):Container(),
            ],
          ),
        ),
        //  VersionWidget()
      ],
    ));
  }

  Future<void> _refresh() async {
    homeController.refresh();
  }

}