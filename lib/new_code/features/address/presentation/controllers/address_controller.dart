import 'package:burgernook/new_code/features/address/data/data_source/address_data_source.dart';
import 'package:burgernook/new_code/features/address/data/models/address_model.dart';
import 'package:burgernook/new_code/features/address/data/repo/address_repo_imp.dart';
import 'package:burgernook/new_code/features/address/domain/use_case/set_address_use_case.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:geocoding/geocoding.dart';
import '../../../../util/errors/failures.dart';
import '../../../../util/helper/location_helper.dart';
import '../../../../util/network/network_info.dart';
import '../../../../util/widgets/snackbar_widget.dart';
import '../../../Auth/presentation/controllers/login_controller.dart';
import '../../domain/use_case/get_address_use_case.dart';

class AddressController extends GetxController {
  AddressModel selectAddress = AddressModel();
  List<AddressModel> addressList = [];

  var nameAddressController = TextEditingController();
  var detailsAddressController = TextEditingController();
  String chooseAddress = "";

  var selectDropAddress = AddressModel().obs;

  void getLocation(context) async {
    showLoadingDialog(context);
    Position v = await LocationHelper.determinePosition();
    print('Position');

    print(v);
    findAddresses(latitude: v.latitude, longitude: v.longitude).then((value) {
      print('a3');
      selectAddress.addressInMap = value;
      selectAddress.latitude = v.latitude.toString();
      selectAddress.longitude = v.longitude.toString();
      dismissLoadingDialog(context);
      update();
    });
  }


  Future<String> findAddresses(
      {required double latitude, required double longitude}) async {
    try {
      List<Placemark> placeMark =
          await placemarkFromCoordinates(latitude, longitude);

      // this is not work because data base field with limit size
      //return placeMark.first.street ?? '';
      return placeMark.first.name ?? '';

    } catch (e) {
      //return [];
      return '';
    }
  }

  bool isLoading = true;
  getAddress({required String userId}) {
    // showLoadingDialog(context);
    addressList = [];

    if(userId != '0' && addressList.isEmpty){
      print('address 2');
      GetAddressUseCase(
          addressDataSource: AddressRepoImp(
              addressDataSource: AddressDataSource(),
              networkInfo: NetworkInfoImp(
                  connectionChecker: InternetConnectionChecker())))
          .call(userId: userId)
          .then((value) {
        // dismissLoadingDialog(context);
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
        }, (address) async {
          addressList = address;
          isLoading = false;
          print('get address success');
          update();
          selectDropAddress.value=addressList.first;
        });
      });
    }
  }

  setAddress({required AddressModel addressModel,context}) {

     bool isHave = false;
     selectAddress.addressTitle = nameAddressController.text.toString();
     selectAddress.address = detailsAddressController.text.toString();


     addressList.map((element) {
       print(element.addressTitle);
       if(element.addressTitle == selectAddress.addressTitle){
         // print('${element.addressTitle } ${selectAddress.addressTitle}');
         isHave = true ;
       }
     });
     if(addressModel.addressInMap.isNotEmpty){
       if(!isHave){
         showLoadingDialog(context);

         SetAddressUseCase(
             addressDataSource: AddressRepoImp(
                 addressDataSource: AddressDataSource(),
                 networkInfo: NetworkInfoImp(
                     connectionChecker: InternetConnectionChecker())))
             .call(addressModel: addressModel)
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
           }, (isTrue) async {
             if(isTrue){
               // selectAddress.addressTitle = nameAddressController.text.toString();
               // selectAddress.address = detailsAddressController.text.toString();
               // addressList.add(selectAddress);
               isLoading = true;
               update();
               Get.back();
               getAddress(userId: userModelGlobal.id);
               successSnackBar('لقد تمت الاضافة','تم اضافت العنوان');
               // selectDropAddress.value = selectAddress ;
             }
           });
         });
       }else{
         failSnackBar(
             'برجاء اختيار اسم عنوان اخر', 'مكرر');
       }
     }else{
       failSnackBar(
           'حدد موقعك', 'مكرر');
     }
  }

}
