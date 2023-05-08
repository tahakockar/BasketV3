import 'package:basketv2/configuration/settings.dart';
import 'package:dio/dio.dart';

import '../configuration/dataBase.dart';


Map urls = {"login": "/auth/login", "verify": "/auth/verify", "register":"/auth/register", "logout":"/auth/logout","visit":"/auth/visit", "set-password": "/auth/set-password",};

class AuthServices {
  static Future login(username, password, device_id) async {
    var formData = FormData.fromMap(
        {"username": username, "password": password, "device_id": device_id});

    var response = await Dio().post(BASE_URL + urls["login"], data: formData);



    return response.data;
  }

  static Future register(Map<String, dynamic> data) async {
    var formData = FormData.fromMap(data);
    var response = await Dio().post(BASE_URL + urls["register"], data: formData);

    return response.data;
  }

  static Future get_verify_code(phone) async {
    var response = await Dio()
        .get(BASE_URL + urls["verify"], queryParameters: {"phone": phone});
    return response.data;
  }

  static Future check_verify_code(code, phone) async {
    var formData = FormData.fromMap({"phone": phone, "code": code});

    var response = await Dio().post(BASE_URL + urls["verify"], data: formData);

    return response.data;
  }

  static Future logout()async{
    String token = await DatabaseService().readToken();
  var response = await Dio().delete(BASE_URL + urls["logout"],

  options: Options(headers: {"Authorization": "Token ${token}"}),



    );
  return response.data;


  }

  static Future set_password({required String new_password, required String confirm_password, required String phone})async{

    Map<String,dynamic> data = {"new_password":new_password, "confirm_password":confirm_password, "phone":phone};
    final formData = FormData.fromMap(data);
    var response = await Dio().post(
      BASE_URL + urls["set-password"],
      data:formData,
    );
    print(phone);
    print(new_password);
    print(confirm_password);

    return response.data;


  }


  static Future check_number(phone)async{
    var response = await Dio().get(BASE_URL + urls["set-password"], queryParameters: {"phone":phone});
    return response.data;

  }
}
