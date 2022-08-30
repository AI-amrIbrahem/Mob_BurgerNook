import 'package:burgernook/new_code/features/basket/presentation/controllers/basket_controller.dart';
import 'package:burgernook/new_code/features/basket/presentation/views/widgets/address_widget.dart';
import 'package:burgernook/new_code/features/basket/presentation/views/widgets/basket_order_card_widget.dart';
import 'package:burgernook/new_code/features/basket/presentation/views/widgets/bill_widget.dart';
import 'package:burgernook/new_code/features/basket/presentation/views/widgets/coupon_widget.dart';
import 'package:burgernook/new_code/features/basket/presentation/views/widgets/order_get_type.dart';
import 'package:burgernook/new_code/features/basket/presentation/views/widgets/payment_type_widget.dart';
import 'package:burgernook/new_code/features/orders/data/models/order_model.dart';
import 'package:burgernook/new_code/features/orders/presentation/controllers/order_controller.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../util/widgets/snackbar_widget.dart';
import '../../../Auth/presentation/controllers/login_controller.dart';
import '../../../Auth/presentation/views/login_screen.dart';
import '../../../address/presentation/controllers/address_controller.dart';

class BasketMainScreen extends StatefulWidget {
  @override
  _BasketMainScreenState createState() => _BasketMainScreenState();
}

class _BasketMainScreenState extends State<BasketMainScreen> {
  var basketController = Get.find<BasketController>()..isResturantWork();
  var addressController = Get.put(AddressController())
    ..getAddress(userId: userModelGlobal.id);
  var orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    print('basketController.tax ${basketController.tax}');
    basketController.updateData();
    if(addressController.isLoading){
      addressController.getAddress(userId: userModelGlobal.id);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode? AppColors.darkColor:AppColors.mainColor,
        title: Text(
          "The basket".tr,
          style: TextStyle(color: AppColors.White),
        ),
      ),
      body: ListView(
        children: <Widget>[
          basket_order_card_widget(basketController: basketController),
          SizedBox(
            height: 30.h,
          ),
          order_type(basketController: basketController),
          SizedBox(
            height: 30.h,
          ),
          PaymentType(basketController: basketController),
          SizedBox(
            height: 30.h,
          ),
          CopounWidget(basketController: basketController),
          SizedBox(
            height: 40.h,
          ),
          Address_widget(
            addressController: addressController,
            basketController: basketController,
          ),
          SizedBox(
            height: 20.h,
          ),
          BillWdget(basketController: basketController),
          SizedBox(
            height: 30.h,
          ),



          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: () {
                if (isLogin) {
                if (basketController.orderDetails.isEmpty) {
                  failSnackBar('برجاء اختيار منتجات اولا',
                      'برجاء التواصل مع خدمة العملاء');
                } else if (addressController.selectDropAddress.value.id.isEmpty) {
                  failSnackBar("Please choose an address".tr,
                      'برجاء التواصل مع خدمة العملاء');
                } else if (basketController.isGetLockups == false) {
                  failSnackBar("برجاء الانتظار حتي تظهر الفاتورة".tr,
                      'برجاء التواصل مع خدمة العملاء');
                } else {

                    if (isUser) {
                      //      print('>>>>>>>>>>>>>>>>>>>>>>>>>isUser');
                      if (basketController.isWork == false) {
                        failSnackBar(
                            'المطعم غير متاح الأن', 'المطعم غير متاح الأن');
                      } else {
                        print('''
                        orderDetailsList: ${basketController.orderDetails},
                          addressId: ${addressController.selectDropAddress.value.id},
                          p_total: ${basketController.total.toString()},
                          p_tax: ${basketController.priceTax.toString()},
                          tax: ${basketController.tax.toString()},
                          p_total_w_tax: ${basketController.totalBill.toString()},
                          p_delivery: ${basketController.isDelivery ? basketController.delivery : ""},
                          p_invoice: ${basketController.total.toString()},
                          orderType: ${basketController.orderType.toString()},
                          paymentType: ${basketController.paymentType.toString()},
                          coupon: ${(basketController.couponController.text.isEmpty) ? "لايوجد" : basketController.couponController.text},
                        ''');
                        orderController.makeOrder(
                            orderModel: OrderModel(
                              orderDetailsList: basketController.orderDetails,
                              addressId:
                                  addressController.selectDropAddress.value.id,
                              p_total: basketController.total.toString(),
                              p_tax: basketController.priceTax.toString(),
                              tax: basketController.tax.toString(),
                              p_total_w_tax:
                                  basketController.totalBill.toString(),
                              p_delivery: basketController.isDelivery
                                  ? basketController.delivery
                                  : "",
                              p_invoice: basketController.totalBill.toString(),
                              orderType: basketController.orderType.toString(),
                              paymentType:
                                  basketController.paymentType.toString(),
                              coupon:
                                  (basketController.couponController.text.isEmpty)
                                      ? "لايوجد"
                                      : basketController.couponController.text,
                            ),
                            context: context);
                      }
                    }
                  }
                }else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginViewScreen()));
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    // color: AppColors.accentColor,
                    borderRadius: BorderRadius.all(Radius.circular(25.r))),
                child: Text(
                  'Request'.tr,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp),
                ),
              ),
              color:Get.isDarkMode? AppColors.mainColor: AppColors.accentColor,
            ),
          ),
          // SizedBox(height: 10.h,),
        ],
      ),
    );
  }
}