import 'dart:convert';

import 'package:burgernook/new_code/features/Auth/presentation/controllers/login_controller.dart';
import 'package:burgernook/new_code/features/basket/data/models/order_details_model.dart';
import 'package:burgernook/new_code/features/home/data/models/addition_model.dart';
import 'package:burgernook/new_code/features/home/data/models/prices_model.dart';
import 'package:burgernook/new_code/features/home/data/models/slider_model.dart';
import 'package:burgernook/new_code/util/errors/exceptions.dart';
import 'package:burgernook/new_code/util/network/service.dart';

import 'package:http/http.dart' as http;

import '../../../../util/errors/failures.dart';
import '../../../home/data/models/product_model.dart';
import '../models/order_model.dart';

class OrderDataSource {
  Future<bool> MakeOrder({required OrderModel orderModel}) async {
    var res;
    try {
      http.Response response = await http.post(
          Uri.parse("${ServiceUrls.domain}/order/create.php"),
          body: orderModel.toMap());
      res = json.decode(response.body);
      print(response.body);
    } catch (error) {
      throw ServerException();
    }
    if (!res['error']) {
      for (OrderDetailsModel p in orderModel.orderDetailsList) {
        setOrderDetails(p, res['last_order_id'].toString());
      }
      return true;
    } else {
      print('error ${res['message']}');
      return false;
    }
  }

  Future<bool> setOrderDetails(
      OrderDetailsModel orderDetails, String orderId) async {
    PricesModel prices = orderDetails.prices;
    http.Response response = await http.post(
        Uri.parse("${ServiceUrls.domain}/ordersDetails/create.php"),
        body: {
          "order_id": orderId,
          "product_id": prices.product!.id,
          "product_price": prices.price,
          "quantity": orderDetails.count.toString(),
          "size": prices.size_name,
          "drink":
              prices.product!.has_drink == "Yes" || orderDetails.drink == null
                  ? orderDetails.drink
                  : "",
          "note": orderDetails.note == null ? "" : orderDetails.note,
        });
    var res = json.decode(response.body);
    print(response.body);
    //print(res);
    if (!res['error']) {
      for (AdditionModel p in orderDetails.orderAdditions) {
        setOrderAdditions(p, orderDetails, res['order_details_id'].toString());
      }
      return true;
    } else {
      return false;
    }
  }

  Future<bool> setOrderAdditions(AdditionModel orderAdditions,
      OrderDetailsModel orderDetails, String order_details_id) async {
    http.Response response = await http.post(
        Uri.parse("${ServiceUrls.domain}/ordersAdditions/create.php"),
        body: {
          "order_details_id": order_details_id.toString(),
          "product_id": orderDetails.prices.product_id.toString(),
          "addition_id": orderAdditions.addition_data!.id.toString(),
          "orders_additions_price": orderAdditions.price.toString(),
        });
    var res = json.decode(response.body);
    print(response.body);
    //print(res);
    if (!res['error']) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<OrderModel>> getOrdersOfUser() async {
    List<OrderModel> orders = [];
    var res;
    print('userModelGlobal.id${userModelGlobal.id}');
    if (userModelGlobal.id != '0') {
      try {
        http.Response response = await http.post(
            Uri.parse("${ServiceUrls.domain}/order/readByUserId.php"),
            body: {
              "user_id": userModelGlobal.id,
            });
        res = json.decode(response.body);
      } catch (error) {
        print('error error $error');
        throw ServerException();
      }
      print('orders res');

      List data = res['order'];
      print(data);
      for (var item in data) {
        orders.insert(0, OrderModel.fromJson(item));
      }
    }
    return orders;
  }

  Future<bool> updateOrderStatus(
      {required String statusID, required String orderId}) async {
    print('orderId = $orderId && statusID = $statusID');
    var res;
    try {
      http.Response response = await http.post(
          Uri.parse("${ServiceUrls.domain}/order/updateOrderStatus.php"),
          body: {
            "status_id": statusID,
            "order_id": orderId,
          });
      res = json.decode(response.body);
      print(res);
    } catch (error) {
      throw ServerException();
    }
    if (!res['error']) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<ProductModel>> getProductOFOrder(String orderId) async {
    List<ProductModel> products = [];
    var res;
    try {
      http.Response response = await http.post(
          Uri.parse("${ServiceUrls.domain}/ordersDetails/readByOrderId.php"),
          body: {
            "order_id": orderId,
          });
      res = json.decode(response.body);
      print(res);
      List data = res['products'];
      for (var item in data) {
        ProductModel product = ProductModel.fromJson2(item);
        List orderAdditions = item['OrderAdditions'];
        product.orderAdditions = [];
        for (var item2 in orderAdditions) {
          print(item2['addition_data']['title_ar']);
          AdditionModel addition = AdditionModel(
              price: item2['orders_additions_price'],
              addition_id: item2['addition_id'],
              addition_data: ProductModel.fromJson(item2['addition_data']));
          product.orderAdditions.add(addition);
        }
        products.add(product);
      }
      return products;
    } catch (error) {
      throw ServerException();
    }
  }

  Future<List<OrderModel>> getAssignedOrders() async {
    try {
      List<OrderModel> orders = [];
      http.Response response = await http.post(
          Uri.parse("${ServiceUrls.domain}/order/readByAssignedId.php"),
          body: {"assigned_id": userModelGlobal.id});
      print(response.body);
      var res = json.decode(response.body);
      //print(res);
      List data = res['order'];
      for (var item in data) {
        orders.add(OrderModel.fromJson(item));
      }
      return orders;
    } catch (error) {
      throw ServerException();
    }
  }
}
