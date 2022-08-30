import 'package:burgernook/new_code/features/home/data/models/prices_model.dart';

import 'addition_model.dart';

class ProductModel{
  String id;
  String categoryId;
  String nameAr;
  String nameEn;
  String prduct_components;
  String prduct_componentsEn;
  String imageName;
  String count;
  String has_drink;
  String drink;
  String size;
  String note;
  List<PricesModel>? prices;
  PricesModel? price;
  List<AdditionModel>? additions;
  List<AdditionModel> orderAdditions= [];

  ProductModel({
    this.id ='',
    this.categoryId ='',
    this.nameAr ='',
    this.nameEn ='',
    this.prduct_components ='',
    this.prduct_componentsEn ='',
    this.imageName ='',
    this.count ='',
    this.has_drink='',
    this.drink ='',
    this.prices,
    this.price,
    this.additions,
    this.note='',
    this.size='',
    this.orderAdditions = const[],
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['product_id']??'',
      nameAr:json['title_ar']==null? '' : json['title_ar'].toString().replaceAll("&amp;", "&"),
      nameEn:json['title_en']==null? '' : json['title_en'].toString().replaceAll("&amp;", "&"),
      prduct_components:json['prduct_components']==null? '' : json['prduct_components'].toString().replaceAll("&amp;", "&"),
      prduct_componentsEn:json['prduct_components_en']==null? '' : json['prduct_components_en'].toString().replaceAll("&amp;", "&"),
      imageName: json['image_name']??'',
      categoryId: json['category_id']??'',
      has_drink: json['has_drink']??'',
      prices: getPrices(json),
      additions: getAdditions(json),
    );
  }

  factory ProductModel.fromJson2(Map<String, dynamic> json) {
    return ProductModel(
      id: json['product_id'] ??'',
      nameAr:json['title_ar']==null ? '': json['title_ar'].toString().replaceAll("&amp;", "&"),
      nameEn:json['title_en']==null ? '': json['title_en'].toString().replaceAll("&amp;", "&"),
      prduct_components:json['prduct_components']==null ? '': json['prduct_components'].toString().replaceAll("&amp;", "&"),
      prduct_componentsEn:json['prduct_components_en']==null ? '': json['prduct_components_en'].toString().replaceAll("&amp;", "&"),
      imageName: json['image_name']??'',
      categoryId: json['category_id']??'',
      has_drink: json['has_drink']??'',
      size: json['size']??'',
      drink: json['drink']??'',
      count: json['count']??'',
      price: PricesModel(price: json['price']),
      note: json['note']??'',
      prices: getPrices(json),
      additions: getAdditions(json),
    );
  }

  List<ProductModel> getProducts(json) {
    List<ProductModel> products = [];
    List data = json['products'];
    print('list amr $data');
    if(data!=null){
      for (var item in data) {
        if(item!=null){
          ProductModel product = ProductModel.fromJson(item);
          if(item['prices'][0]!=null)
            product.price = PricesModel.fromJson(item['prices'][0]);
          products.add(product);
        }
      }
    }
    print('products  amr ${products.length}');
    return products;
  }

}