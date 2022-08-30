import 'package:burgernook/new_code/features/Auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/failures.dart';

class RegisterUseCase {
  final AuthRepo repoImp;

  RegisterUseCase({required this.repoImp});

  Future<Either<Failure, bool>> call({required String userName , required String email , required String password , required String phone ,required emp_job}) async {
    return await repoImp.register(userName: userName, email: email, password: password, phone: phone, emp_job: emp_job);
  }

}