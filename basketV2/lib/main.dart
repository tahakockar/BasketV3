import 'package:basketv2/authentication/api.dart';
import 'package:basketv2/authentication/login.dart';
import 'package:basketv2/bottomNavigationBarPage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'configuration/dataBase.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('tr_TR');
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future? _check;

  @override
  void initState() {
    _check = check(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _check,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return loginPage();
        } else {
          return
            Container(
                color: Colors.white,
                child:Center(
              child: CircularProgressIndicator(
                  color: Colors.black54,
                  strokeWidth: 1,
                  backgroundColor: Colors.grey)));
        }
      },
    );
  }
}

Future check(context) async {
  DatabaseService().readDatabase().then((data) {
    //DataBase kontrolu
    // Gelen bilgileri kontrol etmek
    if (data["username"] == null ||
        data["email"] == null ||
        data["password"] == null ||
        data["token"] == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => loginPage()),
          (Route<dynamic> route) => false);
    } else {
      Firebase.initializeApp().then((value) {
        var messaging = FirebaseMessaging.instance;
        messaging.getToken().then((id) {
          AuthServices.login(data["username"], data["password"], id.toString())
              .then((value) {
            print(value);
            if (value["succes"] != true) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => loginPage()),
                  (Route<dynamic> route) => false);
            } else {
              DatabaseService().WriteLoginDatabase({
                "username": data["username"],
                "password": data["password"],
                "token": value["token"]
              }).then((value) {
                if (value != true) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => loginPage()),
                      (Route<dynamic> route) => false);
                } else {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => bottomNavigationBarPage()),
                      (Route<dynamic> route) => false);
                }
              });
            }
          });
        });
      });
    }

    print("girdi");
    return true;
  });
}

