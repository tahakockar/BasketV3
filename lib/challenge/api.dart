import 'package:basketv2/configuration/dataBase.dart';
import 'package:basketv2/configuration/settings.dart';
import 'package:dio/dio.dart';

Map urls = {
  "challenges": "/api/challenges",
  "join-challenge": "/api/join-challenge",
  "leave-challenge": "/api/leave-challenge",
  "create_challenge": "/api/challenges",
};

class ChallengeServices {
  static Future get_challenges() async {
    String token = await DatabaseService().readToken();
    var response = await Dio().get(BASE_URL + urls["challenges"],
        options: Options(headers: {"Authorization": "Token ${token}"}));
    return response.data;
  }

  static Future get_challange_detail(id) async {
    String token = await DatabaseService().readToken();

    var response =
        await Dio().get(BASE_URL + urls["challange_detail"] + "${id}",
            options: Options(headers: {"Authorization": "Token ${token}"})
        );
    return response.data;
  }

  static Future join_challenge(id) async {
    String token = await DatabaseService().readToken();
    var formData = FormData.fromMap({"id": id});
    var response = await Dio().post(BASE_URL + urls["join-challenge"],
        data: formData,
        options: Options(headers: {"Authorization": "Token ${token}"}));



    print(response.data);
    return response.data;
  }

  static Future leave_challenge(id) async {
    String token = await DatabaseService().readToken();
    var formData = FormData.fromMap({"id": id});
    var response = await Dio().post(BASE_URL + urls["leave-challenge"],
        data: formData,
        options: Options(headers: {"Authorization": "Token ${token}"}));



    print(response.data);
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
