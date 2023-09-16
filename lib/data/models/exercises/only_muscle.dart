class OnlyMucsleModel {
  bool? success;
  String? message;
  List<Data>? data;
  OnlyMucsleModel({this.success, this.message, this.data});

  OnlyMucsleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    null;
  }
}

class Data {
  int? id;
  String? name;
  String? description;
  String? image;
  int? groups;
  int? groupCount;
  int? muscleId;
  Data(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.groups,
        this.groupCount,
        this.muscleId,

      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    groups = json['groups'];
    groupCount = json['group_count'];
    muscleId = json['muscle_id'];

  }

}

