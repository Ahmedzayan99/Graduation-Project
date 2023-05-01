import 'package:blackgym/model/start_training_model.dart';
class Train {
  late String image;
  late String lebol;
  late String details;
  late String id;
  List<SelectTrain> data;
//  late SelectTrain data;
  Train({
    required this.id,
    required this.image,
    required this.lebol,
    required this.details,
    required this.data,
  });
  }
class TrainModel {
   String? id;
    String? lebol;
    String? details;
    String? image;
   List<SelectTrain>? data;
   TrainModel({
     this.id,
    this.lebol,
    this.details,
    this.image,
    this.data,
  });
   TrainModel.fromJson(Map<String,dynamic> json){
     id =json['id'];
     lebol =json['lebol'];
     details =json['details'];
     image =json['image'];
     data =json['data'];
  }
  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'lebol':lebol,
      'details':details,
      'image':image,
      'data':data,
    };
  }
}