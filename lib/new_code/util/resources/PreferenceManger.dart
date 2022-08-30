import 'package:burgernook/new_code/features/Auth/data/models/user_model.dart';
import 'package:burgernook/new_code/features/Auth/presentation/controllers/login_controller.dart';
import 'package:burgernook/new_code/util/resources/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static PreferenceManager? instance;
  static late SharedPreferences sharedPreferences1;
  static init()async{
    sharedPreferences1 =await SharedPreferences.getInstance();
  }

  // factory PreferenceManager(){
  //   if(instance == null){
  //     instance = PreferenceManager();
  //   }
  //     return instance!;
  // }


  static void saveString(String key, String value) async {
    var prefs = await sharedPreferences1;
    prefs.setString(key, value);
  }

  static void saveBoolean(String key, bool value) async {
    var prefs = await sharedPreferences1;
    prefs.setBool(key, value);
  }

  static void saveInt(String key, int value) async {
    var prefs = await sharedPreferences1;
    prefs.setInt(key, value);
  }

  static void saveDouble(String key, double value) async {
    var prefs = await sharedPreferences1;
    prefs.setDouble(key, value);
  }

  static void remove(String key) async {
    var prefs = await sharedPreferences1;
    prefs.remove(key);
  }

  static Future<String?> getString(String key) async {
    var prefs = await sharedPreferences1;
    if (prefs.containsKey(key)) return prefs.getString(key);
    return "";
  }

  static Future<bool?> getBoolean(String key) async {
    var prefs = await sharedPreferences1;
    if (prefs.containsKey(key))
      return prefs.getBool(key);
    else
      return false;
  }

  static Future<bool?> getIsArabic() async {
    var prefs = await sharedPreferences1;
    if (prefs.containsKey(AppConstants.isArabic))
      return prefs.getBool(AppConstants.isArabic);
    else
      return true;
  }

  static setIsArabic(bool isArabic) async {
    var prefs = await sharedPreferences1;
    prefs.setBool(AppConstants.isArabic,isArabic);
  }

  static Future<int> getInt(String key) async {
    var prefs = await sharedPreferences1;
    return prefs.getInt(key) ?? -1;
  }

  static Future<double> getDouble(String key) async {
    var prefs = await sharedPreferences1;
    return prefs.getDouble(key) ?? -1;
  }
  //
  // static PreferenceManager? getInstance() {
  //   if (instance == null)
  //     instance = PreferenceManager();
  //
  //   return PreferenceManager();
  // }

  static Future<bool> setStringList(List<String> list, String key) async {
    var prefs = await sharedPreferences1;

    return  prefs.setStringList(key,list);
  }

  static Future<List<String>> getStringList(String key) async {
    var prefs = await sharedPreferences1;

    return prefs.getStringList(key) ?? [];
  }

  static Future<UserModel> setUser({required UserModel user}) async {
    var sharedPreferences = await sharedPreferences1;
    sharedPreferences.setString('id', user.id);
    sharedPreferences.setString('fullName', user.fullName);
    sharedPreferences.setString('phoneNumber', user.phoneNumber);
    sharedPreferences.setString('email', user.email);
    sharedPreferences.setString('employeeJob', user.employeeJob);
    sharedPreferences.setBool('isLogin', true);
    print('user.employeeJob ${user.employeeJob}');

    switch (user.employeeJob) {
      case "1":
        print(">>>>>>>>>>>>>>>>isOwner");
        sharedPreferences.setBool('isOwner', true);
        sharedPreferences.setBool('isEmployee', false);
        sharedPreferences.setBool('isDelivery', false);
        sharedPreferences.setBool('isUser', false);
        break;
      case "2":
        print(">>>>>>>>>>>>>>>>isEmployee");
        sharedPreferences.setBool('isEmployee', true);
        sharedPreferences.setBool('isOwner', false);
        sharedPreferences.setBool('isDelivery', false);
        sharedPreferences.setBool('isUser', false);
        break;
      case "4":
        print(">>>>>>>>>>>>>>>>isDelivery");
        sharedPreferences.setBool('isDelivery', true);
        sharedPreferences.setBool('isEmployee', false);
        sharedPreferences.setBool('isOwner', false);
        sharedPreferences.setBool('isUser', false);
        break;
      case "5":
        print(">>>>>>>>>>>>>>>>isUser");
        sharedPreferences.setBool('isUser', true);
        sharedPreferences.setBool('isDelivery', false);
        sharedPreferences.setBool('isEmployee', false);
        sharedPreferences.setBool('isOwner', false);
        break;
    }
    return user;
  }

  static Future<UserModel> getUser() async {
    UserModel user = UserModel();
    SharedPreferences sharedPreferences = await sharedPreferences1;
    user.id = sharedPreferences.getString('id')??'';
    user.fullName = sharedPreferences.getString('fullName')??'';
    user.phoneNumber = sharedPreferences.getString('phoneNumber')??'';
    user.email = sharedPreferences.getString('email')??'';
    user.employeeJob = sharedPreferences.getString('employeeJob')??'';
    return user;
  }

  static Future<bool> isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isLogin') == null
        ? false
        : sharedPreferences.getBool('isLogin')!;
  }

  static Future<bool> setLogout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('isLogin', false);
    await sharedPreferences.setBool('isDelivery', false);
    await sharedPreferences.setBool('isEmployee', false);
    await sharedPreferences.setBool('isOwner', false);
    await sharedPreferences.setBool('isUser', false);
    return true;
  }

  static Future<bool> isEmployee() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isEmployee') == null
        ? false
        : sharedPreferences.getBool('isEmployee')!;
  }

  static Future<bool> isOwner() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isOwner') == null
        ? false
        : sharedPreferences.getBool('isOwner')!;
  }

  static Future<bool> isUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isUser') == null
        ? false
        : sharedPreferences.getBool('isUser')!;
  }
  static Future<bool> isDelivery() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isDelivery') == null
        ? false
        : sharedPreferences.getBool('isDelivery')!;
  }
}
check() async {
  isLogin = await PreferenceManager.isLogin();
  isEmployee = await PreferenceManager.isEmployee();
  isOwner = await PreferenceManager.isOwner();
  isDelivery = await PreferenceManager.isDelivery();
  isUser = await PreferenceManager.isUser();
  if (isLogin) {
    print('isLogin : $isLogin');
    userModelGlobal = await PreferenceManager.getUser();
  }
  // print(isLogin);
}
