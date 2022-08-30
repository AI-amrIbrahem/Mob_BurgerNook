import 'package:get/get.dart';

import '../../features/Auth/presentation/controllers/forget_controller.dart';
import '../../features/basket/presentation/controllers/basket_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BasketController(),fenix: true);
    Get.lazyPut(() => ForgetController(),fenix: true);
  }
}