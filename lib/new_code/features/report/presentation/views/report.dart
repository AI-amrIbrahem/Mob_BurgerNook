import 'package:burgernook/new_code/features/report/data/models/report_model.dart';
import 'package:burgernook/new_code/features/report/presentation/controllers/report_controller.dart';
import 'package:burgernook/new_code/features/report/presentation/views/add_report.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Auth/presentation/controllers/login_controller.dart';

class ReportViewScreen extends StatefulWidget {
  @override
  _ReportScreenScreeState createState() => _ReportScreenScreeState();
}

class _ReportScreenScreeState extends State<ReportViewScreen> {
  var reportController = Get.put(ReportController())
    ..getUserReports(userId: userModelGlobal.id);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: reportController,
        builder: (_) => Scaffold(
              appBar: AppBar(
                backgroundColor: Get.isDarkMode? AppColors.darkColor:AppColors.mainColor,
                title: Text("Complaints".tr),
              ),
              body: reportController.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),
                    )
                  : ListView(
                      children: reportController.userReports
                          .map((ReportModel report) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 15.w, horizontal: 15.h),
                          padding: EdgeInsets.symmetric(
                              vertical: 5.w, horizontal: 15.h),
                          decoration: BoxDecoration(

                              color: Get.isDarkMode? AppColors.lightColor: AppColors.accentW,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.4),
                                    blurRadius: 3)
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                child: Text("${report.desc}",style: TextStyle(fontFamily: "arlrdbd",color: AppColors.titleText),),
                                alignment: Alignment.topRight,
                              ),
                              Text(
                                "${report.createdAt}",
                                style: TextStyle(fontFamily: "arlrdbd",color: AppColors.titleText),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: AppColors.accentColor,
                  onPressed: () {
                    Get.to(AddReportViewScreen());
                  },
                  child: Text(
                    'Make a complaint'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp),
                  ),
                  height: 35.h,
                ),
              ),
            ));
  }
}