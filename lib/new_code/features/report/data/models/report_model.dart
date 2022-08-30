import 'package:burgernook/new_code/features/Auth/data/models/user_model.dart';

class ReportModel {
  String id;
  String desc;
  String createdAt;
  UserModel? user =  UserModel();
  ReportModel({
    this.id = '',
    this.desc = '',
    this.createdAt = '',
    this.user ,
  });

  factory ReportModel.fromJson(Map json) {
    return ReportModel(
      id: json['report_id'],
      desc: json['message'],
      createdAt: json['created_at'],
      user: UserModel.fromJson(json),
    );
  }

}
