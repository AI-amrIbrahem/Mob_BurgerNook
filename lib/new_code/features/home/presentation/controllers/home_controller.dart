import 'package:burgernook/new_code/features/Auth/domain/use_case/deactive.dart';
import 'package:burgernook/new_code/features/home/data/data_source/home_data_source.dart';
import 'package:burgernook/new_code/features/home/domain/use_case/get_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../util/errors/failures.dart';
import '../../../../util/network/network_info.dart';
import '../../../../util/widgets/snackbar_widget.dart';
import '../../../Auth/data/data_source/auth_data_sourcs.dart';
import '../../../Auth/data/repo/auth_repo_imp.dart';
import '../../data/models/category_model.dart';
import '../../data/repo/home_repo_imp.dart';
import '../../domain/entity/slider_entity.dart';
import '../../domain/use_case/get_categories.dart';

class HomeController extends GetxController {
  List<SliderHomeModel> sliders = [];

  RxBool isLading = true.obs;

  RxBool isSliderLoading = true.obs;

  RxBool isCategoryLoading = true.obs;

  List<CategoryModel> categories = [];

  double widthBasket = 0;
  Color colorBasket = Colors.orange;

  getSlider() {
    GetSliderUseCase(
            repoImp: HomeRepoImp(
                homeDataSource: HomeDataSource(),
                networkInfo: NetworkInfoImp(
                    connectionChecker: InternetConnectionChecker())))
        .call()
        .then((value) {
      value.fold((l) {
        if (l is OffLineFailure) {
          failSnackBar('لا يوجد اتصال بالانترنت', 'برجاء الاتصال اولا');
        } else if (l is WrongDataFailure) {
          failSnackBar('البيانات خاظئة', 'من فضلك ادخل بيانات صحيحة');
        } else if (l is ServerFailure) {
          failSnackBar(
              'هناك مشكلة في السيرفر ', 'برجاء التواصل مع خدمة العملاء');
        }
      }, (r) {
        sliders = r;
        isSliderLoading.value = false;
        print('getSlider work');
        //update();
      });
    });
  }

  getCategories() {
    GetCategoriesUseCase(
        repoImp: HomeRepoImp(
            homeDataSource: HomeDataSource(),
            networkInfo: NetworkInfoImp(
                connectionChecker: InternetConnectionChecker())))
        .call()
        .then((value) {
      value.fold((l) {
        if (l is OffLineFailure) {
          failSnackBar('لا يوجد اتصال بالانترنت', 'برجاء الاتصال اولا');
        } else if (l is WrongDataFailure) {
          failSnackBar('البيانات خاظئة', 'من فضلك ادخل بيانات صحيحة');
        } else if (l is ServerFailure) {
          failSnackBar(
              'هناك مشكلة في السيرفر ', 'برجاء التواصل مع خدمة العملاء');
        }
      }, (r) {
        categories = r;
        isLading.value = false;
        print('get Categories work');
        // update();
      });
    });
  }
  @override
  void onInit() {
    refresh();
    super.onInit();
  }

  void refresh(){
    getSlider();
    getCategories();
  }



  Future<bool> deactive({required String user_id,required BuildContext context}) async{
    showLoadingDialog(context);

    bool isDeactive = false;
    await DeactiveUseCase(
        repoImp: AuthRepoImp(
            authDataSource: AuthDataSource(),
            networkInfo: NetworkInfoImp(
                connectionChecker: InternetConnectionChecker())))
        .call(user_id: user_id)
        .then((value) {
      dismissLoadingDialog(context);
      value.fold((l) {
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
        isDeactive = false;

      }, (r) async{
        successSnackBar('تم اغلاق الحساب', 'تم التغير');

        isDeactive = true;
        // Get.offUntil( MaterialPageRoute(builder: (context) => LoginViewScreen()), (Route<dynamic> route) => false);
      });
    });
    return isDeactive;
  }
}