class NotificationModel {
  bool? status;
  int? code;
  String? message;
  Data? data;

  NotificationModel({this.status, this.code, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<DataNotification>? data;

  Data({
    this.currentPage,
    this.data,
  });

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataNotification>[];
      json['data'].forEach((v) {
        data!.add(new DataNotification.fromJson(v));
      });
    }
  }
}

class DataNotification {
  String? title;
  String? message;

  DataNotification({this.title, this.message});

  DataNotification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
  }
}
