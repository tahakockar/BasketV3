class User {
  late int id;
  late String username;
  late String first_name;
  late String last_name;
  late String profile_image;
  late String number;
  late DateTime birthday;

  User({
    required this.id,
    required this.username,
    required this.first_name,
    required this.last_name,
    required this.profile_image,
    required this.number,
    required this.birthday,
  });

  User.fromJson(json) {
    id = json["id"];
    username = json["username"];
    first_name = json["first_name"];
    last_name = json["last_name"];
    profile_image = json["profile_image"];
    number = json["phone"];
    birthday = DateTime.parse(json["birthday"]);
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
      "phone": this.number,
      "birthday": this.birthday,
    };
  }
}
