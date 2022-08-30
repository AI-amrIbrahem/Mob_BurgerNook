import 'package:burgernook/new_code/features/orders/domain/repo/order_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/failures.dart';

class UpdateOrderStatusUseCase {
  final OrderRepo repoImp;

  UpdateOrderStatusUseCase({required this.repoImp});

  Future<Either<Failure, bool>> call({required String statusID, required String orderId}) async {
    return await repoImp.updateOrderStatus(statusID: statusID, orderId: orderId);
  }
}