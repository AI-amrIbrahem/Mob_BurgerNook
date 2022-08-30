import 'package:burgernook/new_code/features/Auth/presentation/views/login_screen.dart';
import 'package:burgernook/new_code/features/report/data/data_source/report_data_source.dart';
import 'package:burgernook/new_code/features/report/data/models/report_model.dart';
import 'package:burgernook/new_code/features/report/data/repo/report_repo_imp.dart';
import 'package:burgernook/new_code/features/report/domain/use_case/get_user_reports_use_case.dart';
import 'package:burgernook/new_code/features/report/domain/use_case/send_report_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../util/errors/failures.dart';
import '../../../../util/network/network_info.dart';
import '../../../../util/widgets/snackbar_widget.dart';
import '../../../Auth/presentation/controllers/login_controller.dart';

class ReportController extends GetxController {
  List<ReportModel> userReports = [];
  var isLoading = true;

  var reportController = TextEditingController();

  getUserReports({required String userId}) {
    // showLoadingDialog(context);
    if (isLogin && isUser) {
      GetUserReportsUseCase(
              repoImp: ReportRepoImp(
                  reportDataSource: ReportDataSource(),
                  networkInfo: NetworkInfoImp(
                      connectionChecker: InternetConnectionChecker())))
          .call(userId: userId)
          .then((value) {
        // dismissLoadingDialog(context);
        value.fold((l) {
          print('l amr $l');
          if (l is OffLineFailure) {
            failSnackBar('لا يوجد اتصال بالانترنت', 'برجاء الاتصال اولا');
          } else if (l is WrongDataFailure) {
            failSnackBar('البيانات خاظئة', 'من فضلك ادخل بيانات صحيحة');
          } else if (l is ServerFailure) {
            failSnackBar(
                'هناك مشكلة في السيرفر ', 'برجاء التواصل مع خدمة العملاء');
          }
        }, (reports) async {
          userReports = reports;
          isLoading = false;
          update();
        });
      });
    } else {
      isLoading = false;
      update();
    }
  }

  sendReport({ required String reportText,required BuildContext context}) {
     showLoadingDialog(context,dismissible: false);
    if (isLogin) {
      if (isUser) {
        SendReportUseCase(
            repoImp: ReportRepoImp(
                reportDataSource: ReportDataSource(),
                networkInfo: NetworkInfoImp(
                    connectionChecker: InternetConnectionChecker())))
            .call(userId: userModelGlobal.id, report: reportText)
            .then((value) {
          // dismissLoadingDialog(context);
          value.fold((l) {
            print('l amr $l');
            if (l is OffLineFailure) {
              failSnackBar('لا يوجد اتصال بالانترنت', 'برجاء الاتصال اولا');
            } else if (l is WrongDataFailure) {
              failSnackBar('البيانات خاظئة', 'من فضلك ادخل بيانات صحيحة');
            } else if (l is ServerFailure) {
              failSnackBar(
                  'هناك مشكلة في السيرفر ', 'برجاء التواصل مع خدمة العملاء');
            }
          }, (value) async {
            if(value){
              dismissLoadingDialog(context);
              getUserReports(userId:userModelGlobal.id);
              Get.back();
            }
          });
        });
      }
    } else {
      Get.to(LoginViewScreen());
    }
  }

}
