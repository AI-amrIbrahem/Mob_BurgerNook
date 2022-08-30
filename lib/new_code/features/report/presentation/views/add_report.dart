import 'package:burgernook/new_code/features/report/presentation/controllers/report_controller.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../util/resources/validate.dart';

class AddReportViewScreen extends StatefulWidget {
  @override
  AaddReportScreenScreeState createState() => AaddReportScreenScreeState();
}

class AaddReportScreenScreeState extends State<AddReportViewScreen> {

  var reportController = Get.find<ReportController>();

var globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode? AppColors.darkColor:AppColors.mainColor,
        title: Text("Make a complaint".tr),
      ),
      body: Form(
        key: globalKey,
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 50),
              child: TextFormField(
                validator: AppValidator.isValidReport,
                controller: reportController.reportController,
                maxLines: 20,
                maxLength: 900,
                minLines: 10,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  prefixIcon: Icon(Icons.report),
                  labelText: 'Explain the complaint, please'.tr,
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 18.0),
              child: MaterialButton(color: AppColors.accentColor,onPressed: (){
                if(globalKey.currentState!.validate()){
                  reportController.sendReport(context: context,reportText: reportController.reportController.text);
                }
              },child: Text('Make a complaint'.tr,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp),
              ),height: 35.h,),
            ),
          ],
        ),
      ),
    );
  }

}
