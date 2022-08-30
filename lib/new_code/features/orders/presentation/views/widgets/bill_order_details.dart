import 'package:burgernook/new_code/features/orders/data/models/order_model.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class BillWidget extends StatelessWidget {
  const BillWidget({
    Key? key,
    required this.order,
  }) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(
          vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
          color: AppColors.White,
          boxShadow: [
            BoxShadow(
                color: Colors.black
                    .withOpacity(.2),
                blurRadius: 12)
          ],
          borderRadius: BorderRadius.all(
              Radius.circular(10))),
      child: Column(
        children: <Widget>[
          ListTile(
              title: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Total".tr,style: TextStyle(color: AppColors.titleText)),
                      Text(
                        '${order.p_total} SR',
                        textDirection: TextDirection.ltr,

                        style: TextStyle(
                          fontFamily: "arlrdbd",color: AppColors.titleText

                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Divider(
                      height: 2,
                      color: AppColors.accentColor5.withOpacity(.4),
                    ),
                  ),
                  order.p_delivery.isNotEmpty
                      ? Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Delivery".tr,style: TextStyle(color: AppColors.titleText)),
                      Text(
                        '${order.p_delivery} SR',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontFamily: "arlrdbd",color: AppColors.titleText
                        ),
                      ),
                    ],
                  )
                      : Container(),
                  order.p_delivery.isNotEmpty
                      ? Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 5),
                    child: Divider(
                      height: 2,
                      color:
                      AppColors.accentColor5.withOpacity(.4),
                    ),
                  )
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${"VAT".tr} ${order.tax} %',
                        style: TextStyle(
                          fontFamily: "",color: AppColors.titleText
                        ),
                      ),
                      Text(
                        '${order.p_tax}',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontFamily: "arlrdbd",color: AppColors.titleText
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Divider(
                      height: 2,
                      color: AppColors.accentColor5.withOpacity(.4),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Total bill".tr,style: TextStyle(color: AppColors.titleText)),
                      Text(
                        '${order.p_invoice} SR',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontFamily: "arlrdbd",color: AppColors.titleText
                        ),
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 5),
                  //   child: Divider(
                  //     height: 2,
                  //     color: AppColors.accentColor5.withOpacity(.4),
                  //   ),
                  // ),
                ],
              )),
        ],
      ),
    );
  }
}
