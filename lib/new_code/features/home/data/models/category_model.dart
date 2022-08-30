
import 'package:burgernook/new_code/features/home/data/models/product_model.dart';

class CategoryModel {
  late String id;
  late String nameEn;
  late String nameAr;
  List<ProductModel>? products;

  CategoryModel({
    this.id ='',
    this.nameEn ='',
    this.nameAr ='',
    this.products ,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id= json['category_id'] ?? '';
    nameAr= json['title_ar'] ?? '';
    nameEn= json['title_en'] ?? '';
    products = const[];
  }

}
