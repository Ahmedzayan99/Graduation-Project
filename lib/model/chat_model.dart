// ignore_for_file: camel_case_types

class Plan {
  List<plays>? play;
  DateTime?date;
  String? uId;
  Plan({
     required this.play,
    this.date,
    this.uId,
  });
  Plan.fromJson(Map<String,dynamic> json){
    play =json['play'];
    date =json['date'];
    uId =json['uId'];
  }
  Map<String,dynamic> toMap(){
    return {
      'date':date,
      'play':play,
      'uId':uId,
    };
  }
}
class plays {
  int? set;
  String? uId;
  String? image;
  plays({
    this.set,
    this.image,
    this.uId,
  });
  plays.fromJson(Map<String,dynamic> json){
    set =json['set'];
    image =json['image'];
    uId =json['uId'];
  }
  Map<String,dynamic> toMap(){
    return {
      'set':set,
      'uId':uId,
      'image':image,
    };
  }
}

