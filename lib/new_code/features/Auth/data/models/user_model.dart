
class UserModel {
  String id;
  String fullName;
  String phoneNumber;
  String email;
  String password;
  String employeeJob;
  String blocked;

  UserModel({
    this.id = '0',
    this.fullName = '',
    this.phoneNumber = '',
    this.email = '',
    this.password = '',
    this.employeeJob = '',
    this.blocked = '',
  });

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
        id: json['user_id']??'',
        fullName: json['full_name']??'',
        phoneNumber: json['phone_number']??'',
        email: json['email']??'',
        password: json['password']?.toString()??'',
        employeeJob: json['employee_job']??'',
        blocked: json['blocked']??'');
  }

  toMap() {
    return {
      "full_name": this.fullName,
      "phone_number": this.phoneNumber,
      "email": this.email,
      "password": this.password,
      "employee_job": this.employeeJob,
    };
  }
}
