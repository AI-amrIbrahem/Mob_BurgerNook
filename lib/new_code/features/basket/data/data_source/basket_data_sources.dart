import 'dart:convert';

import 'package:burgernook/new_code/features/basket/data/models/time_work_model.dart';
import 'package:burgernook/new_code/util/errors/exceptions.dart';
import 'package:burgernook/new_code/util/network/service.dart';
import 'package:http/http.dart';
import '../models/coupon_model.dart';

class BasketDataSource {
  // Future<List<CategoryModel>> getCategories() async {
  //   List<CategoryModel> categories = [];
  //   try{
  //     http.Response response = await http.post(Uri.parse("${ServiceUrls.domain}/categories/read.php"),
  //         body: {"categories": "categories"});
  //     print('response.body${response.body}');
  //     Map<String, dynamic> res = json.decode(response.body);
  //     List data = res['categories'] ;
  //     if(data!=null)
  //       for (var item in data) {
  //         print(item);
  //         if(item!=null){
  //           CategoryModel category = CategoryModel.fromJson(item);
  //           List<ProductModel> products = ProductModel().getProducts(item);
  //           category.products = products;
  //           categories.add(category);
  //         }
  //       }
  //   }catch (error) {
  //     throw ServerFailure();
  //   }
  //
  //   print('amr category length ${categories.length}');
  //   return categories;
  //
  // }

  Future<List<TimeWorkModel>> getTimesWork() async {
    List<TimeWorkModel> times = [];
    print('aaa');
    try {
      var url = '${ServiceUrls.domain}/getTime.php';
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        data.forEach((element) {
          times.add(TimeWorkModel.fromJson(element));
        });
      }
      print('123');
    } catch (error) {
      throw ServerException();
    }
    print('amr category length ${times.length}');
    return times;
  }

  Future getCouponDiscount(String coupon) async {
    List coupons = [];
    try {
      Response response = await post(
          Uri.parse("${ServiceUrls.domain}/coupons/read.php"),
          body: {"name": coupon});
      var data = json.decode(response.body);
      print("CouponsResponse:$data");
      coupons = data['coupons'];
    } catch (error) {
      throw ServerException();
    }
    if (coupons.isEmpty) {
      throw WrongDataException();
    }
    CouponModel m = CouponModel.fromJson(coupons[0]);
    return int.parse(m.value);
  }


  Future getDataFromLockups() async {
    List lockups = [];
    try {
      Response response =
      await post(Uri.parse("${ServiceUrls.domain}/lockups/read.php"), body: {"data": "data"});
      var data = json.decode(response.body);
      lockups = data['lockups'];
    } catch (error) {
      throw ServerException();
    }
    print('lockups $lockups');
    return lockups;
  }

}