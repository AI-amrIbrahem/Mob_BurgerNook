import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../util/resources/ColorsUtils.dart';
import '../../../../basket/presentation/controllers/basket_controller.dart';
import '../../controllers/product_controller.dart';

class ButtonProduct extends StatelessWidget {
  const ButtonProduct({
    Key? key,
    required this.productController,
    required this.basket,
  }) : super(key: key);

  final ProductController productController;
  final BasketController basket;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 130.w,
        child: InkWell(
          onTap: () {
            productController.addProduct();
            basket.setOrderDetails(orderDetails1: productController.orderDetails);
            Get.back();
          },
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                    margin: EdgeInsets.only(bottom: 20.h, top: 20.h),
                    width: 130.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "addition".tr, // 'إضافة',
                        style: TextStyle(
                            fontSize: 24.sp, color: AppColors.accentColor5),
                      ),
                    )),
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Image.asset(
                  "assets/basket1.png",
                  color:Get.isDarkMode? AppColors.lightColor :null,

                  height: 30.h,
                  width: 30.w,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
