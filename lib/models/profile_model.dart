class ProfileModel {
  bool? status;
  int? code;
  String? message;
  Data? data;

  ProfileModel({this.status, this.code, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  dynamic id;
  dynamic name;
  dynamic image;
  dynamic phone;
  dynamic token;
  dynamic status;
  dynamic countryId;

  Data(
      {this.id,
      this.name,
      this.image,
      this.phone,
      this.token,
      this.status,
      this.countryId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    phone = json['phone'];
    token = json['token'];
    status = json['status'];
    countryId = json['country_id'];
  }
}
