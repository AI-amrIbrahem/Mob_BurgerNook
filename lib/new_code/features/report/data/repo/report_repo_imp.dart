import 'package:burgernook/new_code/features/report/data/data_source/report_data_source.dart';
import 'package:burgernook/new_code/features/report/data/models/report_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/exceptions.dart';
import '../../../../util/errors/failures.dart';
import '../../../../util/network/network_info.dart';
import '../../domain/repo/report_repo.dart';

class ReportRepoImp extends ReportRepo {
  ReportDataSource reportDataSource;
  NetworkInfo networkInfo;

  ReportRepoImp({required this.reportDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<ReportModel>>> getAllReport() async {
    if (await networkInfo.isConnected) {
      try {
        List<ReportModel> reports = await reportDataSource.getAllReport();
        return right(reports);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, List<ReportModel>>> getReportByUserId(
      {required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        List<ReportModel> reports =
            await reportDataSource.getReportByUserId(userId: userId);
        return right(reports);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> makeReport(
      {required String userId, required String report}) async {
    if (await networkInfo.isConnected) {
      try {
        bool isReportSent =
            await reportDataSource.setReport(userId: userId, desc: report);
        return right(isReportSent);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
