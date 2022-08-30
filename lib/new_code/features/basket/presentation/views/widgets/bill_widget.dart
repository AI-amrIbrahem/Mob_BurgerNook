import 'package:burgernook/new_code/features/basket/presentation/controllers/basket_controller.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class BillWdget extends StatelessWidget {
 const  BillWdget({
    Key? key,
    required this.basketController,
  }) : super(key: key);

  final BasketController basketController;

  @override
  Widget build(BuildContext context) {
    if(basketController.isGetLockups==false){
      basketController.getLockups();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<BasketController>(
        builder: (_) =>basketController.isGetLockups? Column(
          children: <Widget>[
            ListTile(
                title: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total'.tr,
                          style: TextStyle(
                              fontFamily: "arlrdbd",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${basketController.total} SR',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontFamily: "arlrdbd",
                            fontSize: 14.sp
                          ),
                        ),
                      ],
                    ),
                    (basketController.discountValue == null)
                        ? Container()
                        : Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('قيمة الخصم',
                              style: TextStyle(
                                  fontFamily: "arlrdbd",
                                  fontSize: 14.sp

                              ),),
                            Text(
                              '${basketController.discountValue} %',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontFamily: "arlrdbd",
                                  fontSize: 14.sp

                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('المجموع بعد الخصم',
                              style: TextStyle(
                                  fontFamily: "arlrdbd",
                                  fontSize: 14.sp

                              ),),
                            Text(
                              '${basketController.total_after_discount} SR',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontFamily: "arlrdbd",
                                  fontSize: 14.sp

                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 5.h),
                      child: Divider(
                        height: 2.h,
                        color: AppColors.accentColor5.withOpacity(.4),
                      ),
                    ),
                    basketController.isDelivery
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Delivery'.tr,
                            style: TextStyle(
                                fontFamily: "arlrdbd",
                                fontSize: 14.sp

                            ),

                        ),
                        Text(
                          '${basketController.delivery} SR',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontFamily: "arlrdbd",
                              fontSize: 14.sp

                          ),
                        ),
                      ],
                    )
                        : Container(),
                    basketController.isDelivery
                        ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Divider(
                        height: 2.h,
                        color: AppColors.accentColor5.withOpacity(.4),
                      ),
                    )
                        : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${'VAT'.tr} ${basketController.tax} %',
                          style: TextStyle(
                              fontFamily: "arlrdbd",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${basketController.priceTax}',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontFamily: "arlrdbd",
                              fontSize: 14.sp

                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Divider(
                        height: 2.h,
                        color: AppColors.accentColor5.withOpacity(.4),
                      ),
                    ),
                    /* basket.getIsDelivery()
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('الاجمالي بالضريبة'),
                          Text(
                            '${totalWithTax} SR',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              fontFamily: "arlrdbd",
                            ),
                          ),
                        ],
                      )
                    : Container(),
                basket.getIsDelivery()
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Divider(
                          height: 2,
                          color: accentColor5.withOpacity(.4),
                        ),
                      )
                    : Container(),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total bill'.tr,
                          style: TextStyle(
                              fontFamily: "arlrdbd",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        // another total
                        Text(
                          '${basketController.totalBill} SR',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontFamily: "arlrdbd",
                              fontSize: 14.sp

                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Divider(
                        height: 2.h,
                        color: AppColors.accentColor5.withOpacity(.4),
                      ),
                    ),
                  ],
                )),
          ],
        ):
        CircularProgressIndicator(),
      ),
    );
  }
}
