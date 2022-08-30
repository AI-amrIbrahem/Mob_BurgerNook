import 'package:burgernook/new_code/features/basket/presentation/controllers/basket_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class order_type extends StatelessWidget {
  const order_type({
    Key? key,
    required this.basketController,
  }) : super(key: key);

  final BasketController basketController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 14.w),
          //  padding: EdgeInsets.all(8.0),
          child: Text(
            'Choose the order type'.tr,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.sp
            ),
          ),
        ),
        Obx(()=> Container(
          margin: EdgeInsets.symmetric(horizontal: 14.w),
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: DropdownButton<String>(
            isExpanded: true,
            value: basketController.orderType.value,
            items: Get.locale!.languageCode == "en"
                ? <String>['Delivery', 'My travel', 'Sweetened']
                .map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList()
                : <String>['توصيل', 'سفري', 'محلي'].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child:  Text(value,style: TextStyle(
                  fontSize: 16.sp
                ),),
              );
            }).toList(),
            onChanged: (value) {
              if (value == "توصيل" || value == "Delivery") {
                basketController.setIsDelivery(true);
              } else {
                basketController.setIsDelivery(false);
              }
              basketController.orderType.value = value!;
              //order.orderType = value;
              // setState(() {});
            },
          ),
        ),
        ),
      ],
    );
  }
}
