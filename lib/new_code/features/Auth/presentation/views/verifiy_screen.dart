import 'package:burgernook/new_code/features/Auth/presentation/controllers/register_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../util/resources/ColorsUtils.dart';

class VerifyScreen extends StatefulWidget {

  VerifyScreen();

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {

  var registerController = Get.find<RegisterController>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'تم ارسال رمز التحقق',
                  style: TextStyle(fontSize: 30.sp),
                ),
                SizedBox(height: 20.h,),
                Text(
                  'تم ارسال رمز التاكيد الي ${registerController.phoneController.text}',
                  style: TextStyle(fontSize: 16.sp,color: AppColors.subText),
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
                  selectedColor: Colors.red,
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
                registerController.binCode.value = value;
              },
            ),
            SizedBox(
              height: 40.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              child: MaterialButton(
                onPressed: (){
                  print('verifiyController.binCode.value${registerController.binCode.value}');
                  print('verifiyController.verifyCode${registerController.verifyCode}');
                  // registerController.register(
                  //     userName: registerController
                  //         .nameController.text,
                  //     email: registerController
                  //         .emailController.text,
                  //     password: registerController
                  //         .passwordController.text,
                  //     phone: registerController
                  //         .phoneController.text,context: context);
                  if(registerController.binCode.value.length==6){
                    registerController.sendVerifiyCode(registerController.binCode.value).then((value) {
                      if(value){
                        registerController.register(
                            userName: registerController
                                .nameController.text,
                            email: registerController
                                .emailController.text,
                            password: registerController
                                .passwordController.text,
                            phone: registerController
                                .phoneController.text,context: context);
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
      )
    );
  }

}