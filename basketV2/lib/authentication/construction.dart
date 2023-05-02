class User {
  late int id;
  late String username;
  late String first_name;
  late String last_name;
  late String profile_image;

  User({
    required this.id,
    required this.username,
    required this.first_name,
    required this.last_name,
    required this.profile_image,
  });

  User.fromJson(json) {
    id = json["id"];
    username = json["username"];
    first_name = json["first_name"];
    last_name = json["last_name"];
    profile_image = json["profile_image"];
  }

  static List<User> fromJsonList(List list) {
    return list.map((item) => User.fromJson(item)).toList();
  }

  Map toMap() {
    return {
      "id": this.id,
      "username": this.username,
      "first_name": this.first_name,
      "last_name": this.last_name,
      "profile_image": this.profile_image,
    };
  }
}
