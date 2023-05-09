class CountryModel {
  bool? status;
  int? code;
  String? message;
  List<DataCountery>? data;

  CountryModel({this.status, this.code, this.message, this.data});

  CountryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataCountery>[];
      json['data'].forEach((v) {
        data!.add(new DataCountery.fromJson(v));
      });
    }
  }
}

class DataCountery {
  int? id;
  String? name;

  DataCountery({this.id, this.name});

  DataCountery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
