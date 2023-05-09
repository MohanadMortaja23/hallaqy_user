class HomeModel {
  bool? status;
  dynamic code;
  String? message;
  List<DataHome>? data;

  HomeModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  HomeModel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataHome>[];
      json['data'].forEach((v) {
        data!.add(new DataHome.fromJson(v));
      });
    }
  }
}

class DataHome {
  dynamic id;
  dynamic name;
  String? image;
  dynamic distance;
  dynamic rating;
  dynamic address;
  bool? isFavourite;

  DataHome(
      {this.id,
      this.name,
      this.image,
      this.distance,
      this.rating,
      this.address,
      this.isFavourite});

  DataHome.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'] ??
        'https://icon-library.com/images/no-profile-picture-icon/no-profile-picture-icon-6.jpg';
    distance = json['distance'];
    rating = json['rating'];
    address = json['address'] ?? '#';
    isFavourite = json['is_favourite'];
  }
}
