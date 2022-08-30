import 'package:burgernook/new_code/features/Auth/presentation/controllers/login_controller.dart';
import 'package:burgernook/new_code/features/Auth/presentation/views/foget_password.dart';
import 'package:burgernook/new_code/features/Auth/presentation/views/register_screen.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:burgernook/new_code/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../util/resources/validate.dart';

class LoginViewScreen extends StatefulWidget {
  @override
  _LoginViewScreenState createState() => _LoginViewScreenState();
}

class _LoginViewScreenState extends State<LoginViewScreen> {
  var loginController = Get.put(LoginController());
  var globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.White,
      backgroundColor: Get.isDarkMode? AppColors.darkColor:Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color:Get.isDarkMode? Colors.white: AppColors.accentColor1,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.h, right: 10.w),
                    child: Text(
                      "sign in".tr,
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Container(
                // color: Colors.white,
                color: Get.isDarkMode? AppColors.darkColor:Colors.white,

                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Form(
                  key: globalKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 150.h,
                        child: Logo(),
                      ),
                      TextFormField(
                        validator: AppValidator.isValidEmpty,
                        controller: loginController.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: "Enter your email or phone number".tr,
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
                        obscureText: loginController.obscureTextValue,
                        validator: AppValidator.isValidEmpty,
                        controller: loginController.passwordController,
                        style: TextStyle(
                          fontFamily: "",
                        ),
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                loginController.obscureTextValue =
                                !loginController.obscureTextValue;
                              });
                            },
                            child: loginController.obscureTextValue
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                          labelText: "password".tr,
                          labelStyle: TextStyle(

                            fontFamily: "GE_Dinar_One_Light",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      InkWell(
                        onTap: () {
                          if(globalKey.currentState!.validate()){
                            loginController.makeLogin(
                                email: loginController.emailController.text,
                                password: loginController.passwordController.text,context: context);
                          }
                        },
                        child: Container(
                          width: 300.w,
                          height: 50.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.accentColor,
                          ),
                          child: Text(
                            "sign in".tr,
                            //  'تسجيل الدخول',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: InkWell(
                          onTap: () {
                            Get.to(ForgotPasswordScreen());
                          },
                          child: Text(
                            "Forgot your password ?".tr,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily:Get.isDarkMode? '':"GE_Dinar_One_Light",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      InkWell(
                          onTap: () {
                            Get.to(RegisterViewScreen());
                          },
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "account".tr,
                                  style: TextStyle(
                                      color:Get.isDarkMode?AppColors.White: AppColors.titleText,
                                      // color: AppColors.titleText,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "Register a new user?".tr,
                                  style: TextStyle(
                                    color:Get.isDarkMode?AppColors.mainColor: AppColors.accentColor,
                                    fontSize: 16.sp,
                                  ))
                            ]),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}