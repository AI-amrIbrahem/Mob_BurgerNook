import 'package:burgernook/new_code/features/home/data/models/addition_model.dart';
import 'package:burgernook/new_code/features/home/data/models/prices_model.dart';


class OrderDetailsModel {
  PricesModel prices;
  int count;
  String note;
  String drink;
  String total;

  List<AdditionModel> orderAdditions;

  OrderDetailsModel({
    required this.prices,
    this.count = 1,
    this.note = '',
    this.drink = 'Pepsi',
    required this.orderAdditions ,
    this.total = '',
  });

}