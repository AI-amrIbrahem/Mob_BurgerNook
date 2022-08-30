import 'package:burgernook/new_code/features/basket/data/models/time_work_model.dart';
import 'package:burgernook/new_code/features/basket/domain/repo/basket_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/failures.dart';

class GetLockupsUseCase {
  final BasketRepo basketRepoImp;

  GetLockupsUseCase({required this.basketRepoImp});

  Future<Either<Failure, List>> call() async {
    return await basketRepoImp.getLockups();
  }
}
