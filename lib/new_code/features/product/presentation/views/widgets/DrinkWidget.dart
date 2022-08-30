import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';


class DrinkWidget extends StatelessWidget {
  const DrinkWidget({
    Key? key,
    required this.productController,
  }) : super(key: key);

  final ProductController productController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              "Choose a drink type"
                  .tr, // 'اختر نوع المشروب',
              style: TextStyle(
                  // color: AppColors.titleText,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp),
            ),
          ),
          GetBuilder<ProductController>(
            builder:(_)=> Container(
              margin: EdgeInsets.symmetric(horizontal: 14.w),
              padding:
              EdgeInsets.symmetric(horizontal: 8.0.w),
              child: DropdownButton<String>(
                isExpanded: true,
                value: productController.orderDetails.drink,
                items: <String>[
                  "Pepsi",
                  "7-UP",
                  //     "water",
                  "Miranda",
                  "mountain dew",
                  "Diet Pepsi",
                  //    "ice Tea",
                  //    "cocktail juice",
                  //    "Apple juice",
                  //    "Orange juice",
                ].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(
                      value,
                      style: TextStyle(fontSize: 15.sp),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  productController.changeJuice(value);

                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
