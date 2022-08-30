import 'package:burgernook/new_code/features/Auth/presentation/controllers/login_controller.dart';

class AddressModel {
  String id;
  String userId;
  String addressTitle;
  String address;
  String addressInMap;
  String latitude;
  String longitude;
  String error;

  AddressModel({
    this.id = '',
    this.userId = '',
    this.addressTitle = '',
    this.address = '',
    this.addressInMap = '',
    this.latitude = '',
    this.longitude = '',
    this.error = '',
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['address_id']??'',
      userId: json['user_id']??'',
      addressTitle: json['address_title']??'',
      address: json['address']??'',
      addressInMap: json['address_in_map']??'',
      latitude: json['latitude']??'',
      longitude: json['longitude']??'',
    );
  }

  toMap() {
    print('Latitude:$latitude');
    print('--------------------------');
    print('Longitude:$longitude');
    return {
      "user_id": userModelGlobal.id,
      "address_title": this.addressTitle,
      "address": this.address,
      "address_in_map": this.addressInMap,
      "latitude": this.latitude,
      "longitude": this.longitude,
    };
  }

}
