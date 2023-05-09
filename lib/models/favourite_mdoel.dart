class FavouriteModel {
  bool? status;
  int? code;
  String? message;
  List<Data>? data;

  FavouriteModel({this.status, this.code, this.message, this.data});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  String? image;
  String? distance;
  String? rating;
  dynamic address;
  bool? isFavourite;

  Data(
      {this.id,
      this.name,
      this.image,
      this.distance,
      this.rating,
      this.address,
      this.isFavourite});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    distance = json['distance'];
    rating = json['rating'];
    address = json['address'] ?? '#';
    isFavourite = json['is_favourite'];
  }
}
