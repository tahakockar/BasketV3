import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:basketv2/configuration/dataBase.dart';
import 'package:basketv2/configuration/settings.dart';
import 'package:dio/dio.dart';

Map urls = {
  "my-user-profil":"/auth/my-user",
  "user-profil": "/auth/user-profil",
  "set-profil": "/auth/set-profil",
  "user-info": "/auth/user-info",
};

class ProfilServices {
  static Future get_my_user_info() async {
    String token = await DatabaseService().readToken();
    print(token);
    var response = await Dio().get(BASE_URL + urls["my-user-profil"],
        options: Options(headers: {"Authorization": "Token ${token}"}));
    return response.data;
  }

  static Future get_user_info(id) async {
    String token = await DatabaseService().readToken();
    var response = await Dio().get(BASE_URL + urls["user-profil"], queryParameters: {"id":id});
    return response.data;
  }

  static Future set_profil({String? username, String? phone,File? profil_photo}) async {
    final formData = FormData.fromMap({
      'phone': phone,
      'profile_image': profil_photo!=null? await MultipartFile.fromFile(profil_photo.path) : "",
      "username":username
    });

    print(formData);

      String token = await DatabaseService().readToken();
      var response = await Dio().post(
          BASE_URL + urls["set-profil"],
          options: Options(headers: {"Authorization": "Token ${token}"}),
        data: formData);
      return response.data;

  }

  static Future my_info() async {
    String token = await DatabaseService().readToken();
    print(token);
    var response = await Dio().get(BASE_URL + urls["user-info"],
        options: Options(headers: {"Authorization": "Token ${token}"}));
    return response.data;
  }



}
