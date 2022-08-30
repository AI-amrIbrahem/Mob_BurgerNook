import 'package:burgernook/new_code/features/orders/presentation/controllers/order_controller.dart';
import 'package:burgernook/new_code/features/orders/presentation/views/widgets/order_item.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'details_order_screen.dart';

class OrdersViewScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersViewScreen> {
  var ordercontroller = Get.put(OrderController())..getOrders();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Get.isDarkMode? AppColors.darkColor:AppColors.mainColor,
          title: Text("Requests".tr,style: TextStyle(color: AppColors.White),),
        ),
        body: Obx(
          () =>
          ordercontroller.isLoading.value ? Center(child: CircularProgressIndicator()):
              ListView.builder(
              itemCount: ordercontroller.userOrdersList.value.length,
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsOrderScreen(
                              isDriver: false,
                              order: ordercontroller.userOrdersList.value[index], orderController: ordercontroller,
                            ))).then((value) {
                      if (value == true) {
                        setState(() {});
                      }
                    });
                  },
                  child: OrderItemWidget(
                    order: ordercontroller.userOrdersList.value[index],
                    funDeleteFromList: () {},
                    orderController: ordercontroller,
                  ),
                );
              }),
        ));
  }
}