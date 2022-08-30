import 'package:burgernook/new_code/features/home/data/models/product_model.dart';
import 'package:burgernook/new_code/features/orders/domain/repo/order_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/failures.dart';

class GetProductsOfOrderUseCase {
  final OrderRepo repoImp;

  GetProductsOfOrderUseCase({required this.repoImp});

  Future<Either<Failure, List<ProductModel>>> call({required String orderId}) async {
    return await repoImp.getProductOFOrder(orderId: orderId);
  }
}
