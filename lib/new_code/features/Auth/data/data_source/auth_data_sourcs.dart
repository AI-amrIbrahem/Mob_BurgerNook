import 'dart:convert';

import 'package:burgernook/new_code/features/Auth/data/models/user_model.dart';
import 'package:burgernook/new_code/util/errors/exceptions.dart';
import 'package:burgernook/new_code/util/network/service.dart';

import 'package:http/http.dart' as http;

class AuthDataSource {
  Future<UserModel> setLogin(
      {required String userName, required String password}) async {
    late UserModel _user;
    Exception ex = ServerException();
    bool isEx = false;
    try {
      http.Response response = await http
          .post(Uri.parse("${ServiceUrls.domain}/user/login.php"), body: {
        "emailORPhoneNumber": userName,
        "password": password,
      });
      print(response.body);
      var res = json.decode(response.body);
      if (!res['error']) {
        _user = UserModel.fromJson(res['user_info']);
        if (_user.blocked == "1") {
          print('amr 123');
          ex = BlockedDataException();
          isEx = true;
        }
        print(_user.employeeJob);
        // if (_user.employeeJob == "1" || _user.employeeJob == "2") {
        //   ex =  NotUserOrDeliveryException();
        //   isEx = true;
        // }
      } else {
        ex = WrongDataException();
        isEx = true;
      }
    } catch (error) {
      throw ex;
    }
    if (isEx == true) {
      throw ex;
    }
    return _user;
  }

  Future<bool> register(
      {required String userName,
        required String email,
        required String password,
        required String phone,
        required emp_job}) async {
    var body = {
      "full_name": userName,
      "phone_number": phone,
      "email": email,
      "password": password,
      "employee_job": emp_job,
    };
    Exception ex = ServerException();
    bool isEx = false;
    print('body = $body');
    var sss = '';
    try {
      http.Response response = await http.post(
          Uri.parse("${ServiceUrls.domain}/user/register.php"),
          body: body);
      print('resposne $response');
      sss = response.body;
      print('resposne sss $sss');
      var res = json.decode(response.body);
      print('resposne $res');
      if (!res['error']) {
        print('!res[error] ${!res['error']}');
        return true;
      } else {
        if (res['message'] == 'phone') {
          isEx = true;
          ex = PhoneUsedException();
        } else {
          isEx = true;
          ex = WrongDataException();
        }
      }
    } catch (e) {
      print('ex e $e');
      throw ex;
    }
    if (isEx == true) {
      throw ex;
    }
    return false;
  }



  Future<String> getUserId({
    required String email,
    required String phone
  }) async {
    var res;
    try{
      http.Response response =
      await http.post(Uri.parse("${ServiceUrls.domain}/user/forgotPassword.php"), body: {
        "email": email,
        "phone_number": phone,
      });
      print(response.body);
      res = json.decode(response.body);
    }catch(ex){
      throw ServerException();
    }

    if (!res['error']) {
      return res['user_id'];
    } else {
      if(res['user_id']!=null){
        if(res['user_id']!='')
        return res['user_id'];
      }
      throw WrongDataException();
    }
  }

  Future<bool> myNewPassword({
    required String password,
    required String user_id,
  }) async {
    var res;
    print('body of new password is = $password   & id = $user_id');
    try{
      http.Response response =
      await http.post(Uri.parse("${ServiceUrls.domain}/user/newPassword.php"), body: {
        "password": password,
        "user_id": user_id,
      });
      res = json.decode(response.body);
    }catch(ex){
      throw ServerException();
    }
    print('res of new password $res');
    if (!res['error']) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deactive({
    required String user_id,
  }) async {
    var res;
    print('body   id = $user_id');
    try{
      http.Response response =
      await http.post(Uri.parse("${ServiceUrls.domain}/user/Blocked.php"), body: {
        "user_id": user_id,
      });
      print('response  $response');
      res = json.decode(response.body);
    }catch(ex){
      throw ServerException();
    }
    print('res deactive $res');
    if (!res['error']) {
      return true;
    } else {
      return false;
    }
  }

}