import 'package:burgernook/new_code/features/orders/data/models/order_model.dart';
import 'package:burgernook/new_code/features/orders/presentation/controllers/order_controller.dart';
import 'package:burgernook/new_code/util/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../Auth/presentation/controllers/login_controller.dart';

class OrderItemWidget extends StatefulWidget {
  OrderModel order;

  Function funDeleteFromList = () {};

  final OrderController orderController ;
  OrderItemWidget({required this.orderController,required this.order, required this.funDeleteFromList});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItemWidget> {
  final GlobalKey<State<StatefulWidget>> shareWidget = GlobalKey();
  bool showDelivery = false;

  @override
  Widget build(BuildContext context) {
    // AppLocalizations appLocalizations = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
      child: Card(
        elevation: 10,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.h,
            ),
            ListTile(
              trailing: Text(
                getStatus(),
                style: TextStyle(
                    color: widget.order.status == '6'
                        ? Colors.green
                        : widget.order.status == '7'
                            ? Colors.green
                            : widget.order.status == '8'
                                ? Colors.green
                                : widget.order.status == '9'
                                    ? Colors.green
                                    : widget.order.status == '23'
                                        ? Colors.green
                                        : Colors.red),
              ),

              title: isUser
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${"Code".tr} : ${widget.order.id}',
                          style: TextStyle(fontFamily: 'arlrdbd'),
                        ),
                        Text('${"order type".tr} : ${widget.order.orderType}'),
                        Text(
                            '${"payment type".tr} : ${widget.order.paymentType}'),
                        Text(
                          '${"order date".tr} : ${widget.order.date}',
                          style: TextStyle(fontFamily: 'arlrdbd'),
                        ),
                        widget.order.assignedUser!.fullName.isNotEmpty
                            ? Text(
                                '${"Delivery".tr} : ${widget.order.assignedUser!.fullName}')
                            : Container(),
                        widget.order.assignedUser!.phoneNumber.isNotEmpty
                            ? Text(
                                '${"delivery phone".tr} : ${widget.order.assignedUser!.phoneNumber}',
                                style: TextStyle(fontFamily: ''),
                              )
                            : Container(),
                        Text(
                          '${"clock".tr} : ${widget.order.time}',
                          style: TextStyle(fontFamily: 'arlrdbd'),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            '${"customer name".tr} : ${widget.order.user!.fullName}'),
                        Text('${"email".tr} : ${widget.order.user!.email}'),
                        Text(
                          '${"Phone Number".tr} : ${widget.order.user!.phoneNumber}',
                          style: TextStyle(fontFamily: ''),
                        ),
                        Text(
                            '${"Address details".tr} : ${widget.order.address!.addressInMap} '),
                        !isDelivery && widget.order.assignedId != "0"
                            ? Text(
                                '${"Delivery".tr} : ${widget.order.assignedUser!.fullName}')
                            : Container(),
                      ],
                    ),
              // title: Text('تاريخ الطلب : ${order.date}'),
              subtitle: Text(
                '${"Total bill".tr} : ${widget.order.p_invoice} SR ',
                style: TextStyle(fontFamily: 'arlrdbd'),
              ),
            ),
            !isUser && !isDelivery
                ? Column(
                    children: <Widget>[
                      showDelivery ? allDeliveriesDropdown() : Container(),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: MaterialButton(
                              color: Colors.deepOrangeAccent,
                              onPressed: widget.order.assignedId != "0" ||
                                      widget.order.status == '7' ||
                                      widget.order.status == '8'
                                  ? null
                                  : () {
                                      setState(() {
                                        showDelivery = !showDelivery;
                                      });
                                    },
                              textColor: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.directions_bike),
                                  Text(
                                    'اضافة الي دلفري',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: MaterialButton(
                              key: shareWidget,
                              color: Colors.deepOrangeAccent,
                              onPressed: () {
                                //_printPdf();
                              },
                              textColor: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.print),
                                  Text('طباعة',
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                        ],
                      ),
                      MaterialButton(
                        color: Colors.deepOrangeAccent,
                        onPressed: widget.order.assignedId != "0" &&
                                (widget.order.status == '6' ||
                                    widget.order.status == '7')
                            ? () async {
                                var statusID = '';
                                switch (widget.order.status) {
                                  case '6':
                                    statusID = '7';
                                    break;
                                  case '7':
                                    statusID = '8';
                                    break;
                                }

                                showLoadingDialog(context);
                                bool reuslt = await widget.orderController
                                    .updateOrderStatus(statusID: statusID,orderId: widget.order.id,context: context);
                                dismissLoadingDialog(context);

                                if (reuslt) {
                                  widget.funDeleteFromList();
                                }
                              }
                            : null,
                        textColor: Colors.white,
                        child: Row(
                          children: [
                            Icon(Icons.done_all),
                            Expanded(
                              child: Text(
                                  widget.order.status == '6'
                                      ? "pending".tr //'قيد الانتظار'
                                      : widget.order.status == '7'
                                          ? "processing".tr // 'جارى التنفيذ'
                                          : widget.order.status == '8'
                                              ? "Connecting"
                                                  .tr // 'جارى التوصيل'
                                              : widget.order.status == '9'
                                                  ? "Delivered"
                                                      .tr //"تم التوصيل"
                                                  : "Cancellation".tr,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : Container(),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }

  String getStatus() {
    return widget.order.status == '6'
        ? "pending".tr //'قيد الانتظار'
        : widget.order.status == '7'
            ? "processing".tr // 'جارى التنفيذ'
            : widget.order.status == '8'
                ? "Connecting".tr // 'جارى التوصيل'
                : widget.order.status == '9'
                    ? "Delivered".tr //"تم التوصيل"
                    : widget.order.status == '23'
                        ? "Delivered".tr
                        : "Cancellation".tr; //'الغاء';
  }

  Widget allDeliveriesDropdown() {
    // if (deliveries.isNotEmpty) {
    //   return Row(
    //     children: <Widget>[
    //       Expanded(
    //         child: Container(
    //           margin: EdgeInsets.symmetric(horizontal: 20),
    //           child: DropdownButton<User>(
    //             isExpanded: true,
    //             items: deliveries.map((User value) {
    //               return DropdownMenuItem<User>(
    //                 value: value,
    //                 child: Text(value.fullName),
    //               );
    //             }).toList(),
    //             value: delivery,
    //             onChanged: (value) {
    //               delivery = value!;
    //               setState(() {});
    //             },
    //           ),
    //         ),
    //       ),
    //       IconButton(
    //         icon: Icon(Icons.done, color: Colors.blue),
    //         onPressed: () async {
    //           // if (showDelivery) {
    //           //   progress(context: context, isLoading: true);
    //           //   bool reuslt =
    //           //   await widget.order.assignedOrderToDelivery(user: delivery);
    //           //   progress(context: context, isLoading: false);
    //           //   if (reuslt) {
    //           //     showDelivery = false;
    //           //     widget.order.assignedUser!.fullName = delivery.fullName;
    //           //     widget.order.assignedId = delivery.id;
    //           //     setState(() {});
    //           //   }
    //           // }
    //         },
    //       ),
    //     ],
    //   );
    // }
    return Container();
  }
}
