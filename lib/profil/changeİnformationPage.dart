
import 'package:basketv2/profil/api.dart';
import 'package:flutter/material.dart';

import '../authentication/api.dart';

/// Number

class numberChangePage extends StatefulWidget {
  const numberChangePage({Key? key}) : super(key: key);

  @override
  _numberChangePageState createState() => _numberChangePageState();
}

class _numberChangePageState extends State<numberChangePage> {

  TextEditingController phone_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        child: BottomAppBar(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
                padding: EdgeInsets.only(),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        elevation: MaterialStateProperty.all(0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.grey)))),
                    child: Text(
                      "Geri",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ))),
            Padding(
                padding: EdgeInsets.only(),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.grey.shade500),
                        elevation: MaterialStateProperty.all(0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color: Colors.grey.shade800)))),
                    child: Text(
                      "İleri",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ))),
          ],
        )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 70, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(),
                child: Text(
                  "Number Change",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 50),
                child: Text(
                  "Doğrulamak istediğiniz numarayı giriniz",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: phone_controller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Number',
                          labelStyle: TextStyle(fontStyle: FontStyle.italic)),
                    ),
                  ),
                  MaterialButton(
                      minWidth: double.minPositive,
                      onPressed: () async{

                          await AuthServices.get_verify_code(phone_controller.text);
                          _numberChangeDialog(context, phone_controller.text);

                      },
                      child: Text(
                        "Verify",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _numberChangeDialog(BuildContext context, phone) {
    TextEditingController code_controller = TextEditingController();

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            elevation: 0,
            title: Text(
              "Doğrulama",
              style: TextStyle(color: Colors.black),
            ),
            content: Text(
              "Telefon Numaranıza gönderdiğimiz 6 haneli kodu giriniz",
              style: TextStyle(color: Colors.black),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [

              TextField(
                controller: code_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number Verify',
                ),
                onChanged: (text) {},
              ),
              Center(
                  child: Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Çık",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () async{
                               var is_verify = await AuthServices.check_verify_code(code_controller.text, phone);
                                if (is_verify["succes"]) {
                                 var r =  await ProfilServices.set_number(phone);
                                 print(r);
                                } else {
                                  print("doğrulama başarısız");
                                }


                            },
                            child: Text(
                              "Doğrula",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      )))

            ],
          );
        });
  }

}






/// E-Mail

class eMailChangePage extends StatefulWidget {
  const eMailChangePage({Key? key}) : super(key: key);

  @override
  _eMailChangePageState createState() => _eMailChangePageState();
}

class _eMailChangePageState extends State<eMailChangePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        child: BottomAppBar(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
                padding: EdgeInsets.only(),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        elevation: MaterialStateProperty.all(0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.grey)))),
                    child: Text(
                      "Geri",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ))),
            Padding(
                padding: EdgeInsets.only(),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.grey.shade500),
                        elevation: MaterialStateProperty.all(0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color: Colors.grey.shade800)))),
                    child: Text(
                      "İleri",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ))),
          ],
        )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 70, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(),
                child: Text(
                  "E-Mail Change",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 50),
                child: Text(
                  "Doğrulamak istediğiniz E-Maili giriniz",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'E-Mail',
                          labelStyle: TextStyle(fontStyle: FontStyle.italic)),
                    ),
                  ),
                  MaterialButton(
                      minWidth: double.minPositive,
                      onPressed: () {},
                      child: Text(
                        "Verify",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}





/// Password


class passwordChangePage extends StatefulWidget {
  const passwordChangePage({Key? key}) : super(key: key);

  @override
  _passwordChangePageState createState() => _passwordChangePageState();
}

class _passwordChangePageState extends State<passwordChangePage> {


  TextEditingController password = TextEditingController();
  TextEditingController new_password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        child: BottomAppBar(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                    padding: EdgeInsets.only(),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                            elevation: MaterialStateProperty.all(0),
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.grey)))),
                        child: Text(
                          "Geri",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ))),
                Padding(
                    padding: EdgeInsets.only(),
                    child: ElevatedButton(
                        onPressed: () async{
                          var r = await ProfilServices.change_password_with_token(new_password.text, confirm_password.text, password.text);

                          if (r["succes"] == true){
                            print("şifre yenildendi");
                            Navigator.pop(context);

                          }else{
                            print(r["message"]);
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.grey.shade500),
                            elevation: MaterialStateProperty.all(0),
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color: Colors.grey.shade800)))),
                        child: Text(
                          "Kaydet",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ))),
              ],
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 70, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(),
                child: Text(
                  "Password Change",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 50),
                child: Text(
                  "Şifrenizi değiştirmek için öncelikle eski sifrenizi girin",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic),
                ),
              ),

              TextFormField(
                controller: password,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          labelStyle: TextStyle(fontStyle: FontStyle.italic)),
                    ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: new_password,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'New Password',
                          labelStyle: TextStyle(fontStyle: FontStyle.italic)),
                    ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: confirm_password,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'New Password',
                          labelStyle: TextStyle(fontStyle: FontStyle.italic)),
                    ),

            ],
          ),
        ),
      ),
    );
  }
}
