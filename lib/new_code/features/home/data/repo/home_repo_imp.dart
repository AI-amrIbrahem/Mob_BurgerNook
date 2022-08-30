import 'package:burgernook/new_code/features/home/data/data_source/home_data_source.dart';
import 'package:burgernook/new_code/features/home/data/models/slider_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/helper/extensions.dart';
import '../../../../util/errors/exceptions.dart';
import '../../../../util/errors/failures.dart';
import '../../../../util/network/network_info.dart';
import '../../domain/entity/slider_entity.dart';
import '../../domain/repo/home_repo.dart';
import '../models/category_model.dart';

class HomeRepoImp extends HomeRepo {
  HomeDataSource homeDataSource;
  NetworkInfo networkInfo;

  HomeRepoImp({required this.homeDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<SliderHomeModel>>> getSlider() async {
    // TODO: implement getSlider
    //throw UnimplementedError();
    if (await networkInfo.isConnected) {
      try {
        List<SliderModelResponse> slidesResponse =
        await homeDataSource.getSlider();
        if (slidesResponse.isEmpty) return right([]);

        List<SliderHomeModel> slides = [];
        slidesResponse.forEach((SliderModelResponse element) {
          slides.add(SliderHomeModel(id: element.id.orNull(),
              name: element.name.orNull(),
              action: element.action.orNull(),
              content: element.content.orNull())
          );
        });
        return right(slides);
      } on WrongDataException {
        return left(WrongDataFailure());
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    if (await networkInfo.isConnected) {
      try {
        List<CategoryModel> categoryResponse = await homeDataSource.getCategories();
        return right(categoryResponse);
      } on WrongDataException {
        return left(WrongDataFailure());
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
