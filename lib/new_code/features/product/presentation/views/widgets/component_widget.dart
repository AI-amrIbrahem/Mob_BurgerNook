import 'package:burgernook/new_code/features/home/data/models/product_model.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            child: Text(
              "the ingredients".tr,
              //   'المكونات',
              style: TextStyle(
                  // color: AppColors.titleText,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp),
            ),
          ),
          Container(
            child: Text(
              //    '${widget.product.prduct_components}',
              "${Get.locale!.languageCode != "en" || product.prduct_componentsEn.isEmpty ? product.prduct_components : product.prduct_componentsEn}",
              style: TextStyle(
                  color: AppColors.subText,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
