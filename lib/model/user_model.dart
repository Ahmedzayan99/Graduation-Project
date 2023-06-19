class UserModel {
  bool? success;
  String? message;
  Data? data;
  UserModel({this.success, this.message, this.data});
  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}
class Data {
  int? id;
  String? name;
  String? email;
  String? imageUrl;
  String? phoneNumber;
  int? height;
  int? weight;
  int? age;
  int? fatPercentage;
  String? accountStatus;
  String? coashName;
  String? membership;
  String? gender;
  int? planId;
  String? emailVerifiedAt;
  String? apiToken;
  String? createdAt;
  String? updatedAt;


  Data(
    {this.id,
      this.name,
      this.email,
      this.imageUrl,
      this.phoneNumber,
      this.height,
      this.weight,
      this.age,
      this.fatPercentage,
      this.accountStatus,
      this.coashName,
      this.membership,
      this.gender,
      this.planId,
      this.emailVerifiedAt,
      this.apiToken,
      this.createdAt,
      this.updatedAt

    });

Data.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  name = json['name'];
  email = json['email'];
  imageUrl = json['image_url'];
  phoneNumber = json['phone_number'];
  height = json['height'];
  weight = json['weight'];
  age = json['age'];
  fatPercentage = json['fat_percentage'];
  accountStatus = json['account_status'];
  coashName = json['coash_name'];
  membership = json['membership'];
  gender = json['gender'];
  planId = json['plan_id'];
  emailVerifiedAt = json['email_verified_at'];
  apiToken = json['api_token'];
  createdAt = json['created_at'];
  updatedAt = json['updated_at'];

}

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'name':name,
      'email':email,
      'imageUrl':imageUrl,
      'phone_number':phoneNumber,
      'age':age,
      'weight':weight,
      'height':height,
      'fat_percentage':fatPercentage,
      'accountStatus':accountStatus,
      'coashName':coashName,
      'membership':membership,
      'gender':gender,
      'planId':planId,
      'emailVerifiedAt':emailVerifiedAt,
      'apiToken':apiToken,
      'createdAt':createdAt,
      'updatedAt':updatedAt,
      'created_at': createdAt,
    };
  }
}