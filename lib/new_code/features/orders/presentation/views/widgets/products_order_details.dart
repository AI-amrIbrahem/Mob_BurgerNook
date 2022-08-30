import 'package:burgernook/new_code/features/home/data/models/addition_model.dart';
import 'package:burgernook/new_code/features/home/data/models/product_model.dart';
import 'package:burgernook/new_code/features/orders/presentation/controllers/order_controller.dart';
import 'package:burgernook/new_code/util/network/service.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class ProductsWidget extends StatelessWidget {
  const ProductsWidget({
    Key? key,
    required this.orderController,
  }) : super(key: key);

  final OrderController orderController;

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: orderController.isProductsLoading.value
            ? Container(
            height: 200,
            child: LinearProgressIndicator(
              color: AppColors.mainColor,
            ))
            : Container(
            child: orderController.products.isNotEmpty
                ? Column(
              children: orderController.products
                  .map((ProductModel product) {
                return Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 5.w, horizontal: 15.h),
                  decoration: BoxDecoration(
                      color: AppColors.White,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black
                                .withOpacity(.2),
                            blurRadius: 12.r)
                      ],
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.r))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(
                                Radius.circular(50.r)),
                            image: DecorationImage(
                                image: NetworkImage(
                                  '${ServiceUrls.domain}/image/uploads/${product.imageName}',
                                ),
                                fit: BoxFit.fill),
                          ),
                          width: 55.w,
                        ),
                        title: Padding(
                          padding:  EdgeInsets.only(
                              right: 8.w),
                          child: Column(
                            mainAxisSize:
                            MainAxisSize.min,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  mainAxisSize:
                                  MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      '${product.nameAr}',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: AppColors
                                              .accentColor5),
                                    ),
                                    Container(
                                      alignment: Alignment
                                          .center,
                                      child: product
                                          .size ==
                                          "حجم ثابت"
                                          ? Text(
                                        '${product.count}',
                                        style: TextStyle(
                                            fontFamily:
                                            "",
                                            fontSize:
                                            20.sp,
                                            color: AppColors
                                                .colorG),
                                      )
                                          : Text(
                                        '${product.count} ${Get.locale!.languageCode == "en" ? product.size == "وسط" ? "Middle" : "Large" : product.size}',
                                        style: TextStyle(
                                            fontFamily:
                                            "",
                                            fontSize:
                                            20.sp,
                                            color: AppColors
                                                .colorG),
                                      ),
                                    ),
                                  ]),
                              Row(
                                mainAxisSize:
                                MainAxisSize.min,
                                children: <Widget>[
                                  Text('1',
                                      textDirection:
                                      TextDirection
                                          .ltr,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColors
                                            .accentColor5,
                                      )),
                                  Text(' x',
                                      textDirection:
                                      TextDirection
                                          .ltr,
                                      style: TextStyle(
                                        color: AppColors
                                            .accentColor,
                                      )),
                                  Text(
                                    '${product.price!.price} SR',
                                    textDirection:
                                    TextDirection.ltr,
                                    style: TextStyle(
                                        color: AppColors
                                            .accentColor5,
                                        fontFamily:
                                        "arlrdbd"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        subtitle: Container(
                          height: 10.h,
                        ),
                      ),
                      product.note == null ||
                          product.note.isEmpty
                          ? Container()
                          : Container(
                        width:
                        MediaQuery.of(context)
                            .size
                            .width,
                        margin:
                        EdgeInsets.symmetric(
                            horizontal: 10.h,
                            vertical: 5.w),
                        child: Text(
                            "${"Notes".tr} : ${product.note}",style: TextStyle(color: AppColors.titleText),),
                      ),
                      product.drink == null ||
                          product.drink.isEmpty
                          ? Container()
                          : Container(
                        width:
                        MediaQuery.of(context)
                            .size
                            .width,
                        margin:
                        EdgeInsets.symmetric(
                            horizontal: 10.h,
                            vertical: 5.w),
                        child: Text(
                            "${"drink type".tr} : ${product.drink}",style: TextStyle(color: AppColors.titleText)),
                      ),
                      product.orderAdditions == null ||
                          product
                              .orderAdditions.isEmpty
                          ? Container(
                        margin:
                        EdgeInsets.symmetric(
                            vertical: 5.w),
                      )
                          : Container(
                        width:
                        MediaQuery.of(context)
                            .size
                            .width,
                        margin:
                        EdgeInsets.symmetric(
                            horizontal: 10.h,
                            vertical: 5.w),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(
                                  context)
                                  .size
                                  .width,
                              child: Text(
                                  "${"Additions".tr}",style: TextStyle(color: AppColors.titleText)),
                            ),
                            Column(
                              children: product
                                  .orderAdditions
                                  .map((AdditionModel
                              addition) {
                                return ListTile(
                                  /* leading: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          '$domain/image/uploads/${addition.addition_data.imageName}',
                                        ),
                                        fit: BoxFit.fill),
                                  ),
                                  width: 55,
                                ),*/
                                  title: Text(
                                    ' ${Get.locale!.languageCode != "en" || addition.addition_data!.nameAr.isEmpty ? addition.addition_data!.nameAr : addition.addition_data!.nameEn}',
                                    style: TextStyle(
                                        color: AppColors
                                            .accentColor5),
                                  ),
                                  trailing: Text(
                                    "${addition.price} SR",
                                    textDirection:
                                    TextDirection
                                        .ltr,
                                    style:
                                    TextStyle(
                                      fontFamily:
                                      "arlrdbd",
                                      color: AppColors
                                          .colorG,
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            )
                : Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200.h,
                  margin: EdgeInsets.symmetric(
                      horizontal: 15.h),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/basket3.png",
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
