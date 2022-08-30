import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';


class TotalWidget extends StatelessWidget {
  const TotalWidget({
    Key? key,
    required this.productController,
  }) : super(key: key);

  final ProductController productController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Row(
        children: [
          Text(
            ' ${"Total".tr} ',
            textDirection: TextDirection.ltr,
            style: TextStyle(
                // color: AppColors.titleText,
                fontWeight: FontWeight.bold,
                fontSize: 25.sp,
                fontFamily: "arlrdbd"),
          ),
          Text(
            ' : ',
            textDirection: TextDirection.ltr,
            style: TextStyle(
                // color: AppColors.titleText,
                fontSize: 25.sp,
                fontFamily: "arlrdbd"),
          ),
          GetBuilder<ProductController>(
            builder:(_)=> Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.colorG,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Text(
                '${productController.orderDetails.total} SR',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    fontFamily: "arlrdbd",
                    color: AppColors.accentW,
                    fontSize: 15.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

