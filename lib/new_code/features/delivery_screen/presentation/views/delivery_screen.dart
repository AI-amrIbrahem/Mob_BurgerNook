import 'package:burgernook/new_code/features/Auth/presentation/controllers/login_controller.dart';
import 'package:burgernook/new_code/features/address/presentation/controllers/address_controller.dart';
import 'package:burgernook/new_code/features/home/presentation/views/home_screen.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:burgernook/new_code/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../util/resources/PreferenceManger.dart';
import '../../../Auth/data/models/user_model.dart';
import '../../../orders/presentation/controllers/order_controller.dart';
import '../../../orders/presentation/views/details_order_screen.dart';
import '../../../orders/presentation/views/widgets/order_item.dart';

class DeliveryViewScreen extends StatefulWidget {
  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryViewScreen> {
  var ordercontroller = Get.put(OrderController())..getAssignedOrders();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer(),
      appBar: AppBar(
        backgroundColor: Get.isDarkMode? AppColors.darkColor:AppColors.mainColor,
        title: Text("Delivery".tr),
        centerTitle: true,
      ),
      body: Obx(
        () => RefreshIndicator(
          color: AppColors.mainColor,
            onRefresh: () async {
              ordercontroller.getAssignedOrders();
            },
            child: ordercontroller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : ordercontroller.userOrdersList.value.isNotEmpty
                    ? ListView.builder(
                        itemCount: ordercontroller.userOrdersList.value.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsOrderScreen(
                                            isDriver: true,
                                            order: ordercontroller
                                                .userOrdersList.value[index],
                                            orderController: ordercontroller,
                                          )));
                            },
                            child: OrderItemWidget(
                              order:
                                  ordercontroller.userOrdersList.value[index],
                              funDeleteFromList: () {},
                              orderController: ordercontroller,
                            ),
                          );
                        })
                    : ListView(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 50.h),
                              child: emptyWidget()),
                        ],
                      )),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      backgroundColor:Get.isDarkMode? AppColors.darkColor: Colors.white,
      child: Container(
        // decoration: BoxDecoration(
        //     color: Colors.black,
        //     image: DecorationImage(
        //       image: AssetImage("assets/bg_logo.png"),
        //       fit: BoxFit.fill,
        //     )),
        child: ListView(
          children: <Widget>[
            Container(
              // height: 100.h,
              color:  Get.isDarkMode? AppColors.darkColor:
              AppColors.backDrawerColor,
              child: DrawerHeader(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage("assets/bg_logo.png"),
                //       fit: BoxFit.fill,
                //     )),
                child: Image.asset('assets/logopng.png'),
              ),
            ),
            Container(
              color: Get.isDarkMode? AppColors.darkColor:Colors.white,
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    leading: Image.asset(
                      "assets/home1.png",
                      height: 25.h,
                    ),
                    title: Text(
                      "Home".tr,
                      // style: TextStyle(
                      //   color: Colors.black,
                      // ),
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
                    ),
                    title: Text(
                      "${"lang".tr}",
                      // style: TextStyle(
                      //   color: Colors.black,
                      // ),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      if (await PreferenceManager.isLogin()) {
                        await PreferenceManager.setLogout();

                        await check();
                        userModelGlobal = UserModel();
                        Get.delete<AddressController>();
                      }

                      Get.offAll(HomeScreen());
                    },
                    leading: Icon(
                      Icons.arrow_forward,
                      color: AppColors.mainColor,
                    ),
                    title: Text(
                      "${"logout".tr}",
                      // style: TextStyle(
                      //   color: Colors.black,
                      // ),
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
}
