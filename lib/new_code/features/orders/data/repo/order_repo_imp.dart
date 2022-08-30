import 'package:burgernook/new_code/features/home/data/models/product_model.dart';
import 'package:burgernook/new_code/features/orders/data/models/order_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/exceptions.dart';
import '../../../../util/errors/failures.dart';
import '../../../../util/network/network_info.dart';
import '../../domain/repo/order_repo.dart';
import '../data_source/order_data_source.dart';

class OrderRepoImp extends OrderRepo {
  OrderDataSource orderDataSource;
  NetworkInfo networkInfo;

  OrderRepoImp({required this.orderDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, bool>> setOrder(
      {required OrderModel orderModel}) async {
    if (await networkInfo.isConnected) {
      try {
        bool isMake = await orderDataSource.MakeOrder(orderModel: orderModel);
        return right(isMake);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> setUserOrders() async {
    if (await networkInfo.isConnected) {
      try {
        List<OrderModel> orders = await orderDataSource.getOrdersOfUser();
        return right(orders);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateOrderStatus(
      {required String statusID, required String orderId}) async {
    if (await networkInfo.isConnected) {
      try {
        bool isUpdateStatus = await orderDataSource.updateOrderStatus(
            statusID: statusID, orderId: orderId);
        return right(isUpdateStatus);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProductOFOrder(
      {required String orderId}) async {
    if (await networkInfo.isConnected) {
      try {
        List<ProductModel> products =
            await orderDataSource.getProductOFOrder(orderId);
        return right(products);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getAssignedOrders() async {
    if (await networkInfo.isConnected) {
      try {
        List<OrderModel> orders = await orderDataSource.getAssignedOrders();
        return right(orders);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

}
