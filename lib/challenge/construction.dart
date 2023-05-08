import '../authentication/construction.dart';

class BasketPlace {
  int? id;
  late String name;
  late String image;
  late String addres;
  late double lat;
  late double long;

  BasketPlace({
    this.id,
    required this.name,
    required this.image,
    required this.addres,
    required this.lat,
    required this.long,
  });

  BasketPlace.fromJson(Map json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
    addres = json["addres"];
    lat = json["lat"];
    long = json["long"];
  }

  Map toMap() {
    return {
      "id": this.id,
      "name": this.name,
      "image": this.image,
      "addres": this.addres,
      "lat": this.lat,
      "long": this.long
    };
  }

  static List<BasketPlace> fromJsonList(List list) {
    return list.map((item) => BasketPlace.fromJson(item)).toList();
  }

  @override
  String toString() {
    return "${this.name}";
    //"BasketPlace [id=${this.id}, name=${this.name}, image_referance=${this.image_referance},addres=${this.addres}, latitude=${this.lat}, longitude=${this.long}]";
  }
}

class GameSize {
  int? id;
  late int nof;
  late int max_players;

  GameSize({
    this.id,
    required this.nof,
    required this.max_players,
  });

  GameSize.fromJson(Map json) {
    id = json["id"];
    nof = json["nof"];
    max_players = json["max_players"];
  }

  Map toMap() {
    return {
      "id": this.id,
      "nof": this.nof,
      "total_people": this.max_players,
    };
  }

  @override
  String toString() {
    return "Nof [id=${this.id}, nof=${this.nof}, total_people=${this.max_players}]";
  }
}

class Challenge {
  int? id;
  late User author;
  late GameSize gameSize;
  late BasketPlace place;
  late String start_time;
  late String end_time;
  late String created_at;
  late List<User> players;

  Challenge({
    this.id,
    required this.author,
    required this.gameSize,
    required this.place,
    required this.start_time,
    required this.end_time,
    required this.created_at,
    required this.players,
  });

  Challenge.fromJson(Map json) {
    id = json["id"];
    author = User.fromJson(json["author"]);
    players = List<User>.generate(json["players"].length, (index) => User.fromJson(json["players"][index]));
    gameSize = GameSize.fromJson(json["game_size"]);
    place = BasketPlace.fromJson(json["place"]);
    start_time = json["start_time"];
    end_time = json["end_time"];
    created_at = json["created_at"];
  }


  static List<Challenge> fromJsonList(List list) {
    return list.map((item) => Challenge.fromJson(item)).toList();
  }


  Map toMap() {
    return {
      "id": this.id,
      "author": this.author,
      "game_size": this.gameSize.toMap(),
      "place": this.place.toMap(),
      "start_time": this.start_time,
      "end_time": this.end_time,
      "created_at": this.created_at,
    };
  }

  @override
  String toString() {
    return "Challange [id=${this.id}, created_user=${this.gameSize}, gameSize=${this.gameSize}, place=${this.place}, challange_time=${this.start_time}, end_time=${this.end_time}, created_at=${this.created_at}]";
  }
}
