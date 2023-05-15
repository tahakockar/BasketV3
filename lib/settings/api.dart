

import 'package:basketv2/configuration/settings.dart';
import 'package:dio/dio.dart';

import '../configuration/dataBase.dart';


Map urls = {"change_password_with_token":"/auth/change-password", "set-number":"/auth/set-number"};
class SettingsServices{

  static Future change_password_with_token(new_password, confirm_password, password)async{
    String token = await DatabaseService().readToken();
    final formData = FormData.fromMap({
      'new_password': new_password,
      'confirm_password': confirm_password,
      "password":password,
    });
    var response = await Dio().post(BASE_URL + urls["change_password_with_token"],
         data: formData,
        options: Options(headers: {"Authorization": "Token ${token}"}));
    return response.data;




  }

  static Future set_number(number)async{
    String token = await DatabaseService().readToken();
    final formData = FormData.fromMap({
      "phone":number,
    });
    var response = await Dio().post(BASE_URL + urls["set-number"],
        data: formData,
        options: Options(headers: {"Authorization": "Token ${token}"}));
    return response.data;




  }
}