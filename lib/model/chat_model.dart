class MessageModel {
  String? senderId;
  String? receiverId;
  String? dataTime;
  String? text;
  String? image;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.dataTime,
    this.text,
    this.image,

  });
  MessageModel.fromJson(Map<String,dynamic> json){
    senderId  =json['senderId'];
    receiverId =json['receiverId'];
    dataTime =json['dataTime'];
    text =json['text'];
    image =json['image'];

  }
  Map<String,dynamic> toMap(){
    return {
      'senderId':senderId,
      'receiverId':receiverId,
      'dataTime':dataTime,
      'text':text,
      'image':image,

    };
  }
}