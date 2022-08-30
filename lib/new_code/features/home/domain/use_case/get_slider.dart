import 'package:burgernook/new_code/features/home/domain/repo/home_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/failures.dart';
import '../entity/slider_entity.dart';

class GetSliderUseCase {
  final HomeRepo repoImp;

  GetSliderUseCase({required this.repoImp});

  Future<Either<Failure, List<SliderHomeModel>>> call() async {
    return await repoImp.getSlider();
  }
}
