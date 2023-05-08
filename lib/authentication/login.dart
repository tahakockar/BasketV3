import 'package:basketv2/authentication/api.dart';
import 'package:basketv2/authentication/register.dart';
import 'package:basketv2/authentication/resetPassword.dart';
import 'package:basketv2/bottomNavigationBarPage.dart';

import 'package:basketv2/configuration/dataBase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';



class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  String? device_id;
  final UsernameController = TextEditingController();
  final PasswordController = TextEditingController();

  @override
  void initState() {
    Firebase.initializeApp().then((value) {
      var messaging = FirebaseMessaging.instance;
      messaging.getToken().then((id) {
        device_id = id.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 55,
                        child: TextField(
                          cursorWidth: 1,
                          cursorHeight: 21,
                          controller: UsernameController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xFFA9A9A9)), //<-- SEE HERE
                            ),
                            hintText: "kullanıcı ismi",
                            hintStyle: TextStyle(
                                color: Color(0xFF767676), fontSize: 13),
                            filled: true,
                            fillColor: Color(0xFFF0EEEE),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 55,
                        child: TextField(
                          cursorWidth: 1,
                          cursorHeight: 21,
                          controller: PasswordController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              //<-- SEE HERE
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xFFA9A9A9)), //<-- SEE HERE
                            ),
                            hintText: "Şifre",
                            hintStyle: TextStyle(
                                color: Color(0xFF767676), fontSize: 13),
                            filled: true,
                            fillColor: Color(0xFFF0EEEE),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          AuthServices.login(UsernameController.text,
                                  PasswordController.text, device_id!)
                              .then((value) {
                            if (value["succes"] != true) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => loginPage()),
                                  (Route<dynamic> route) => false);
                            } else {
                              DatabaseService().WriteLoginDatabase({
                                "username": UsernameController.text,
                                "password": PasswordController.text,
                                "token": value["token"]
                              }).then((value) {
                                if (value != true) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => loginPage()),
                                      (Route<dynamic> route) => false);
                                }

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => bottomNavigationBarPage()),
                                    (Route<dynamic> route) => false);
                              });
                            }
                          });
                        },
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minWidth: double.infinity,
                        height: 50,
                        color: Color(0xFFA597FF),
                        child: Text(
                          "Giriş Yap",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push (
                                context,
                                MaterialPageRoute (
                                  builder: (BuildContext context) => resetPasswordVerifyPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Yardım",
                              style: TextStyle(
                                  color: Color(0xFFA597FF),
                                  fontWeight: FontWeight.w400),
                            )),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 50),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => registerPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Topluluğa Katıl",
                          style: TextStyle(
                              color: Color(0xFFA597FF),
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
