import 'dart:convert';
import 'package:burgernook/new_code/features/address/data/models/address_model.dart';
import 'package:burgernook/new_code/util/errors/exceptions.dart';
import 'package:burgernook/new_code/util/network/service.dart';
import 'package:http/http.dart' as http;


class AddressDataSource {

  Future<bool> setAddress(AddressModel addressModel) async {
    print('setAddress work');
    print('body${addressModel.toMap()}');
    http.Response response =
    await http.post(Uri.parse("${ServiceUrls.domain}/address/create.php"), body: addressModel.toMap());
    var res = json.decode(response.body);
    print('address $res');
    try{
      if (!res['error']) {
        return true;
      } else {
        return false;
      }
    }catch (error) {
      throw ServerException();
    }
  }

  Future<List<AddressModel>> getAddress(String userId) async {
    List<AddressModel> address = [];
    print('get address start');
    try{
      http.Response response = await http.post(
          Uri.parse(
              "${ServiceUrls.domain}/address/readByUserId.php"),
          body: {"user_id": userId});
      var res = json.decode(response.body);
      print(res);
      print('address work 1');
      List data = res['address'];
      for (var item in data) {
        address.add(AddressModel.fromJson(item));
      }
    }catch (error) {
      throw ServerException();
    }
    return address;
  }

}
