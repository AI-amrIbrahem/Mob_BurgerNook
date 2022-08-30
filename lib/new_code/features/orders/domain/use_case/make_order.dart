import 'package:burgernook/new_code/features/orders/data/models/order_model.dart';
import 'package:burgernook/new_code/features/orders/domain/repo/order_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/failures.dart';

class MakeOrderUseCase {
  final OrderRepo repoImp;

  MakeOrderUseCase({required this.repoImp});

  Future<Either<Failure, bool>> call({required OrderModel orderModel}) async {
    return await repoImp.setOrder(orderModel: orderModel);
  }
}
