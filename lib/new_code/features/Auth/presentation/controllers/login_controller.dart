import 'package:burgernook/new_code/features/Auth/data/data_source/auth_data_sourcs.dart';
import 'package:burgernook/new_code/features/Auth/data/models/user_model.dart';
import 'package:burgernook/new_code/features/Auth/data/repo/auth_repo_imp.dart';
import 'package:burgernook/new_code/features/Auth/domain/use_case/login_use_case.dart';
import 'package:burgernook/new_code/features/home/presentation/views/home_screen.dart';
import 'package:burgernook/new_code/util/resources/PreferenceManger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../util/errors/failures.dart';
import '../../../../util/network/network_info.dart';
import '../../../../util/widgets/snackbar_widget.dart';
import '../../../delivery_screen/presentation/views/delivery_screen.dart';

UserModel userModelGlobal = UserModel();
bool isLogin = false;
bool isEmployee = false;
bool isOwner = false;
bool isDelivery = false;
bool isUser = false;

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool obscureTextValue = true;

  void makeLogin({required String email, required String password,required BuildContext context}) {
    showLoadingDialog(context);
    isLogin = false;
    isEmployee = false;
    isOwner = false;
    isDelivery = false;
    isUser = false;

    LoginUseCase(
        repoImp: AuthRepoImp(
            authDataSource: AuthDataSource(),
            networkInfo: NetworkInfoImp(
                connectionChecker: InternetConnectionChecker())))
        .call(email: email, password: password)
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
        } else if (l is BlockedDataFailure) {
          failSnackBar('هذا الحساب مغلق', 'برجاء التواصل مع خدمة العملاء');
        } else if (l is NotUserOrDeliveryDataFailure) {
          failSnackBar('ليس لديك الصلاحية', 'برجاء التواصل مع خدمة العملاء');
        }
      }, (r) async{
        userModelGlobal = r;
        print('login work');
        await PreferenceManager.setUser(user: userModelGlobal);
        await loginFromHome();
        // Navigator.of(context).popUntil((route) => route.isFirst);
        if (isOwner) {
          print("user 4");

          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => OwnerScreen()));
        } else if (isDelivery) {
          print("user 3");
          Get.offAll(DeliveryViewScreen());
        } else if (isEmployee) {
          print("user 1");

          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => EmployeeScreen()));
        } else if (isUser) {
          print("user 2");
          Get.offAll(HomeScreen());
          // Get.offUntil( MaterialPageRoute(builder: (context) => HomeScreen()), (Route<dynamic> route) => false);
        }
      });
    });
  }

  loginFromHome() async {
    isLogin = await PreferenceManager.getBoolean('isLogin')??false;
    isEmployee = await PreferenceManager.getBoolean('isEmployee')??false;
    isOwner =  await PreferenceManager.getBoolean('isOwner')??false;
    isDelivery = await PreferenceManager.getBoolean('isDelivery')??false;
    isUser = await PreferenceManager.getBoolean('isUser')??false;
    if (isLogin) {
      print('isLogin : $isLogin');
      userModelGlobal = await PreferenceManager.getUser();
    }
  }

}