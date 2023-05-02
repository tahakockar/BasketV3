import 'package:basketv2/configuration/dataBase.dart';
import 'package:basketv2/configuration/settings.dart';
import 'package:dio/dio.dart';

Map urls = {
  "challenges": "/api/challenges",
  "challange_detail": "/api/join-challenge",
  "create_challenge": "/api/challenges",
};

class ChallengeServices {
  static Future get_challenges() async {
    var response = await Dio().get(BASE_URL + urls["challenges"]);
    return response.data;
  }

  static Future get_challange_detail(id) async {
    var response =
        await Dio().get(BASE_URL + urls["challange_detail"] + "${id}");
    return response.data;
  }

  static Future join_challenge(id) async {
    String token = await DatabaseService().readToken();
    var formData = FormData.fromMap({"id": id});
    var response = await Dio().post(BASE_URL + urls["challange_detail"],
        data: formData,
        options: Options(headers: {"Authorization": "Token ${token}"}));
    return response.data;
  }

  static Future create_challenge(Map<String, dynamic> data) async {
    String token = await DatabaseService().readToken();
    print(token);
    var response = await Dio().post(BASE_URL + urls["create_challenge"],
        data: data,
        options: Options(headers: {"Authorization": "Token ${token}"}));

    return response.data;
  }
}
