/*class PlanModel {
  bool? success;
  String? message;
  List<Data>? data;

  PlanModel({this.success, this.message, this.data});

  PlanModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  int? muscleId;
  int? exerciseId;
  String? day;
  Exercise? exercise;
  Muscle? muscle;

  Data(
      {this.id,
        this.userId,
        this.muscleId,
        this.exerciseId,
        this.day,
        this.exercise,
        this.muscle});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    muscleId = json['muscle_id'];
    exerciseId = json['exercise_id'];
    day = json['day'];
    exercise = json['exercise'] != null
        ? Exercise.fromJson(json['exercise'])
        : null;
    muscle =
    json['muscle'] != null ? Muscle.fromJson(json['muscle']) : null;
  }

}

class Exercise {
  int? id;
  String? name;
  String? description;
  String? image;
  int? groups;
  int? groupCount;
  int? muscleId;


  Exercise(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.groups,
        this.groupCount,
        this.muscleId,
        });

  Exercise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    groups = json['groups'];
    groupCount = json['group_count'];
    muscleId = json['muscle_id'];
  }

}
class Muscle {
  int? id;
  String? name;
  String? description;
  String? image;

  Muscle(
      {this.id,
        this.name,
        this.description,
        this.image,
        });

  Muscle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];

  }
}*/
class PlanModel {
  bool? success;
  String? message;
  List<Data>? data;

  PlanModel({this.success, this.message, this.data});

  PlanModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? muscles;
  String? exercises;
  String? day;
  String? createdAt;
  String? updatedAt;
  Data(
      {this.id,
        this.userId,
        this.muscles,
        this.exercises,
        this.day,
        this.createdAt,
        this.updatedAt,
        });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    muscles = json['muscles'];
    exercises = json['exercises'];
    day = json['day'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['muscles'] = this.muscles;
    data['exercises'] = this.exercises;
    data['day'] = this.day;
    return data;
  }
}