import 'package:burgernook/new_code/features/home/data/models/product_model.dart';

class PricesModel {
  late String price_id, size_id, size_name, product_id, price;
  ProductModel? product ;
  late String note;
  late int count;

  PricesModel({
    this.product,
    this.price_id ='',
    this.size_id ='',
    this.size_name ='',
    this.product_id ='',
    this.count =0,
    this.price ='',
    this.note ='',
  });

  PricesModel.fromJson(json) {
    price_id= json['price_id']??'';
    size_id= json['size_id']??'';
    size_name= json['size_name']??'';
    product_id= json['product_id']??'';
    price= json['price']; product= ProductModel();
  }
}

List<PricesModel> getPrices(Map<String, dynamic> json) {
  List<PricesModel> prices = [];
  var data = json['prices'];
  if (data != null) {
    for (var item in data) {
      PricesModel price = PricesModel.fromJson(item);
      if (price.size_id == "16") {
        prices.clear();
        prices.add(price);
        break;
      } else {
        prices.add(price);
      }
    }
  }
  return prices;
}
