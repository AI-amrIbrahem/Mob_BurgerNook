import 'package:burgernook/new_code/features/Auth/data/models/user_model.dart';
import 'package:burgernook/new_code/features/Auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/failures.dart';

class LoginUseCase {
  final AuthRepo repoImp;

  LoginUseCase({required this.repoImp});

  Future<Either<Failure, UserModel>> call({required String email, required String password}) async {
    return await repoImp.login(email: email, password: password);
  }

}