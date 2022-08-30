import 'package:burgernook/new_code/features/basket/data/models/time_work_model.dart';
import 'package:burgernook/new_code/features/basket/domain/repo/basket_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/exceptions.dart';
import '../../../../util/errors/failures.dart';
import '../../../../util/network/network_info.dart';
import '../data_source/basket_data_sources.dart';

class BasketRepoImp extends BasketRepo {
  BasketDataSource basketDataSource;
  NetworkInfo networkInfo;

  BasketRepoImp({required this.basketDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<TimeWorkModel>>> getTimeResturantWork() async{
    if (await networkInfo.isConnected) {
      try {
        List<TimeWorkModel> times =
        await basketDataSource.getTimesWork();
        return right(times);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, int>> getCoupons({required String coupon}) async{
    if (await networkInfo.isConnected) {
      try {
        int copoun =
        await basketDataSource.getCouponDiscount(coupon);
        return right(copoun);
      } on ServerException {
        return left(ServerFailure());
      } on WrongDataException {
        return left(WrongDataFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, List>> getLockups() async{
    if (await networkInfo.isConnected) {
      try {
        List lockups =
        await basketDataSource.getDataFromLockups();
        return right(lockups);
      } on ServerException {
        return left(ServerFailure());
      } on WrongDataException {
        return left(WrongDataFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

}