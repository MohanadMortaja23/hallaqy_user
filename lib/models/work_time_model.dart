class WorkTime {
  bool? status;
  int? code;
  String? message;
  List<Data>? data;

  WorkTime({this.status, this.code, this.message, this.data});

  WorkTime.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  dynamic time;
  bool? status;

  Data({this.time, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    status = json['status'];
  }
}
