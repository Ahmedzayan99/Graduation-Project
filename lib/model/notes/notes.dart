class Notes {
  String? title;
  String? data;
  String? time;
  String? status;
  String? id;

  Notes({this.title, this.data, this.time,this.status,this.id});

  Notes.fromJson(Map<String, dynamic> json,) {
    title = json['title'];
    data = json['data'];
    time = json['time'];
    status = json['status'];
     id = json['id'];
  }
  Map<String,dynamic> toMap(){
    return {
      'title':title,
      'data':data,
      'time':time,
      'status':status,
      'id':id,
    };
  }
}
