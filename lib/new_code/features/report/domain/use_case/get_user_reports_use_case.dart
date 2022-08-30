import 'package:burgernook/new_code/features/report/data/models/report_model.dart';
import 'package:burgernook/new_code/features/report/domain/repo/report_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/failures.dart';

class GetUserReportsUseCase {
  final ReportRepo repoImp;

  GetUserReportsUseCase({required this.repoImp});

  Future<Either<Failure, List<ReportModel>>> call({required String userId}) async {
    return await repoImp.getReportByUserId(userId: userId);
  }
}
