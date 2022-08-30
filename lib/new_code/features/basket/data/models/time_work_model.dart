class TimeWorkModel {
  late String id;
  late String date;
  late String from;
  late String to;
  late String ex;

  TimeWorkModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'].toString();
    this.date = json['date'].toString();
    this.from = json['from'].toString();
    this.to = json['to'].toString();
    this.ex = json['ex'].toString();
  }
}
