class MusclesModel {
  bool? success;
  String? message;
  List<Data>? data;

  MusclesModel({this.success, this.message, this.data});

  MusclesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

}


class Data {
  int? id;
  String? name;
  String? description;
  String? image;


  Data(
      {this.id,
        this.name,
        this.description,
        this.image,
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
  }

}
