import 'package:burgernook/new_code/features/Auth/data/data_source/auth_data_sourcs.dart';
import 'package:burgernook/new_code/features/Auth/data/models/user_model.dart';
import 'package:burgernook/new_code/features/Auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/exceptions.dart';
import '../../../../util/errors/failures.dart';
import '../../../../util/network/network_info.dart';

class AuthRepoImp extends AuthRepo {
  AuthDataSource authDataSource;
  NetworkInfo networkInfo;

  AuthRepoImp({required this.authDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, UserModel>> login(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        UserModel userModel =
        await authDataSource.setLogin(userName: email, password: password);
        return right(userModel);
      } on WrongDataException {
        print('WrongDataException');
        return left(WrongDataFailure());
      } on BlockedDataException {
        return left(BlockedDataFailure());
      } on NotUserOrDeliveryException {
        return left(NotUserOrDeliveryDataFailure());
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> register({required String userName, required String email, required String password, required String phone, required emp_job}) async{
    if (await networkInfo.isConnected) {
      try {
        bool isRegister =
        await authDataSource.register(userName: userName, email: email, password: password, phone: phone, emp_job: emp_job);
        return right(isRegister);
      } on WrongDataException {
        print('WrongDataException');
        return left(WrongDataFailure());
      } on ServerException {
        return left(ServerFailure());
      }on PhoneUsedException {
        return left(PhoneUsedFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getUserID({required String email, required String phone}) async{
    if (await networkInfo.isConnected) {
      try {
        String id =
        await authDataSource.getUserId(email: email, phone: phone);
        return right(id);
      } on WrongDataException {
        print('WrongDataException');
        return left(WrongDataFailure());
      }on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> changePassword({required String password, required String user_id}) async{
    if (await networkInfo.isConnected) {
      try {
        print('passsss $password');
        bool isChange =
        await authDataSource.myNewPassword(password: password, user_id: user_id);
        return right(isChange);
      } on WrongDataException {
        print('WrongDataException');
        return left(WrongDataFailure());
      }on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deactive({required String user_id}) async{
    if (await networkInfo.isConnected) {
      try {
        bool isChange =
        await authDataSource.deactive(user_id: user_id);
        return right(isChange);
      } on WrongDataException {
        print('WrongDataException');
        return left(WrongDataFailure());
      }on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

}