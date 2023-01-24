class Train {
  late String image;
  late String lebol;
  late String details;
  late String id;
//  late SelectTrain data;
  Train({
    required this.id,
    required this.image,
    required this.lebol,
    required this.details,
  });
  }
  class SelectTrain {
  late String id;
  late String image;
  late String lebol;
  late String details;

  SelectTrain({
  required this.id,
  required this.image,
  required this.lebol,
  required this.details,
  });
  }
class Model {
  final String name;
  final String message;
  final String data;
  final String photos;
  Model({
    required this.name,
    required this.data,
    required this.message,
    required this.photos,
  });
}