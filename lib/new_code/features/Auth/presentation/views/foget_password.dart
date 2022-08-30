import 'package:burgernook/new_code/features/Auth/presentation/controllers/forget_controller.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../util/resources/validate.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  var forgetController = Get.put(ForgetController());
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.White,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color:Get.isDarkMode? AppColors.White: AppColors.accentColor1,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 10.h, right: 10.w),
                        child: Text(
                          "Reset password".tr,
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        // color: Colors.white,
                        padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: 10.h,
                              ),
                              TextFormField(
                                controller: forgetController.emailController,
                                validator: AppValidator.isValidEmpty,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    labelText: "Enter your email or phone number".tr,
                                    //'ادخل البريد الاكتروني او رقم الهاتف',
                                    labelStyle: TextStyle(
                                      fontFamily: "GE_Dinar_One_Light",
                                    )),
                                style: TextStyle(
                                  fontFamily: "",
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              TextFormField(
                                controller: forgetController.phoneController,
                                validator: AppValidator.isValidEmpty,
                                style: TextStyle(
                                  fontFamily: "",
                                ),
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    prefixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          forgetController.obscureTextValue = !forgetController.obscureTextValue;
                                        });
                                      },
                                      child: Icon(
                                        Icons.phone_android,
                                      ),
                                    ),
                                    labelText:
                                    "Enter a phone number".tr, //'ادخل رقم الهاتف',
                                    labelStyle: TextStyle(
                                      fontFamily: "GE_Dinar_One_Light",
                                    )),

                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              InkWell(
                                onTap: (){

                                  if (formKey.currentState!.validate()) {
                                    forgetController.getUserId(email: forgetController.emailController.text, phone: forgetController.phoneController.text, context: context);
                                    // forgetController.verifyScreen(phone:forgetController
                                    //     .phoneController.text , context: context);
                                  }
                                },
                                child: Container(
                                  height: 40.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppColors.accentColor,
                                  ),
                                  child: Text(
                                    "Submit".tr,
                                    // 'سجل الان',
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
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}