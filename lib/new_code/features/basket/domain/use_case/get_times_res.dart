import 'package:burgernook/new_code/features/basket/data/models/time_work_model.dart';
import 'package:burgernook/new_code/features/basket/domain/repo/basket_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/failures.dart';

class GetTimesResturantUseCase {
  final BasketRepo basketRepoImp;

  GetTimesResturantUseCase({required this.basketRepoImp});

  Future<Either<Failure, List<TimeWorkModel>>> call() async {
    return await basketRepoImp.getTimeResturantWork();
  }
}
