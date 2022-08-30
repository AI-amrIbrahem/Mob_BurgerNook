import 'package:burgernook/new_code/features/home/data/models/product_model.dart';

class AdditionModel {
  late String addition_id;
  ProductModel? addition_data;
  late String price;
  late bool isActive;

  AdditionModel({
    this.addition_id = '',
    this.addition_data,
    this.price = '',
    this.isActive = false,
  });

  AdditionModel.fromJson(Map<String, dynamic> json) {
    addition_id = json['addition_id'] ?? '';
    //price: Prices.fromJson(json['price']),
    price = json['price'] == null
        ? "0"
        : json['price'].toString().isEmpty
            ? "0"
            : json['price'].toString();
    addition_data = json['addition_data'] is List
        ? ((json['addition_data'] as List).isNotEmpty
            ? json['addition_data'][0]
            : ProductModel())
        : ProductModel.fromJson(json['addition_data']);
  }
}

List<AdditionModel> getAdditions(Map<String, dynamic> json) {
  List<AdditionModel> additions = [];
  print(' json[additions]${json['additions']}');
  var data = json['additions'];
  if (data != null ) {
    if(data.isNotEmpty){
      print(data);
      for (var item in data) {
        if (item != null) additions.add(AdditionModel.fromJson(item));
      }
    }
  }
  return additions;
}
