import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';


class CommentWidget extends StatelessWidget {
  const CommentWidget({
    Key? key,
    required this.productController,
  }) : super(key: key);

  final ProductController productController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15.w,
      ),
      child: TextField(
        maxLines: 20,
        maxLength: 900,
        minLines: 4,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelStyle: TextStyle(
            fontFamily: "arlrdbd",
            fontSize: 16.sp),
          errorText: productController.errorNote ? productController.errorN : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          prefixIcon: Icon(Icons.details),
          labelText:
          "Add more details".tr, //'اضف المذيد من التفاصيل',
        ),
        onChanged: (input) {
          //   widget.product.price.note = input;
          productController.orderDetails.note = input;
        },
        onSubmitted: (input) {},
      ),
    );
  }
}
