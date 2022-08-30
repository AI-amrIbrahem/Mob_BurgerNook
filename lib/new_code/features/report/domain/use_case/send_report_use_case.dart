import 'package:burgernook/new_code/features/report/domain/repo/report_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/failures.dart';

class SendReportUseCase {
  final ReportRepo repoImp;

  SendReportUseCase({required this.repoImp});

  Future<Either<Failure, bool>> call({required String userId,required String report}) async {
    return await repoImp.makeReport(userId: userId, report: report);
  }
}
