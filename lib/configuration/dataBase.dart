import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DatabaseService {
  final _storage = FlutterSecureStorage();

  Future readDatabase() async {
    String token = await _storage.read(key: "Token") ?? '';
    String username = await _storage.read(key: "username") ?? '';
    String email = await _storage.read(key: "email") ?? '';
    String password = await _storage.read(key: "password") ?? '';

    return {
      "token": token,
      "username": username,
      "email": email,
      "password": password,
    };
  }

  Future WriteLoginDatabase(data) async {
    if (data["username"] == null &&
        data["password"] == null &&
        data["token"] == null) {
      return false;
    }    await _storage.write(key: "Token", value: data["token"]);
    await _storage.write(key: "password", value: data["password"]);
    await _storage.write(key: "username", value: data["username"]);

    return true;
  }

  Future UpdateToken(data) async {
    if (data == null) {
      return false;
    }

    await _storage.write(key: "token", value: data["token"]);
    return true;
  }
  Future DeleteLoginDatabase()async{

    await _storage.delete(key: "token");
    await _storage.delete(key: "password");
    await _storage.delete(key: "username");

    return true;

  }

  Future readToken()async{
    String token = await _storage.read(key: "Token") ?? '';
    return token;
  }
}
