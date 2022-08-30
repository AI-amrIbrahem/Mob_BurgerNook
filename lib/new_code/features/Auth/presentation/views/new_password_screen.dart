import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:burgernook/new_code/util/resources/validate.dart';
import 'package:burgernook/new_code/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/forget_controller.dart';

class NewPasswordScreen extends StatefulWidget {

  NewPasswordScreen();

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  var height;
  var width;

  var forgetController = Get.find<ForgetController>();
  var globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 150.h,
                child: Logo(),
              ),
              Container(
                // color: Colors.white,
                padding:
                 EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Form(
                  key: globalKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        controller: forgetController.newpasswordController,
                        validator: AppValidator.isValidPassword,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: "password".tr,
                            prefixIcon: Icon(Icons.lock),
                            //'ادخل البريد الاكتروني او رقم الهاتف',
                            labelStyle: TextStyle(
                              fontFamily: "GE_Dinar_One_Light",
                            )),
                        style: TextStyle(
                          fontFamily: "",
                        ),

                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormField(
                        controller: forgetController.newpasswordConfirmController,
                        validator: AppValidator.isValidPassword,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: "password confirm".tr,
                            //'ادخل البريد الاكتروني او رقم الهاتف',
                            labelStyle: TextStyle(
                              fontFamily: "GE_Dinar_One_Light",
                            )),
                        style: TextStyle(
                          fontFamily: "",
                        ),

                      ),
                      SizedBox(
                        height: height / 15,
                      ),
                      InkWell(
                        onTap: (){
                          if(globalKey.currentState!.validate()){
                            if(forgetController.newpasswordController.text.toString()==forgetController.newpasswordConfirmController.text.toString()){
                              forgetController.changePassword(password:forgetController.newpasswordController.text.toString() , user_id: forgetController.userId, context: context);
                            }
                          }
                        },
                        child: Container(
                          // width: width / 2.5,
                          height: 40.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.accentColor,
                          ),
                          child: Text(
                            'Submit'.tr,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}