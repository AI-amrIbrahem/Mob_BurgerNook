import 'package:burgernook/new_code/features/Auth/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../util/errors/failures.dart';


abstract class AuthRepo{
  Future<Either<Failure,UserModel>> login({required String email ,required String password});
  Future<Either<Failure,bool>> register({required String userName , required String email , required String password , required String phone ,required emp_job});
  Future<Either<Failure,String>> getUserID({
    required String email,
    required String phone
  });
  Future<Either<Failure,bool>> changePassword({
    required String password,
    required String user_id
  });
  Future<Either<Failure,bool>> deactive({
    required String user_id
  });
}