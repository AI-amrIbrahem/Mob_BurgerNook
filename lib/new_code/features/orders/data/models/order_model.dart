
import 'package:burgernook/new_code/features/Auth/data/models/user_model.dart';
import 'package:burgernook/new_code/features/Auth/presentation/controllers/login_controller.dart';
import 'package:burgernook/new_code/features/address/data/models/address_model.dart';
import 'package:burgernook/new_code/features/basket/data/models/order_details_model.dart';
import 'package:http/http.dart' as http;

class OrderModel {
  String id;
  String userId;
  String addressId;
  String p_total;
  String p_tax;
  String tax;
  String p_total_w_tax;
  String p_delivery;
  String p_invoice;
  String coupon;
  List<OrderDetailsModel> orderDetailsList=[];
  String createdAt;
  String date;
  String time;
  String error;
  String assignedId;
  UserModel? assignedUser;
  UserModel? user = UserModel();
  AddressModel? address;
  String orderType;
  String paymentType;

  /// [status] == 0 >>>> new
  /// [status] == 1 >>>> notDelivered
  /// [status] == 2 >>>> received
  String? status;



  OrderModel({
    this.id = '',
    this.orderDetailsList = const[],
    this.userId = '',
    this.addressId = '',
    this.p_total = '',
    this.p_tax = '',
    this.tax = '',
    this.p_total_w_tax = '',
    this.p_delivery = '',
    this.p_invoice = '',
    this.status,
    this.createdAt = '',
    this.error = '',
    this.date = '',
    this.time = '',
    this.user,
    this.assignedId = '',
    this.address,
    this.assignedUser,
    this.orderType = "توصيل",
    this.paymentType = "كاش",
    this.coupon=''
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['order_id']??'',
      userId: json['user_id']??'',
      addressId: json['address_id']??'',
      p_total: json['p_total']??'',
      p_tax: json['p_tax']??'',
      tax: json['tax']??'',
      p_total_w_tax: json['p_total_w_tax']??'',
      p_delivery: json['p_delivery']??'',
      p_invoice: json['p_invoice']??'',
      status: json['status']??'',
      createdAt: json['created_at']??'',
      date: json['date']??'',
      time: json['time']??'',
      assignedId: json['assigned_id']??'',
      assignedUser: UserModel.fromJson(json['assigned_user']),
      user: UserModel.fromJson(json),
      address: AddressModel.fromJson(json['address']),
      orderType: json['order_type']??'',
      paymentType: json['payment_type']??'',
    );
  }

  toMap() {
    Map<String, dynamic> map = {
      'user_id': userModelGlobal.id,
      'address_id': this.addressId,
      'p_total': this.p_total,
      'p_tax': this.p_tax,
      'tax': this.tax,
      'p_total_w_tax': this.p_total_w_tax,
      'p_delivery': this.p_delivery,
      'p_invoice': this.p_invoice,
      'order_type': this.orderType,
      'payment_type': this.paymentType,
      "coupon": this.coupon
    };
    return map;
  }

}
