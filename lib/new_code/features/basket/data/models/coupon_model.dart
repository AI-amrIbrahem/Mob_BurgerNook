class CouponModel {
  late String id;
  late String name;
  late String value;

  CouponModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id']??'';
    this.name = json['name']??'';
    this.value = json['value']??'';
  }
}
