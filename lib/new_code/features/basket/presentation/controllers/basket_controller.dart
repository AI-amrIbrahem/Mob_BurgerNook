import 'dart:async';

import 'package:burgernook/new_code/features/basket/data/data_source/basket_data_sources.dart';
import 'package:burgernook/new_code/features/basket/data/models/order_details_model.dart';
import 'package:burgernook/new_code/features/basket/data/repo/basket_repo_imp.dart';
import 'package:burgernook/new_code/features/basket/domain/use_case/get_lockups.dart';
import 'package:burgernook/new_code/features/basket/domain/use_case/get_times_res.dart';
import 'package:burgernook/new_code/features/home/data/models/addition_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../util/errors/failures.dart';
import '../../../../util/network/network_info.dart';
import '../../../../util/resources/ColorsUtils.dart';
import '../../../../util/widgets/snackbar_widget.dart';
import '../../../Auth/presentation/controllers/login_controller.dart';
import '../../../Auth/presentation/views/login_screen.dart';
import '../../../address/data/models/address_model.dart';
import '../../data/models/time_work_model.dart';
import '../../domain/use_case/get_coupon_use_case.dart';

class BasketController extends GetxController {
  List<OrderDetailsModel> orderDetails = [];
  double widthBasket = 0;
  Color colorBasket = Colors.orange;
  double total = 0.00;

  // cash or delivery
  var orderType =
      Get.locale!.languageCode == "en" ? 'Delivery'.obs : 'توصيل'.obs;

  // change type from delivery or not
  bool isDelivery = true;

  setIsDelivery(bool isDelivery1) {
    isDelivery = isDelivery1;
    update();
  }

  // payment type
  var paymentType = Get.locale!.languageCode == "en" ? 'Cash'.obs : 'كاش'.obs;

  // change payment type
  setPaymentType(String paymentType1) {
    paymentType.value = paymentType1;
  }

  // address
  int value = 1000000;

  // coupon
  var couponController = TextEditingController();
  int? discountValue;
  double total_after_discount = 0;

  void getCouponDiscount(
      {required String coupon, required BuildContext context}) {
    showLoadingDialog(context);
    GetCouponUseCase(
            basketRepoImp: BasketRepoImp(
                basketDataSource: BasketDataSource(),
                networkInfo: NetworkInfoImp(
                    connectionChecker: InternetConnectionChecker())))
        .call(coupon: coupon)
        .then((value) {
      dismissLoadingDialog(context);
      value.fold((l) {
        discountValue = null;
        total_after_discount = 0;
        print('l amr $l');
        if (l is OffLineFailure) {
          failSnackBar('لا يوجد اتصال بالانترنت', 'برجاء الاتصال اولا');
        } else if (l is WrongDataFailure) {
          failSnackBar('البيانات خاظئة', 'من فضلك ادخل بيانات صحيحة');
        } else if (l is ServerFailure) {
          failSnackBar(
              'هناك مشكلة في السيرفر ', 'برجاء التواصل مع خدمة العملاء');
        }
      }, (value) async {
        discountValue = value;
        double d1 = (value / 100) * total;
        total_after_discount = total - d1;
        updateData();

        update();
      });
    });
  }

  // deliver price and tax
  var tax = "0.0";
  var delivery = "0.0";
  double priceTax = 0.0;

  var taxLockups = "0.0";
  var deliveryLockups = "0.0";
  var isGetLockups = false;
  void getLockups() {
    if(!isGetLockups)
    GetLockupsUseCase(
            basketRepoImp: BasketRepoImp(
                basketDataSource: BasketDataSource(),
                networkInfo: NetworkInfoImp(
                    connectionChecker: InternetConnectionChecker())))
        .call()
        .then((value) {
      // dismissLoadingDialog(context);
      value.fold((l) {
        print('l amr $l');
        if (l is OffLineFailure) {
          failSnackBar('لا يوجد اتصال بالانترنت', 'برجاء الاتصال اولا');
        } else if (l is WrongDataFailure) {
          failSnackBar('البيانات خاظئة', 'من فضلك ادخل بيانات صحيحة');
        } else if (l is ServerFailure) {
          failSnackBar(
              'هناك مشكلة في السيرفر ', 'برجاء التواصل مع خدمة العملاء');
        }
      }, (lockups) async {
        print('lockups lockups $lockups');
        for (var item in lockups) {
          if (item['code_name'] == "delivery_p") {
            deliveryLockups = item['name'];
          }
          if (item['code_name'] == "tax") {
            taxLockups = item['name'];
          }
        }
        isGetLockups = true;
        updateData();

        update();
      });
    });
  }

  setOrderDetails({required OrderDetailsModel orderDetails1}) {
    OrderDetailsModel? _orderDetail = contains(orderDetails1);
    if (_orderDetail != null) {
      _orderDetail.count++;
    } else {
      orderDetails.add(orderDetails1);
    }
    total += double.parse(orderDetails1.total);
    setWidthAndColorBasket(35.2.w, AppColors.accentColor);
    if (discountValue != null) {
      total_after_discount = total - ((discountValue! / 100) * total);
    }
    updateData();

    update();
  }

  setWidthAndColorBasket(double width, Color color) {
    Timer(Duration(milliseconds: 60), () {
      widthBasket = width;
      colorBasket = color;
      update();
    });
    Timer(Duration(milliseconds: 600), () {
      widthBasket = width - 18;
      colorBasket = Colors.red;
      update();
    });
  }

  OrderDetailsModel? contains(OrderDetailsModel orderDetails1) {
    for (OrderDetailsModel _orderDetails in orderDetails) {
      if (_orderDetails.prices.price_id == orderDetails1.prices.price_id &&
          _orderDetails.note == orderDetails1.note &&
          _orderDetails.drink == orderDetails1.drink) {
        if (orderDetails1.orderAdditions == null &&
            _orderDetails.orderAdditions == null) {
          return _orderDetails;
        } else {
          int flag = 0;
          for (AdditionModel addition in orderDetails1.orderAdditions) {
            flag = 1;

            for (AdditionModel _addition in _orderDetails.orderAdditions) {
              if (addition.addition_id == _addition.addition_id) {
                return _orderDetails;
              }
            }
          }
          if (flag == 0) return _orderDetails;
          return null;
        }
      }
    }
    return null;
  }

  incrementOrderDetails(OrderDetailsModel orderDetails) {
    //  OrderDetails _prices = contains(orderDetails);
    orderDetails.count--;
    total -= double.parse(orderDetails.total);
    if (discountValue != null) {
      total_after_discount = total - ((discountValue! / 100) * total);
    }
    updateData();
    update();
  }

  deleteOrderDetails(OrderDetailsModel orderDetails1) {
    total -=
        (double.parse(orderDetails1.total) * orderDetails1.count).toDouble();
    orderDetails1.count = 1;
    if (discountValue != null) {
      total_after_discount = total - ((discountValue! / 100) * total);
    }
    orderDetails.remove(orderDetails1);
    updateData();
    update();
  }

  double t5 = 0;
  String totalBill = '0.00';

  void updateData() {
    orderType =
    Get.locale!.languageCode == "en" ? 'Delivery'.obs : 'توصيل'.obs;
    paymentType = Get.locale!.languageCode == "en" ? 'Cash'.obs : 'كاش'.obs;
    print('taax $tax');
    t5 = 0;
    totalBill = '0.00';
    if (orderDetails.isNotEmpty) {
      tax = taxLockups;
      delivery = deliveryLockups;
      if (total_after_discount != 0) {
        t5 = total_after_discount;
      } else {
        t5 = total;
      }
      if (isDelivery) {
        print(' update tax $tax  && delivery $delivery');
        print(
            '((double.parse(tax) / 100) * (t5 + double.parse(delivery))) ${((double.parse(tax) / 100) * (t5 + double.parse(delivery)))}');
        priceTax = double.parse(
            (((double.parse(tax) / 100) * (t5 + double.parse(delivery))))
                .toStringAsFixed(2));
        print('priceTax 1 $priceTax');
      } else {
        priceTax =
            double.parse((((double.parse(tax) / 100) * t5)).toStringAsFixed(2));
        print('priceTax 2 $priceTax');
      }

      //totalWithTax = double.parse((double.parse(delivery) + _total + priceTax).toStringAsFixed(2));
      if (isDelivery) {
        totalBill = (t5 + double.parse(delivery) + priceTax).toStringAsFixed(2);
      } else {
        totalBill = (t5 + priceTax).toStringAsFixed(2);
      }
      print('t5 = $t5  & priceTax $priceTax');
    } else {
      delivery = '0.0';
      tax = '0.0';
      totalBill = '0.0';
      priceTax = 0.0;
      //   totalWithTax = 0.0;
      total = 0.0;
      t5 = 0;
      discountValue = null;
      total_after_discount = 0;
      //  basket.clear();
    }
    print('total bill = $totalBill');
  }

  // resturant work or not work
  bool isWork = false;

  isResturantWork() {
    // showLoadingDialog(context);

    print('isResturantWork');

    GetTimesResturantUseCase(
            basketRepoImp: BasketRepoImp(
                basketDataSource: BasketDataSource(),
                networkInfo: NetworkInfoImp(
                    connectionChecker: InternetConnectionChecker())))
        .call()
        .then((value) {
      // dismissLoadingDialog(context);
      value.fold((l) {
        print('l amr $l');
        if (l is OffLineFailure) {
          failSnackBar('لا يوجد اتصال بالانترنت', 'برجاء الاتصال اولا');
        } else if (l is WrongDataFailure) {
          failSnackBar('البيانات خاظئة', 'من فضلك ادخل بيانات صحيحة');
        } else if (l is ServerFailure) {
          failSnackBar(
              'هناك مشكلة في السيرفر ', 'برجاء التواصل مع خدمة العملاء');
        } else if (l is PhoneUsedFailure) {
          failSnackBar(
              'رقم الهاتف موجود بالفعل', 'برجاء التواصل مع خدمة العملاء');
        }
      }, (times) async {
        TimeWorkModel model = times.last;
        int hour = DateTime.now().hour;
        print("Hour:$hour");
        print("From:${int.parse(model.from)}");
        print("To:${int.parse(model.to) + int.parse(model.ex)}");
        if (hour >= int.parse(model.from)) {
          isWork = true;
        } else if (hour <= (int.parse(model.to) + int.parse(model.ex))) {
          isWork = true;
        } else
          isWork = false;
      });
    });
  }


}
