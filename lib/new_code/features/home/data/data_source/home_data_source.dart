import 'dart:convert';

import 'package:burgernook/new_code/features/home/data/models/product_model.dart';
import 'package:burgernook/new_code/features/home/data/models/slider_model.dart';
import 'package:burgernook/new_code/util/network/service.dart';

import 'package:http/http.dart' as http;

import '../../../../util/errors/exceptions.dart';
import '../../../../util/errors/failures.dart';
import '../models/category_model.dart';

class HomeDataSource {
  Future<List<SliderModelResponse>> getSlider() async {
    List<SliderModelResponse> sliders = [];
    try {
      http.Response response = await http.post(
          Uri.parse("${ServiceUrls.domain}/slider/read.php"),
          body: {"slider": "slider"});
      var res = json.decode(response.body);
      print('res$res');
      List data = res['slider'];
      for (var item in data) {
        sliders.add(SliderModelResponse.fromJson(item));
      }
    } catch (error) {
      throw ServerException();
    }
    return sliders;
  }
  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categories = [];
    print('get categories work');
    try{
      http.Response response = await http.post(Uri.parse("${ServiceUrls.domain}/categories/read.php"),
          body: {"categories": "categories"});
      print('response.body${response.body}');
      Map<String, dynamic> res = json.decode(response.body);
      List data = res['categories'] ;
      if(data!=null)
        for (var item in data) {
          print(item);
          if(item!=null){
            CategoryModel category = CategoryModel.fromJson(item);
            List<ProductModel> products = ProductModel().getProducts(item);
            category.products = products;
            categories.add(category);
          }
        }
    }catch (error) {
      throw ServerException();
    }

    print('amr category length ${categories.length}');
    return categories;

  }
}
