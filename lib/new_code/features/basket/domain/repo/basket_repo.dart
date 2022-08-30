import 'package:burgernook/new_code/features/basket/data/models/time_work_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../util/errors/failures.dart';

abstract class BasketRepo{
  Future<Either<Failure,List<TimeWorkModel>>> getTimeResturantWork();
  Future<Either<Failure,int>> getCoupons({required String coupon});
  Future<Either<Failure,List>> getLockups();
}