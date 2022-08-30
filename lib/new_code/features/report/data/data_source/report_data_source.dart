import 'dart:convert';

import 'package:burgernook/new_code/features/report/data/models/report_model.dart';
import 'package:burgernook/new_code/util/errors/exceptions.dart';
import 'package:burgernook/new_code/util/network/service.dart';
import 'package:http/http.dart';

class ReportDataSource {
  Future<bool> setReport({required String userId, required String desc}) async {
    try {
      Response response = await post(
          Uri.parse("${ServiceUrls.domain}/report/create.php"),
          body: {
            "user_id": userId,
            "message": desc,
          });
      var res = json.decode(response.body);
      print(res);
      if (!res['error']) {
        return true;
      }
      return false;
    } catch (error) {
      throw ServerException();
    }
  }

  Future<List<ReportModel>> getAllReport() async {
    try {
      List<ReportModel> reports = [];
      Response response =
          await post(Uri.parse("${ServiceUrls.domain}/report/read.php"), body: {
        "report": "report",
      });
      var res = json.decode(response.body);
      print(res);
      List data = res['report'];
      for (var item in data) {
        reports.add(ReportModel.fromJson(item));
      }
      return reports;
    } catch (error) {
      throw ServerException();
    }
  }

  Future<List<ReportModel>> getReportByUserId({required String userId}) async {
    try {
      List<ReportModel> reports = [];
      Response response = await post(
          Uri.parse("${ServiceUrls.domain}/report/readByUserId.php"),
          body: {
            "user_id": userId,
          });
      var res = json.decode(response.body);
      print(res);
      List data = res['report'];
      for (var item in data) {
        reports.add(ReportModel.fromJson(item));
      }
      return reports;
    } catch (error) {
      throw ServerException();
    }
  }
}
