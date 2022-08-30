import 'package:burgernook/new_code/features/Auth/presentation/controllers/register_controller.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../util/resources/validate.dart';

class RegisterViewScreen extends StatefulWidget {
  @override
  _RegisterViewScreenState createState() => _RegisterViewScreenState();
}

class _RegisterViewScreenState extends State<RegisterViewScreen> {
  bool obscureTextValue = true;


  var registerController = Get.put(RegisterController());

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.White,
      body: SafeArea(
        child: Container(
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
                        color:Get.isDarkMode? AppColors.White:AppColors.accentColor1,
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
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 10.h, right: 10.w),
                          child: Text(
                            "Register a new user?".tr,
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          // color: Colors.white,
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, bottom: 20.h),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextFormField(
                                  controller: registerController.nameController,
                                  validator: AppValidator.isValidName,
                                  style: TextStyle(
                                    fontFamily: "",
                                  ),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      labelText: "Enter Full name".tr,
                                      labelStyle: TextStyle(
                                        fontFamily: "GE_Dinar_One_Light",
                                      )),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                TextFormField(
                                  controller:
                                  registerController.emailController,
                                  validator: AppValidator.isValidEmail,
                                  style: TextStyle(
                                    fontFamily: "",
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      labelText: "Enter the email".tr,
                                      labelStyle: TextStyle(
                                        fontFamily: "GE_Dinar_One_Light",
                                      )),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                TextFormField(
                                  controller:
                                  registerController.phoneController,
                                  validator: AppValidator.isValidphone,
                                  style: TextStyle(
                                    //   fontFamily: "",
                                  ),
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      suffixStyle: TextStyle(fontFamily: ""),
                                      suffixIcon: CountryPickerDropdown(
                                        initialValue: 'SA',
                                        itemBuilder: (c) => Container(
                                          padding: EdgeInsets.only(left: 10.w),
                                          child: Text(c.phoneCode),
                                        ),
                                        isExpanded: false,
                                        itemFilter: (c) => true,
                                        priorityList: [
                                          CountryPickerUtils
                                              .getCountryByIsoCode('SA'),
                                          CountryPickerUtils
                                              .getCountryByIsoCode('EG'),
                                        ],
                                        sortComparator:
                                            (Country a, Country b) =>
                                            a.isoCode.compareTo(b.isoCode),
                                        onValuePicked: (Country country) {
                                          registerController.phoneNumberCountryCode.value = "+" + country.phoneCode;

                                          //    countryCodeProvider.setCountry("+" + country.phoneCode);
                                        },
                                      ),
                                      prefixIcon: InkWell(
                                        onTap: () {
                                          setState(() {
                                            obscureTextValue =
                                            !obscureTextValue;
                                          });
                                        },
                                        child: Icon(
                                          Icons.phone_android,
                                        ),
                                      ),
                                      labelText: "Enter a phone number".tr,
                                      //'ادخل رقم الهاتف',
                                      labelStyle: TextStyle(
                                        fontFamily: "GE_Dinar_One_Light",
                                      )),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                TextFormField(
                                  controller:
                                  registerController.passwordController,
                                  validator: AppValidator.isValidPassword,
                                  style: TextStyle(
                                    fontFamily: "",
                                  ),
                                  obscureText: obscureTextValue,
                                  decoration: InputDecoration(
                                      prefixIcon: InkWell(
                                        onTap: () {
                                          setState(() {
                                            obscureTextValue =
                                            !obscureTextValue;
                                          });
                                        },
                                        child: obscureTextValue
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility),
                                      ),
                                      labelText: "password".tr,
                                      //'كلمة المرور',
                                      labelStyle: TextStyle(
                                        fontFamily: "GE_Dinar_One_Light",
                                      )),
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      registerController.verifyScreen(phone:registerController
                                          .phoneController.text , context: context);
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
                                      "Register".tr,
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