import 'package:burgernook/new_code/features/Auth/data/models/user_model.dart';
import 'package:burgernook/new_code/features/Auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/failures.dart';

class GetUserIdUseCase {
  final AuthRepo repoImp;

  GetUserIdUseCase({required this.repoImp});

  Future<Either<Failure, String>> call({required String email, required String phone}) async {
    return await repoImp.getUserID(email: email, phone: phone);
  }

}
