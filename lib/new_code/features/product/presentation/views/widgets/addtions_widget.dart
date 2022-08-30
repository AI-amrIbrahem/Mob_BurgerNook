import 'package:burgernook/new_code/features/home/data/models/addition_model.dart';
import 'package:burgernook/new_code/features/home/data/models/product_model.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';
class AdditionsWidget extends StatelessWidget {
  const AdditionsWidget({
    Key? key,
    required this.productController, required ProductModel this.product,
  }) : super(key: key);

  final ProductModel product;
  final ProductController productController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        product.additions!.isNotEmpty
            ? Container(
          margin: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
            "Additions".tr,
            //     'الاضافات',
            style: TextStyle(
                // color: AppColors.titleText,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp),
          ),
        )
            : Container(),
        GetBuilder<ProductController>(
          builder:(_)=> Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (product.additions != null)
                  ? product.additions!
                  .map((AdditionModel addition) {
                if (addition != null) {
                  if (addition.addition_data!.nameAr
                      .isNotEmpty &&
                      addition.addition_data!.nameEn
                          .isNotEmpty) {
                    productController.counter++;
                    return CheckboxListTile(
                      value: addition.isActive,
                      onChanged: (value) {
                        productController.changeAdditions(value,addition);
                      },
                      secondary: Text(
                        ' ${Get.locale!.languageCode != "en" || addition.addition_data!.nameEn.isEmpty ? addition.addition_data!.nameAr : addition.addition_data!.nameEn}',
                        style: TextStyle(
                            color:Get.isDarkMode? AppColors.accentW: AppColors.accentColor5,
                            fontSize: 13.sp,

                        ),
                      ),
                      title: Text(
                        "${addition.price} SR",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontFamily: "arlrdbd",
                          fontSize: 13.sp,
                          color: AppColors.accentColor,
                        ),
                      ),
                    );
                  }
                }
                return Container();
              }).toList()
                  : []),
        ),
      ],
    );
  }
}

