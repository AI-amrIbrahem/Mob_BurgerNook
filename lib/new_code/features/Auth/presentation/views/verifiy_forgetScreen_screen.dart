
import 'package:burgernook/new_code/features/Auth/presentation/controllers/forget_controller.dart';
import 'package:burgernook/new_code/features/Auth/presentation/controllers/register_controller.dart';
import 'package:burgernook/new_code/features/Auth/presentation/views/login_screen.dart';
import 'package:burgernook/new_code/features/Auth/presentation/views/new_password_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../util/resources/ColorsUtils.dart';

class VerifyForgetScreen extends StatefulWidget {

  VerifyForgetScreen();

  @override
  _VerifyForgetScreenState createState() => _VerifyForgetScreenState();
}

class _VerifyForgetScreenState extends State<VerifyForgetScreen> {

  var forgetController = Get.find<ForgetController>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(),
      ),
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'تم ارسال رمز التحقق',
                        style: TextStyle(fontSize: 30.sp),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 30.h,
                  ),
                  PinCodeTextField(
                    length: 6,
                    obscureText: true,
                    animationType: AnimationType.fade,
                    hintCharacter: '*',
                    obscuringCharacter: "*",

                    mainAxisAlignment: MainAxisAlignment.center,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldOuterPadding: EdgeInsets.all(8.w),
                        fieldHeight: 50.h,
                        fieldWidth: 40.w,
                        inactiveColor: Colors.grey[200],
                        activeFillColor: Colors.red,
                        activeColor: Colors.grey[200],
                        errorBorderColor: Colors.grey[200],
                        disabledColor: Colors.grey[200],
                        inactiveFillColor: Colors.grey[200]),
                    animationDuration: Duration(milliseconds: 300),
                    // backgroundColor: Colors.blue.shade50,
                    enableActiveFill: true,
                    appContext: context,
                    onChanged: (String value) {
                      forgetController.binCode.value = value;
                    },
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    child: MaterialButton(
                      onPressed: (){

                        if(forgetController.binCode.value.length==6){
                          forgetController.sendVerifiyCode(forgetController.binCode.value).then((value) {
                            if(value){
                              Get.to(NewPasswordScreen());
                            }else{
                              print('amr not true');
                            }
                          });
                        }
                      },
                      color: AppColors.accentColor,
                      child:Text( 'التالي',style: TextStyle(color: AppColors.White),),
                      height: 48.h,
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(' لم يتم الاستلام؟ '),
                      InkWell(
                        onTap: () {
                          Get.back();
                          // Get.offAll(Register());
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (ctx) => Register()));
                        },
                        child: Text(
                          'أضغط هنا',
                          style: TextStyle(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}