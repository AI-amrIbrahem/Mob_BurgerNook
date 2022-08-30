import 'package:auto_size_text/auto_size_text.dart';
import 'package:burgernook/new_code/features/delivery_screen/presentation/views/delivery_screen.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:burgernook/new_code/util/resources/Constants.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../util/resources/PreferenceManger.dart';
import '../../Auth/presentation/controllers/login_controller.dart';
import '../../home/presentation/views/home_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPage = 0;
  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Container(
              height: 450.h,
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemBuilder: (context, index) {
                  return PageViewItem(
                      title: AppConstants.onBoardingList[index].title,
                      lottieItem: AppConstants.onBoardingList[index].lottie,
                      subTitle: AppConstants.onBoardingList[index].subTitle);
                },
                itemCount: AppConstants.onBoardingList.length,
              ),
            ),
            Spacer(),
            DotsIndicator(
              dotsCount: AppConstants.onBoardingList.length,
              position: double.parse(currentPage.toString()),
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: Size.square(9.0.w),
                activeSize: Size(18.0.w, 9.0.h),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0.r)),
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50.h,
                      child: MaterialButton(
                        color: AppColors.mainColor,
                        onPressed: () {
                          setState(() {
                            if (currentPage <
                                AppConstants.onBoardingList.length - 1) {
                              currentPage++;
                              pageController.animateToPage(currentPage,
                                  duration: Duration(seconds: 1),
                                  curve: Curves.easeIn);
                            } else {
                              PreferenceManager.saveBoolean(AppConstants.isFirst,true);
                              if (isUser)
                                Get.offAll(HomeScreen());
                              else if (isDelivery)
                                Get.offAll(DeliveryViewScreen());
                              else
                                Get.offAll(HomeScreen());
                              //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SelectScreen(),));
                            }
                          });
                        },
                        child: Text(
                          AppConstants.onBoardingList.length - 1 == currentPage
                              ? 'إنهاء'.tr
                              : 'التالي'.tr,
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.White),
                        ),
                      ),
                    ),
                  ),
                ),
                AppConstants.onBoardingList.length - 1 == currentPage
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50.h,
                          child: MaterialButton(
                            color: AppColors.accentColor,
                            onPressed: () {
                              PreferenceManager.saveBoolean(AppConstants.isFirst,true);
                              if (isUser)
                                Get.offAll(HomeScreen());
                              else if (isDelivery)
                                Get.offAll(DeliveryViewScreen());
                              else
                                Get.offAll(HomeScreen());
                              //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SelectScreen(),));
                            },
                            child: Text(
                              'تخطي'.tr,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.White,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            )
          ],
        ),
      )),
    );
  }

  Widget PageViewItem(
      {required String lottieItem,
      required String title,
      required String subTitle}) {
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Container(height: 360.h, child: Lottie.asset(lottieItem)),
        Spacer(),
        AutoSizeText(
          title,
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              ),
          maxLines: 1,
        ),
        SizedBox(
          height: 10.h,
        ),
        AutoSizeText(
          subTitle,
          style: TextStyle(fontSize: 16.sp,),
          maxLines: 1,
        ),

      ],
    );
  }
}
