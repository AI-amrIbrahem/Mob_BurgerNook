import 'package:burgernook/new_code/features/orders/data/models/order_model.dart';
import 'package:burgernook/new_code/features/orders/presentation/controllers/order_controller.dart';
import 'package:burgernook/new_code/features/orders/presentation/views/track_order_screen.dart';
import 'package:burgernook/new_code/features/orders/presentation/views/widgets/bill_order_details.dart';
import 'package:burgernook/new_code/features/orders/presentation/views/widgets/products_order_details.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Auth/presentation/controllers/login_controller.dart';

class DetailsOrderScreen extends StatefulWidget {
  OrderModel order;
  bool isDriver;

  final OrderController orderController;

  DetailsOrderScreen(
      {required this.order,
      required this.isDriver,
      required this.orderController});

  @override
  _DetailsOrderState createState() => _DetailsOrderState();
}

class _DetailsOrderState extends State<DetailsOrderScreen> {
  // final GlobalKey<State<StatefulWidget>> shareWidget = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.orderController.getProductOfOrder(orderId: widget.order.id);
    // getDetails();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode? AppColors.darkColor:AppColors.mainColor,
        title: Text("Order details".tr),
        actions: <Widget>[
          isUser && widget.order.status == "6"
              ? TextButton.icon(
                  icon: Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  label: Text(
                    "Cancelling order".tr,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () async {
                    // progress(context: context, isLoading: true);
                    // bool result =
                    // await widget.order.updateOrderStatus(statusID: "12");
                    // progress(context: context, isLoading: false);
                    // if (result) {
                    //   Navigator.pop(context, true);
                    // }
                    widget.orderController.updateOrderStatus(
                        context: context,
                        statusID: "12",
                        orderId: widget.order.id);
                  })
              : Container(),
          !isUser &&
                  widget.order.address!.latitude.isNotEmpty &&
                  widget.order.address!.longitude.isNotEmpty
              ? TextButton.icon(
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  label: Text(
                    "the map".tr,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    launchMaps(
                        latitude: widget.order.address!.latitude,
                        longitude: widget.order.address!.longitude);
                  })
              : Container(),
          !isUser && isDelivery
              ? ElevatedButton.icon(
                  icon: Icon(
                    Icons.directions_bike,
                    color: Get.isDarkMode? AppColors.darkColor:Colors.green,
                  ),
                  label: Text(
                    "Delivered".tr,
                    style: TextStyle(
                      color:Get.isDarkMode? AppColors.darkColor: Colors.green,
                    ),
                  ),
                  onPressed: () async {
                    widget.orderController.updateOrderStatus(
                        context: context,
                        statusID: "9",
                        orderId: widget.order.id);
                    // progress(context: context, isLoading: true);
                    // bool result =
                    // await widget.order.updateOrderStatus(statusID: "9");
                    // progress(context: context, isLoading: false);
                    // if (result) {
                    //   Navigator.pop(context, true);
                    // }
                  })
              : Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductsWidget(orderController: widget.orderController),
            SizedBox(
              height: 10.h,
            ),
            BillWidget(order: widget.order),
            SizedBox(
              height: Get.height * .2,
            ),
          ],
        ),
      ),
      floatingActionButton: ((widget.order.orderType == "توصيل" ||
                  widget.order.orderType == "Delivery") &&
              widget.order.status == '8' )
          ? FloatingActionButton.extended(
        backgroundColor: AppColors.mainColor,
              onPressed: () {
                Get.to(TrackOrderScreen(widget.order, widget.isDriver),
                    duration: Duration(milliseconds: 300),
                    transition: Transition.zoom);
              },
              label: Text('follow'.tr),
              icon: Icon(
                Icons.location_on,
                color: Colors.red,
              ),
            )
          : Container(),
    );
  }
}

launchMaps({latitude, longitude}) async {
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
//  String googleUrl = 'comgooglemaps://?center=$latitude,$longitude';
  String appleUrl = 'https://maps.apple.com/?sll=$latitude,$longitude';
  if (await canLaunch("comgooglemaps://")) {
    print('launching com googleUrl');
    await launch(googleUrl);
  } else if (await canLaunch(appleUrl)) {
    print('launching apple url');
    await launch(googleUrl);
  } else {
    throw 'Could not launch url';
  }
}