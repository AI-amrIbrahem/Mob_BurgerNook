import 'package:burgernook/new_code/features/basket/presentation/controllers/basket_controller.dart';
import 'package:burgernook/new_code/features/home/presentation/views/home_screen.dart';
import 'package:burgernook/new_code/features/orders/data/data_source/order_data_source.dart';
import 'package:burgernook/new_code/features/orders/data/models/order_model.dart';
import 'package:burgernook/new_code/features/orders/data/repo/order_repo_imp.dart';
import 'package:burgernook/new_code/features/orders/domain/use_case/get_orders.dart';
import 'package:burgernook/new_code/features/orders/domain/use_case/get_products_orders.dart';
import 'package:burgernook/new_code/features/orders/domain/use_case/make_order.dart';
import 'package:burgernook/new_code/features/orders/domain/use_case/update_order_status_use_case.dart';
import 'package:burgernook/new_code/features/orders/presentation/controllers/track_order_controller.dart';
import 'package:burgernook/new_code/features/orders/presentation/views/order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../util/errors/failures.dart';
import '../../../../util/network/network_info.dart';
import '../../../../util/widgets/snackbar_widget.dart';
import '../../../Auth/presentation/controllers/login_controller.dart';
import '../../../address/data/data_source/address_data_source.dart';
import '../../../address/data/repo/address_repo_imp.dart';
import '../../../address/domain/use_case/get_address_use_case.dart';
import '../../../home/data/models/product_model.dart';
import '../../domain/use_case/get_assigned_orders.dart';

class OrderController extends GetxController {



  makeOrder({required OrderModel orderModel,required BuildContext context}) {
    showLoadingDialog(context,dismissible: false);
    MakeOrderUseCase(
            repoImp: OrderRepoImp(
                orderDataSource: OrderDataSource(),
                networkInfo: NetworkInfoImp(
                    connectionChecker: InternetConnectionChecker())))
        .call(orderModel: orderModel)
        .then((value) {
          dismissLoadingDialog(context);
      value.fold((l) {
        if (l is OffLineFailure) {
          failSnackBar('لا يوجد اتصال بالانترنت', 'برجاء الاتصال اولا');
        } else if (l is WrongDataFailure) {
          failSnackBar('البيانات خاظئة', 'من فضلك ادخل بيانات صحيحة');
        } else if (l is ServerFailure) {
          failSnackBar(
              'هناك مشكلة في السيرفر ', 'برجاء التواصل مع خدمة العملاء');
        }
      }, (isOrderMake) {
        if(isOrderMake) {
          // Get.delete<BasketController>();
          //TrackOrderController().getAddress(userId:  userModelGlobal.id, currentOrder: orderModel,isMap: false);
          Get.offAll(HomeScreen());
          Get.put(BasketController());
          Get.to(OrdersViewScreen());
        }
        else{
          print('order don\'t make ');
        }
      });
    });
  }


  var userOrdersList = [].obs;
  var isLoading = true.obs;
  getOrders() {
    GetUserOrderUseCase(
        repoImp: OrderRepoImp(
            orderDataSource: OrderDataSource(),
            networkInfo: NetworkInfoImp(
                connectionChecker: InternetConnectionChecker())))
        .call()
        .then((value) {
      value.fold((l) {
        if (l is OffLineFailure) {
          failSnackBar('لا يوجد اتصال بالانترنت', 'برجاء الاتصال اولا');
        } else if (l is WrongDataFailure) {
          failSnackBar('البيانات خاظئة', 'من فضلك ادخل بيانات صحيحة');
        } else if (l is ServerFailure) {
          failSnackBar(
              'هناك مشكلة في السيرفر ', 'برجاء التواصل مع خدمة العملاء');
        }
      }, (orders) {
        userOrdersList.value = orders;
        isLoading.value = false;
      });
    });
  }

  var isProductsLoading = true.obs;
  List<ProductModel> products = [];

  getProductOfOrder({required String orderId}) {
    isProductsLoading = true.obs;
    GetProductsOfOrderUseCase(
        repoImp: OrderRepoImp(
            orderDataSource: OrderDataSource(),
            networkInfo: NetworkInfoImp(
                connectionChecker: InternetConnectionChecker())))
        .call(orderId: orderId)
        .then((value) {
      value.fold((l) {
        if (l is OffLineFailure) {
          failSnackBar('لا يوجد اتصال بالانترنت', 'برجاء الاتصال اولا');
        } else if (l is WrongDataFailure) {
          failSnackBar('البيانات خاظئة', 'من فضلك ادخل بيانات صحيحة');
        } else if (l is ServerFailure) {
          failSnackBar(
              'هناك مشكلة في السيرفر ', 'برجاء التواصل مع خدمة العملاء');
        }
      }, (products1) {
        print('def ref');
        products = products1;
        isProductsLoading.value = false;
      });
    });
  }


  updateOrderStatus({required String statusID, required String orderId,required BuildContext context}) {
    showLoadingDialog(context,dismissible: false);
    UpdateOrderStatusUseCase(
        repoImp: OrderRepoImp(
            orderDataSource: OrderDataSource(),
            networkInfo: NetworkInfoImp(
                connectionChecker: InternetConnectionChecker())))
        .call(statusID: statusID, orderId: orderId)
        .then((value) {
          dismissLoadingDialog(context);
      value.fold((l) {
        if (l is OffLineFailure) {
          failSnackBar('لا يوجد اتصال بالانترنت', 'برجاء الاتصال اولا');
        } else if (l is WrongDataFailure) {
          failSnackBar('البيانات خاظئة', 'من فضلك ادخل بيانات صحيحة');
        } else if (l is ServerFailure) {
          failSnackBar(
              'هناك مشكلة في السيرفر ', 'برجاء التواصل مع خدمة العملاء');
        }
      }, (isUpdateOrder) {
        Get.back();
        isLoading.value = true;
        getAssignedOrders();

      });
    });
  }

  Future getAddress({required String userId}) async{
    // showLoadingDialog(context);
    if(userId != '0'){
      await GetAddressUseCase(
          addressDataSource: AddressRepoImp(
              addressDataSource: AddressDataSource(),
              networkInfo: NetworkInfoImp(
                  connectionChecker: InternetConnectionChecker())))
          .call(userId: userId)
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
          return [];
        }, (address) async {
          return address;
        });
      });
    }
  }

  getAssignedOrders() {
    GetAssignedOrderUseCase(
        repoImp: OrderRepoImp(
            orderDataSource: OrderDataSource(),
            networkInfo: NetworkInfoImp(
                connectionChecker: InternetConnectionChecker())))
        .call()
        .then((value) {
      value.fold((l) {
        if (l is OffLineFailure) {
          failSnackBar('لا يوجد اتصال بالانترنت', 'برجاء الاتصال اولا');
        } else if (l is WrongDataFailure) {
          failSnackBar('البيانات خاظئة', 'من فضلك ادخل بيانات صحيحة');
        } else if (l is ServerFailure) {
          failSnackBar(
              'هناك مشكلة في السيرفر ', 'برجاء التواصل مع خدمة العملاء');
        }
      }, (orders) {
        userOrdersList.value = orders;
        isLoading.value = false;
      });
    });
  }


}