import 'package:burgernook/new_code/features/Auth/data/data_source/auth_data_sourcs.dart';
import 'package:burgernook/new_code/features/Auth/data/repo/auth_repo_imp.dart';
import 'package:burgernook/new_code/features/Auth/domain/use_case/get_user_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../util/errors/failures.dart';
import '../../../../util/network/network_info.dart';
import '../../../../util/widgets/snackbar_widget.dart';
import '../../domain/use_case/change_password.dart';
import '../views/login_screen.dart';
import '../views/verifiy_forgetScreen_screen.dart';


class ForgetController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool obscureTextValue = true;
  var phoneController  = TextEditingController();
  var binCode = ''.obs;
  var userId = '';

  var newpasswordController = TextEditingController();
  var newpasswordConfirmController = TextEditingController();


  verifyScreen({required String phone,required BuildContext context}){
    var phoneWithCode = phoneNumberCountryCode.value + phone;
    print('phoneWithCode$phoneWithCode');
    showLoadingDialog(context);
    sendPhoneNumber(phone,context);
  }

  getUserId({required String email ,required String phone ,required BuildContext context}) {
    showLoadingDialog(context);
    GetUserIdUseCase(
        repoImp: AuthRepoImp(
            authDataSource: AuthDataSource(),
            networkInfo: NetworkInfoImp(
                connectionChecker: InternetConnectionChecker())))
        .call(email: email, phone: phone)
        .then((value) {
      dismissLoadingDialog(context);
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
        else if (l is PhoneUsedFailure) {
          failSnackBar(
              'رقم الهاتف موجود بالفعل', 'برجاء التواصل مع خدمة العملاء');
        }
      }, (r) async{
        userId = r;
        verifyScreen(phone: phone, context: context);
      });
    });
  }


  changePassword({required String password,required String user_id,required BuildContext context}) {
    showLoadingDialog(context);
    print('passsss $password');

    ChangePasswordUseCase(
        repoImp: AuthRepoImp(
            authDataSource: AuthDataSource(),
            networkInfo: NetworkInfoImp(
                connectionChecker: InternetConnectionChecker())))
        .call(user_id: user_id, password: password)
        .then((value) {
      dismissLoadingDialog(context);
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
        else if (l is PhoneUsedFailure) {
          failSnackBar(
              'رقم الهاتف موجود بالفعل', 'برجاء التواصل مع خدمة العملاء');
        }
      }, (r) async{

        Get.offUntil( MaterialPageRoute(builder: (context) => LoginViewScreen()), (Route<dynamic> route) => false);
        successSnackBar('لقد تم التغير', 'تم التغير');
      });
    });
  }

  var phoneNumberCountryCode = '+966'.obs;
  var verifyCode = '';

  void sendPhoneNumber(String phone,context){
    var phoneWithCode = phoneNumberCountryCode.value+phone;
    print('$phoneWithCode');
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '$phoneWithCode',
      timeout: const Duration(seconds: 15),
      verificationCompleted: verifiyCompleted,
      verificationFailed:(error)=> verifiyFailed(error,context),
      codeSent:(code,x)=> codeSent(code,x,context),
      codeAutoRetrievalTimeout: (String verificationId) {},
    ).then((value) {
      print('amr');
    }).catchError((error){

    });
  }

  void verifiyCompleted(PhoneAuthCredential phoneAuthCredential) {
    print('verifiy completed');
    // signIn(phoneAuthCredential);
  }

  void verifiyFailed(FirebaseAuthException error,BuildContext context) {
    print('verifiy failed');
    dismissLoadingDialog(context);
    failSnackBar(error.toString(), '');
  }

  void codeSent(String verificationId, int? forceResendingToken,BuildContext context) {
    print('code sent$verificationId');
    verifyCode = verificationId;
    dismissLoadingDialog(context);
    Get.to(VerifyForgetScreen());
  }

  Future<bool> sendVerifiyCode(String otp)async{
    PhoneAuthCredential credential =await PhoneAuthProvider.credential(verificationId: verifyCode, smsCode: otp);
    return await signIn(credential);
  }

  Future<bool> signIn(PhoneAuthCredential credential) async{
    bool x = false;
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      print('amr h1');
      x =  true;
    }).catchError((error){
      print('error$error');
      Get.snackbar('هناك خطاء', 'ألرجاء المحاولة مرة اخري');
    });
    print('amr h2');
    return x;
  }


}