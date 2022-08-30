import 'package:burgernook/new_code/features/address/data/models/address_model.dart';
import 'package:burgernook/new_code/features/basket/presentation/controllers/basket_controller.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../Auth/presentation/controllers/login_controller.dart';
import '../../../../Auth/presentation/views/login_screen.dart';
import '../../../../address/presentation/controllers/address_controller.dart';
import '../../../../address/presentation/views/add_address_screen.dart';

class Address_widget extends StatefulWidget {
  const Address_widget(
      {Key? key,
      required this.addressController,
      required this.basketController})
      : super(key: key);

  final BasketController basketController;
  final AddressController addressController;

  @override
  State<Address_widget> createState() => _Address_widgetState();
}

class _Address_widgetState extends State<Address_widget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.h),
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Get.isDarkMode? AppColors.accentColor6:AppColors.accentW,
          borderRadius: BorderRadius.all(
            Radius.circular(5.r),
          ),
        ),
        child: GetBuilder<AddressController>(
          builder: (_) => widget.addressController.isLoading
              ? Container(
                child:userModelGlobal.id=='0'?Container():
              SizedBox(
                    width: 50.w, height: 50.h, child: Center(child: CircularProgressIndicator())),
              )
              : Column(
                  children: <Widget>[
                    widget.addressController.chooseAddress.isEmpty
                        ? Container()
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.addressController.chooseAddress,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.sp
                              ),
                            ),
                          ),
                    widget.addressController.addressList.isEmpty
                        ? Container()
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(8.0),

                            ///margin: EdgeInsets.only(right: 20, top: 0),
                            child: Text(
                              'Choose address *'.tr,
                              style: TextStyle(
                                color: AppColors.accentColor5,
                                  fontSize: 16.sp

                              ),
                            ),
                          ),
                    widget.addressController.addressList.isEmpty
                        ? Container()
                        : Obx(
                            () => Container(
                              margin: EdgeInsets.symmetric(horizontal: 14.w),
                              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                              child: DropdownButton<AddressModel>(
                                isExpanded: true,
                                value: widget
                                    .addressController.selectDropAddress.value,
                                items: widget.addressController.addressList
                                    .map((AddressModel value) {
                                  return new DropdownMenuItem<AddressModel>(
                                    value: value,
                                    child: new Text(value.addressTitle,style: TextStyle(fontSize: 16.sp),),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  // widget.basketController.value =
                                  //     int.parse(value.toString());
                                  widget.addressController.selectDropAddress
                                      .value = value!;
                                },
                              ),
                            ),
                          ),
                    InkWell(
                      onTap: () {
                        if (isLogin) {
                          print('we here ');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddAddressViewScreen()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginViewScreen()));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Add an address'.tr,
                              style: TextStyle(
                                  color: AppColors.accentColor5, fontSize: 16.sp),
                            ),
                            Icon(
                              Icons.add_circle,
                              color: AppColors.accentColor5,
                              size: 16.h,
                            )
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
