import 'package:burgernook/new_code/util/resources/app_assets.dart';
import 'package:get/get.dart';
import '../../features/on_boarding/data/models/on_boarding_model.dart';

class AppConstants {
  static  List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(AppAssets.boarding3,'اختار واطلب الان'.tr, 'دلواقتي تقدر تختار بكل سهولة'.tr),
    OnBoardingModel(AppAssets.boarding2,'احسن خدمة توصيل لطلباتك'.tr, 'هنشحن طلباتك بمجرد ماتاكد الطلب'.tr),
    OnBoardingModel(AppAssets.boarding1,'طلباتك لحد بابك'.tr, 'طلباتك هتوصل كاملة وبسرعة'.tr),
  ];

  static String isFirst = 'isFirst';
  static String isArabic = 'isArabic';

}