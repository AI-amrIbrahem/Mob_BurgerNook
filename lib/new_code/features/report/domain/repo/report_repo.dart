import 'package:burgernook/new_code/features/basket/data/models/time_work_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../util/errors/failures.dart';
import '../../data/models/report_model.dart';

abstract class ReportRepo {
  Future<Either<Failure, bool>> makeReport(
      {required String userId, required String report});

  Future<Either<Failure, List<ReportModel>>> getAllReport();

  Future<Either<Failure, List<ReportModel>>> getReportByUserId(
      {required String userId});
}
