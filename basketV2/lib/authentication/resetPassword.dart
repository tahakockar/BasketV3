import 'package:basketv2/authentication/login.dart';
import 'package:basketv2/profil/api.dart';
import 'package:flutter/material.dart';

import 'api.dart';

class resetPasswordVerifyPage extends StatefulWidget {
  const resetPasswordVerifyPage({Key? key}) : super(key: key);

  @override
  _resetPasswordVerifyPageState createState() => _resetPasswordVerifyPageState();
}

class _resetPasswordVerifyPageState extends State<resetPasswordVerifyPage> {
  TextEditingController phone_controller = TextEditingController();

  bool? is_verify;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child: SingleChildScrollView(
        child:Padding(

        padding: EdgeInsets.all(20),
        child:Column(

          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: TextFormField(
                          controller: phone_controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Number Verify',
                          ),
                          onChanged: (text) {
                            setState(() {
                              //you can access nameController in its scope to get
                              // the value of text entered as shown below
                              //fullName = nameController.text;
                            });
                          },
                        ),
                      ),
                    ),
                    MaterialButton(
                        minWidth: double.minPositive,
                        onPressed: () async{
                          var filter = await AuthServices.check_number(phone_controller.text);

                          if(filter["succes"]){
                            await AuthServices.get_verify_code(phone_controller.text);
                            _numberVerifyDialog(context, phone_controller.text);
                          }else{
                            print("böyle bir numara kayıtlı değil");

                          }
                        },
                        child: Text(
                          "Verify",
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                )),

          ],
        ),
      ),
      ),
      )
    );
  }



  void _numberVerifyDialog(BuildContext context, phone) {
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
                            onPressed: () {
                              AuthServices.check_verify_code(
                                  code_controller.text, phone)
                                  .then((value) {
                                if (value["succes"]) {
                                  Navigator.push (
                                    context,
                                    MaterialPageRoute (
                                      builder: (BuildContext context) => resetPasswordPage(phone: phone!),
                                    ),
                                  );
                                  print("doğrualama başarılı");
                                  setState(() {
                                    is_verify = true;
                                  });
                                  

                                } else {
                                  print("doğrulama başarısız");
                                }
                              });

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



class resetPasswordPage extends StatefulWidget {
  late String phone;
  resetPasswordPage({Key? key, required String this.phone}) : super(key: key);

  @override
  _resetPasswordPageState createState() => _resetPasswordPageState();
}



class _resetPasswordPageState extends State<resetPasswordPage> {

  TextEditingController confirm_password_controller = TextEditingController();
  TextEditingController new_password_controller = TextEditingController();
  String? _phone;

  @override
  void initState() {
    _phone = widget.phone;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: TextFormField(
                  controller: new_password_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'New Password',
                  ),
                  onChanged: (text) {
                    setState(() {
                      //you can access nameController in its scope to get
                      // the value of text entered as shown below
                      //fullName = nameController.text;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: TextFormField(
                  controller: confirm_password_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                  ),
                  onChanged: (text) {
                    setState(() {
                      //you can access nameController in its scope to get
                      // the value of text entered as shown below
                      //fullName = nameController.text;
                    });
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 50),
              child: ElevatedButton(
                onPressed: (){
                  if(new_password_controller.text != confirm_password_controller.text){
                    print("şifre uyuşmuyır");
                  }

                  AuthServices.set_password(new_password: new_password_controller.text, confirm_password: confirm_password_controller.text, phone: _phone!).then((value){
                    print(value);
                    if(value["succes"]){
                      Navigator.push (
                        context,
                        MaterialPageRoute (
                          builder: (BuildContext context) => loginPage(),
                        ),
                      );
                    }

                  });


                },
                child: Text("Confirm"),
              ),

              )
            ],
          ),
        ),
      ),
    );
  }
}

