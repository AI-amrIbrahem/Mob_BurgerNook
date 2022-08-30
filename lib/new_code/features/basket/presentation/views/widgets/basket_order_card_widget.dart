import 'package:burgernook/new_code/features/basket/data/models/order_details_model.dart';
import 'package:burgernook/new_code/features/basket/presentation/controllers/basket_controller.dart';
import 'package:burgernook/new_code/features/home/data/models/addition_model.dart';
import 'package:burgernook/new_code/features/home/data/models/product_model.dart';
import 'package:burgernook/new_code/util/network/service.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class basket_order_card_widget extends StatelessWidget {
  const basket_order_card_widget({
    Key? key,
    required this.basketController,
  }) : super(key: key);

  final BasketController basketController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BasketController>(
      builder:(_)=> Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: basketController.orderDetails.isNotEmpty
                ? Column(
              children: basketController.orderDetails
                  .map((OrderDetailsModel orderDetails) {
                ProductModel? product = orderDetails.prices.product;
                if(product!=null){
                  return Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 5.h, horizontal: 15.w),
                    decoration: BoxDecoration(
                        color: AppColors.White,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.4),
                              blurRadius: 12.r)
                        ],
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.r))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(50.r)),
                                image:
                                DecorationImage(
                                    image: NetworkImage(
                                      '${ServiceUrls.domain}/image/uploads/${product.imageName}',
                                    ),
                                    fit: BoxFit.fill),
                              ),
                              width: 55.h,
                              height: 55.h,
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                '${product.nameAr}',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: AppColors.accentColor5),
                              ),

                            ),
                            subtitle: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[

                                      orderDetails.prices.size_id ==
                                          "16"
                                          ? Container()
                                          : Text(
                                        "${Get.locale!.languageCode == "en" ? orderDetails.prices.size_name == "وسط" ? "Middle" : "Large" : orderDetails.prices.size_name}",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: AppColors.colorG),
                                      ),
                                    ]),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(orderDetails.count.toString(),
                                        textDirection:
                                        TextDirection.ltr,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontFamily: "",
                                          color: AppColors.accentColor5,
                                        )),
                                    Text(' x',
                                        textDirection:
                                        TextDirection.ltr,
                                        style: TextStyle(
                                          color: AppColors.accentColor,
                                          fontSize: 14.sp,

                                        )),
                                    Text(
                                      '${orderDetails.prices.price} SR',
                                      textDirection:
                                      TextDirection.ltr,
                                      style: TextStyle(
                                          color: AppColors.accentColor5,
                                          fontSize: 14.sp,

                                          fontFamily: "arlrdbd"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: InkWell(
                              onTap: () {
                                basketController.deleteOrderDetails(orderDetails);
                              },
                              child: Image.asset(
                                "assets/close.png",
                                height: 15.h,
                              ),
                            )),
                        orderDetails.note == null ||
                            orderDetails.note.isEmpty
                            ? Container(
                          margin:
                          EdgeInsets.symmetric(vertical: 5.h),
                        )
                            : Container(
                          width:
                          MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          child: Text(
                              "${"Notes".tr} : ${orderDetails.note}", style: TextStyle(
                              color: AppColors.accentColor5,
                              fontSize: 14.sp,

                              fontFamily: "arlrdbd"),),
                        ),
                        orderDetails.prices.product==null ?
                        Container(
                          margin:
                          EdgeInsets.symmetric(vertical: 5.h),
                        ):
                        (orderDetails.prices.product!.has_drink == null ||
                            orderDetails.prices.product!.has_drink !=
                                "Yes")
                            ? Container(
                          margin:
                          EdgeInsets.symmetric(vertical: 5.h),
                        )
                            : Container(
                          width:
                          MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          child: Text(
                              "${"drink type".tr} : ${orderDetails.drink}", style: TextStyle(
                              color: AppColors.accentColor5,
                              fontSize: 14.sp,

                              fontFamily: "arlrdbd"),),
                        ),
                        orderDetails.orderAdditions == null ||
                            orderDetails.orderAdditions.isEmpty
                            ? Container(
                          margin:
                          EdgeInsets.symmetric(vertical: 5.h),
                        )
                            : Container(
                          width:
                          MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width,
                                child: Text(
                                    "${"Additions".tr}", style: TextStyle(
                                    color: AppColors.accentColor5,
                                    fontSize: 14.sp,

                                    fontFamily: "arlrdbd"),),
                              ),
                              Column(
                                children: orderDetails
                                    .orderAdditions
                                    .map((AdditionModel addition) {
                                  return ListTile(
                                    title: Text(
                                      ' ${Get.locale!.languageCode != "en" || addition.addition_data!.nameEn.isEmpty ? addition.addition_data!.nameAr : addition.addition_data!.nameEn}',
                                      style: TextStyle(
                                          fontSize: 14.sp,

                                          color: AppColors.accentColor5),
                                    ),
                                    trailing: Text(
                                      "${addition.price} SR",
                                      textDirection:
                                      TextDirection.ltr,
                                      style: TextStyle(
                                        fontFamily: "arlrdbd",
                                        color: AppColors.colorG,
                                        fontSize: 14.sp,

                                      ),
                                    ),
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                        ),
                        orderDetails.total == null ||
                            orderDetails.total.isEmpty
                            ? Container(
                          margin:
                          EdgeInsets.symmetric(vertical: 5.h),
                        )
                            : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      basketController
                                          .setOrderDetails(orderDetails1:orderDetails);
                                    },
                                    child: Container(
                                      height: 30.h,
                                      width: 30.w,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '+',
                                        style: TextStyle(
                                          color: AppColors.accentColor5,
                                          fontSize: 25.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 40.w,
                                    height: 25.h,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 3.w),
                                    padding: EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.accentColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.r)),
                                      // shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      '${orderDetails.count}',
                                      style: TextStyle(
                                        fontFamily: "arlrdbd",
                                        fontSize: 14.sp,

                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: orderDetails.count == 1
                                        ? null
                                        : () {
                                      basketController.incrementOrderDetails(
                                          orderDetails);
                                    },
                                    child: Container(
                                      height: 30.h,
                                      width: 30.w,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '-',
                                        style: TextStyle(
                                          fontSize: 25.sp,
                                          color: AppColors.accentColor5,

                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 5.h),
                                child: Text(
                                  "${"Total".tr} : ${double.parse(orderDetails.total) * orderDetails.count}",
                                  style: TextStyle(
                                      fontFamily: "",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,

                                      color: AppColors.titleText),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              }).toList(),
            )
                : Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200.h,
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/basket3.png",
                        ),
                      ),
                      Positioned(
                        bottom: 100.h,
                        right: 0,
                        left: 50.w,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle),
                          child: Text(
                            'فارغ'.tr,
                            style: TextStyle(
                                color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
