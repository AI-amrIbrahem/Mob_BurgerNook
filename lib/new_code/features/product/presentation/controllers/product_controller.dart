import 'package:burgernook/new_code/features/home/data/models/prices_model.dart';
import 'package:get/get.dart';

import '../../../basket/data/models/order_details_model.dart';
import '../../../home/data/models/addition_model.dart';
import '../../../home/data/models/product_model.dart';

class ProductController extends GetxController {
  int counter = 0;
  int value = 0;
  late ProductModel product;
  bool errorNote = false;
  String errorN = '';
  late OrderDetailsModel orderDetails;

  void init(ProductModel product1){
    product = product1;
    orderDetails = OrderDetailsModel(
        prices: PricesModel(product: product), orderAdditions: []);
    product.price = product.prices![0];
    orderDetails.orderAdditions = [];
    orderDetails.total = product.prices![0].price;
    for (AdditionModel item in product.additions!) {
      item.isActive = false;
    }
  }

  changeSize(index) {
      double price = (double.parse(
          orderDetails.total) -
          double.parse(product
              .prices![value].price));
      price = price +
          double.parse(
              product
              .prices![int.parse(
              index.toString())]
              .price);
      orderDetails.total = price
          .toString(); //(double.parse(orderDetails.total) + price).toString();
      value =
          int.parse(index.toString());
      product.price =
      product.prices![int.parse(index.toString())];
      update();
  }

  void changeAdditions(bool? value,addition) {
    print(value);
    addition.isActive = value!;
    if (addition.isActive) {
      double price = double.parse(
          addition.price) +
          double.parse(orderDetails.total);
      orderDetails.total = price.toString();
      orderDetails.orderAdditions
          .add(addition);
    } else {
      double price =
          double.parse(orderDetails.total) -
              double.parse(addition.price);
      orderDetails.total = price.toString();
      orderDetails.orderAdditions
          .remove(addition);
    }
    update();
  }

  void changeJuice(String? value) {
    //   widget.product.drink = value;
    orderDetails.drink = value!;
    // setState(() {});
    update();

  }

  void addProduct() {
    product.price!.product = product;
    orderDetails.prices = product.price!;
  }

}