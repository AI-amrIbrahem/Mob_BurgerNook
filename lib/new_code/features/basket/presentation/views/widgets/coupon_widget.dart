import 'package:burgernook/new_code/features/basket/presentation/controllers/basket_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CopounWidget extends StatelessWidget {
  const CopounWidget({
    Key? key,
    required this.basketController,
  }) : super(key: key);

  final BasketController basketController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: basketController.couponController,
              decoration: InputDecoration(hintText: 'كوبون الخصم'.tr,hintStyle: TextStyle(
                  fontSize: 16.sp
              )),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          RaisedButton(
            color: Colors.green,
            textColor: Colors.white,
            onPressed: () async {
              basketController.getCouponDiscount(context: context,coupon:basketController.couponController.text);
            },
            child: Text('استرداد'.tr,style: TextStyle(
    fontSize: 16.sp
    )),
          )
        ],
      ),
    );
  }
}
