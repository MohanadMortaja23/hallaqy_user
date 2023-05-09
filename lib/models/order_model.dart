class OrderMdoel {
  bool? status;
  int? code;
  String? message;
  List<DataOrder>? data;

  OrderMdoel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  OrderMdoel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataOrder>[];
      json['data'].forEach((v) {
        data!.add(new DataOrder.fromJson(v));
      });
    }
  }
}

class DataOrder {
  int? id;
  String? number;
  String? date;
  String? time;
  String? status;
  String? userName;
  String? userImage;
  String? partnerName;
  String? partnerImage;
  String? employeeName;

  DataOrder(
      {this.id,
      this.number,
      this.date,
      this.time,
      this.status,
      this.userName,
      this.userImage,
      this.partnerName,
      this.partnerImage,
      this.employeeName});

  DataOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    userName = json['user_name'];
    userImage = json['user_image'];
    partnerName = json['partner_name'];
    partnerImage = json['partner_image'];
    employeeName = json['employee_name'] ?? json['partner_image'];
  }
}
