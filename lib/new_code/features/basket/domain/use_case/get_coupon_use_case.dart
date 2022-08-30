import 'package:burgernook/new_code/features/basket/data/models/time_work_model.dart';
import 'package:burgernook/new_code/features/basket/domain/repo/basket_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/failures.dart';

class GetCouponUseCase {
  final BasketRepo basketRepoImp;

  GetCouponUseCase({required this.basketRepoImp});

  Future<Either<Failure, int>> call({required String coupon}) async {
    return await basketRepoImp.getCoupons(coupon: coupon);
  }
}
