import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ar_AR': {
      'hello': 'مرحبا',
    },
    'en_US': {
      'hello': 'Hello',
    },
  };
}