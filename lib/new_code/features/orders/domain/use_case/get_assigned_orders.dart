import 'package:burgernook/new_code/features/orders/data/models/order_model.dart';
import 'package:burgernook/new_code/features/orders/domain/repo/order_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/failures.dart';

class GetAssignedOrderUseCase {
  final OrderRepo repoImp;

  GetAssignedOrderUseCase({required this.repoImp});

  Future<Either<Failure, List<OrderModel>>> call() async {
    return await repoImp.getAssignedOrders();
  }
}
