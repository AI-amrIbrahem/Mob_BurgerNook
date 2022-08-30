import 'package:burgernook/new_code/features/Auth/data/models/user_model.dart';
import 'package:burgernook/new_code/features/Auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/failures.dart';

class DeactiveUseCase {
  final AuthRepo repoImp;

  DeactiveUseCase({required this.repoImp});

  Future<Either<Failure, bool>> call({required String user_id}) async {
    return await repoImp.deactive(user_id: user_id);
  }

}