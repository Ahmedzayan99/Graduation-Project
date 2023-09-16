class ExercisesModel {
  bool? success;
  String? message;
  List<Data>? data;

  ExercisesModel({this.success, this.message, this.data});

  ExercisesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
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
  Muscle? muscle;

  Data(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.groups,
        this.groupCount,
        this.muscleId,
        this.muscle});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    groups = json['groups'];
    groupCount = json['group_count'];
    muscleId = json['muscle_id'];
    muscle =
    json['muscle'] != null ? new Muscle.fromJson(json['muscle']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['groups'] = this.groups;
    data['group_count'] = this.groupCount;
    data['muscle_id'] = this.muscleId;
    if (this.muscle != null) {
      data['muscle'] = this.muscle!.toJson();
    }
    return data;
  }
}

class Muscle {
  int? id;
  String? name;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;

  Muscle(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.createdAt,
        this.updatedAt});

  Muscle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}