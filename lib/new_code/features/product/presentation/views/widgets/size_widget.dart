import 'package:burgernook/new_code/features/home/data/models/product_model.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';


class SizeWidget extends StatelessWidget {
  const SizeWidget({
    Key? key,
    required this.product,
    required this.productController,
  }) : super(key: key);

  final ProductModel product;
  final ProductController productController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // color: AppColors.White,
      alignment: Alignment.center,
      child: product.prices == null
          ? Container()
          : Column(
        children: <Widget>[
          product.prices!.isEmpty
              ? Container()
              : Container(
            width: MediaQuery.of(context)
                .size
                .width,
            padding:
            const EdgeInsets.all(8.0),
            child: Text(
              "Choose the size".tr,
              //     'اختر الحجم',
              style: TextStyle(
                  // color: AppColors.accentColor5,
                  fontSize: 15.sp,
                  fontWeight:
                  FontWeight.bold),
            ),
          ),
          GetBuilder<ProductController>(
            builder:(_)=> Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics:
                NeverScrollableScrollPhysics(),
                itemCount:
                product.prices!.length,
                itemBuilder: (context, index) {
                  return RadioListTile(
                    value: index,
                    groupValue: productController.value,
                    onChanged: (index) =>
                        productController.changeSize(index),
                    title: Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                      children: <Widget>[
                        Text(
                            "${Get.locale!.languageCode == "en" ? product.prices![index].size_name == "وسط" ? "Middle" : "Large" : product.prices![index].size_name}",style: TextStyle(
                            fontFamily: "arlrdbd",
                            fontSize: 13.sp),),
                        Text(
                          "${product.prices![index].price} SR",
                          textDirection:
                          TextDirection.ltr,
                          style: TextStyle(
                              fontFamily: "arlrdbd",
                              fontSize: 13.sp),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
