class LoginModel {
  bool? status;
  int? code;
  String? message;
  User? user;

  LoginModel({this.status, this.code, this.message, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  int? id;
  String? name;
  String? image;
  String? phone;
  String? token;
  int? status;

  User({this.id, this.name, this.image, this.phone, this.token, this.status});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    phone = json['phone'];
    token = json['token'];
    status = json['status'];
  }
}
