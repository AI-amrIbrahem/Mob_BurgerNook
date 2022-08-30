import 'package:burgernook/new_code/features/address/presentation/controllers/address_controller.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:burgernook/new_code/util/resources/validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class AddAddressViewScreen extends StatefulWidget {
  @override
  _AddAddressViewScreenState createState() => _AddAddressViewScreenState();
}

class _AddAddressViewScreenState extends State<AddAddressViewScreen> {
  var addressController = Get.find<AddressController>();
  var globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add an address".tr, //"اضافة عنوان",
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: globalKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: addressController.nameAddressController,
                  validator: AppValidator.nameAddress,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Home, work".tr,
                    //"المنزل , العمل",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    prefixIcon: Icon(Icons.title),
                    labelText: "name of the place".tr, //'اسم المكان',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: addressController.detailsAddressController,
                  validator: AppValidator.detailsAddress,
                  minLines: 4,
                  maxLines: 6,
                  maxLength: 200,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    prefixIcon: Icon(Icons.details),
                    labelText: "Address details".tr, // 'تفاصيل العنوان',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GetBuilder<AddressController>(
                  init: addressController,
                  builder:(_)=> ListTile(
                    title: addressController.selectAddress.addressInMap.isNotEmpty
                        ? Text("${addressController.selectAddress.addressInMap}")
                        : Text(
                            "Enter the GPS location"
                                .tr, //"ادخال موقع المكان GPS",
                          ),
                    trailing: Icon(
                      Icons.location_on,
                      color: addressController.selectAddress.addressInMap.isNotEmpty
                          ? Colors.green
                          : null,
                    ),
                    onTap: () {
                      addressController.getLocation(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                InkWell(
                  onTap: (){
                    if(globalKey.currentState!.validate()){
                      print('set address');
                      addressController.selectAddress.addressTitle = addressController.nameAddressController.text.toString();
                      addressController.selectAddress.address = addressController.detailsAddressController.text.toString();
                      addressController.setAddress(addressModel: addressController.selectAddress,context: context);
                    }
                  },
                  child: Container(
                    width: Get.width / 2,
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.accentColor,
                    ),
                    child: Text(
                      "Add an address".tr,
                      //  'اضف عنوان',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
