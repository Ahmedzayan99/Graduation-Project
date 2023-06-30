class UserModel {
  bool? status;
  Users? users;

  UserModel({this.status, this.users});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.users != null) {
      data['users'] = this.users!.toJson();
    }
    return data;
  }
}

class Users {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? imageUrl;
  int? height;
  int? weight;
  int? age;
  int? fatPercentage;
  String? coashName;
  String? gender;
  String? createdAt;
  String? updatedAt;
  String? type;
  List<Rate>? rate;

  Users(
      {this.id,
        this.name,
        this.email,
        this.phoneNumber,
        this.imageUrl,
        this.height,
        this.weight,
        this.age,
        this.fatPercentage,
        this.coashName,
        this.gender,
        this.createdAt,
        this.updatedAt,
        this.type,
        this.rate});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    imageUrl = json['image_url'];
    height = json['height'];
    weight = json['weight'];
    age = json['age'];
    fatPercentage = json['fat_percentage'];
    coashName = json['coash_name'];
    gender = json['gender'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    if (json['rate'] != null) {
      rate = <Rate>[];
      json['rate'].forEach((v) {
        rate!.add(new Rate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['image_url'] = this.imageUrl;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['age'] = this.age;
    data['fat_percentage'] = this.fatPercentage;
    data['coash_name'] = this.coashName;
    data['gender'] = this.gender;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type'] = this.type;
    if (this.rate != null) {
      data['rate'] = this.rate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rate {
  int? id;
  String? training;
  String? feeding;
  int? userId;
  int? coashId;
  String? regularity;
  String? response;
  String? total;
  String? createdAt;
  String? updatedAt;

  Rate(
      {this.id,
        this.training,
        this.feeding,
        this.userId,
        this.coashId,
        this.regularity,
        this.response,
        this.total,
        this.createdAt,
        this.updatedAt});

  Rate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    training = json['training'];
    feeding = json['feeding'];
    userId = json['user_id'];
    coashId = json['Coash_id'];
    regularity = json['Regularity'];
    response = json['Response'];
    total = json['Total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['training'] = this.training;
    data['feeding'] = this.feeding;
    data['user_id'] = this.userId;
    data['Coash_id'] = this.coashId;
    data['Regularity'] = this.regularity;
    data['Response'] = this.response;
    data['Total'] = this.total;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}