import 'package:burgernook/new_code/features/orders/data/models/order_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../util/errors/failures.dart';
import '../../../home/data/models/product_model.dart';

abstract class OrderRepo{
  Future<Either<Failure,bool>> setOrder({required OrderModel orderModel});
  Future<Either<Failure,List<OrderModel>>> setUserOrders();
  Future<Either<Failure,bool>> updateOrderStatus({required String statusID,required String orderId});
  Future<Either<Failure,List<ProductModel>>> getProductOFOrder({required String orderId});
  Future<Either<Failure,List<OrderModel>>> getAssignedOrders();

}

