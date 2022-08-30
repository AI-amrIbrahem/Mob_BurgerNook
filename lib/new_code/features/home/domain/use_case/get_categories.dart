import 'package:burgernook/new_code/features/home/domain/repo/home_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/failures.dart';
import '../../data/models/category_model.dart';

class GetCategoriesUseCase {
  final HomeRepo repoImp;

  GetCategoriesUseCase({required this.repoImp});

  Future<Either<Failure, List<CategoryModel>>> call() async {
    return await repoImp.getCategories();
  }
}