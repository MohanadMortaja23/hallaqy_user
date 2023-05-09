class DetailsModel {
  bool? status;
  int? code;
  String? message;
  Data? data;

  DetailsModel({this.status, this.code, this.message, this.data});

  DetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? name;
  String? image;
  String? rating;
  bool? isFavourite;
  String? phone;
  List<WorkingHours>? workingHours;

  Data(
      {this.id,
      this.name,
      this.image,
      this.rating,
      this.isFavourite,
      this.phone,
      this.workingHours});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    rating = json['rating'];
    isFavourite = json['is_favourite'];
    phone = json['phone'];

    if (json['working_hours'] != null) {
      workingHours = <WorkingHours>[];
      json['working_hours'].forEach((v) {
        workingHours!.add(new WorkingHours.fromJson(v));
      });
    }
  }
}

class WorkingHours {
  int? id;
  String? day;
  String? from;
  String? to;
  bool? status;

  WorkingHours({this.id, this.day, this.from, this.to, this.status});

  WorkingHours.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    from = json['from'];
    to = json['to'];
    status = json['status'];
  }
}
