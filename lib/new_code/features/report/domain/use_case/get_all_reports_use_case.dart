import 'package:burgernook/new_code/features/report/domain/repo/report_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/failures.dart';
import '../../data/models/report_model.dart';

class GetAllReportsUseCase {
  final ReportRepo repoImp;

  GetAllReportsUseCase({required this.repoImp});

  Future<Either<Failure, List<ReportModel>>> call() async {
    return await repoImp.getAllReport();
  }
}
