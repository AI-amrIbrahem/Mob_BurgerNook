import 'package:dartz/dartz.dart';

import '../../../../util/errors/failures.dart';
import '../../data/models/category_model.dart';
import '../entity/slider_entity.dart';

abstract class HomeRepo{
  Future<Either<Failure,List<SliderHomeModel>>> getSlider();
  Future<Either<Failure,List<CategoryModel>>> getCategories();
}