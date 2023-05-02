import 'package:basketv2/authentication/api.dart';
import 'package:basketv2/configuration/dataBase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class registerPage extends StatefulWidget {
  const registerPage({Key? key}) : super(key: key);

  @override
  _registerPageState createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  TextEditingController first_name_contoroller = TextEditingController();
  TextEditingController last_name_contoroller = TextEditingController();
  String? birthday;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: first_name_contoroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'doldur amk';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'İsim',
                            ),
                            onChanged: (text) {
                              setState(() {
                                //you can access nameController in its scope to get
                                // the value of text entered as shown below
                                //fullName = nameController.text;
                              });
                            },
                          ),
                        )),
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'boş yer kalmasın';
                              }
                              return null;
                            },
                            controller: last_name_contoroller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Soyisim',
                            ),
                            onChanged: (text) {
                              setState(() {
                                //you can access nameController in its scope to get
                                // the value of text entered as shown below
                                //fullName = nameController.text;
                              });
                            },
                          ),
                        )),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModal(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: Colors.black26,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        height: 50,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Yaşınızı Girin",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50, right: 20, left: 20),
                    child: MaterialButton(
                      color: Colors.blue,
                      minWidth: double.maxFinite,
                      onPressed: () {
                        if (birthday == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Doğum tarihini gir")),
                          );
                        } else {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    register2Page(
                                        first_name: first_name_contoroller.text,
                                        last_name: last_name_contoroller.text,
                                        birthday: birthday!),
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        "İleri",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void showModal(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Container(
              child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 40),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20)),
                  height: 5,
                  width: 50,
                ),
              ),
              DatePickerWidget(
                looping: false,
                // default is not looping
                onChange: (DateTime newDate, _) {
                  setState(() {
                    birthday = DateFormat('yyyy-MM-dd').format(newDate);
                    print(birthday);
                  });
                },
                firstDate: DateTime(1950, 01, 01),
                lastDate: DateTime(2015, 1, 1),
                initialDate: DateTime(1991, 10, 12),
                dateFormat: "dd-MMM-yyyy",
                locale: DatePicker.localeFromString('tr'),

                pickerTheme: DateTimePickerTheme(
                  confirmTextStyle: TextStyle(color: Colors.pink),
                  confirm: Text(""),
                  itemHeight: 60,
                  itemTextStyle: TextStyle(color: Colors.black, fontSize: 19),
                  dividerColor: Colors.blue,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: MaterialButton(
                    color: Colors.blue,
                    minWidth: double.infinity,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
            ],
          ));
        });
  }
}

class register2Page extends StatefulWidget {
  late String first_name;
  late String last_name;
  late String birthday;

  register2Page(
      {Key? key,
      required String this.first_name,
      required String this.last_name,
      required String this.birthday});

  @override
  _register2PageState createState() => _register2PageState();
}

class _register2PageState extends State<register2Page> {
  ///ilk sayfadan gelen veriler
  String? first_name;
  String? last_name;
  String? birthday;
  String? device_id;


  ///ikinci sayfa için gereken veriler
  TextEditingController username_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController password2_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();

  bool is_verify = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    first_name = widget.first_name;
    last_name = widget.last_name;
    birthday = widget.birthday;

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
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            /// Username
             Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length < 8) {
                        return "En az 8 karakter girmelisiniz";
                      } else if (value.length > 15) {
                        return "En fazla 15 karakter girebilirsiniz";
                      } else if (false) {
                        //username regex gelicek

                      }

                      return null;
                    },
                    controller: username_controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'UserName',
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
                  /// Password
                  Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length < 8) {
                        return 'Şifre minimum 8 karakterli olmalıdır';
                      } else if (value.length > 15) {
                        return 'Şifre en fazla 15 karakterli olmalıdır';
                      }
                      return null;
                    },
                    controller: password_controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
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
                  /// Password Verify
                  Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value != password_controller.text) {
                        return "password aynı değil";
                      }
                      return null;
                    },
                    controller: password2_controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password Verify',
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
                /// Number Verify
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
                            onPressed: () {
                              AuthServices.get_verify_code(
                                      phone_controller.text)
                                  .then((value) {
                                print(value);
                                _numberVerifyDialog(
                                    context, phone_controller.text);
                              });
                            },
                            child: Text(
                              "Doğrula",
                              style: TextStyle(color: Colors.blue),
                            ))
                      ],
                    )),
                ///Button
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: MaterialButton(
                    color: Colors.blue,
                    minWidth: double.infinity,
                    onPressed: () {
                      if (!is_verify) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Telefon doğrulaması yap')),
                        );
                      } else {
                        if (_formKey.currentState!.validate()) {
                          print("kayıt başarılı");
                          Map<String, dynamic> data = {
                            "username": username_controller.text,
                            "first_name": first_name,
                            "last_name": last_name,
                            "phone": phone_controller.text,
                            "device_id": device_id,
                            "birthday": birthday,
                            "password": password_controller.text
                          };

                          AuthServices.register(data).then((value) {
                            if (value["succes"]) {
                              DatabaseService().WriteLoginDatabase({
                                "username": value["username"],
                                "password": password_controller.text,
                                "token": value["token"]
                              }).then((value) {
                                if (value) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => MyApp()),
                                      (Route<dynamic> route) => false);
                                }
                              });
                            }else{
                              print(value["message"]);
                            };
                          });
                          //gelen bilgiler databaseye kaydedilecek
                          //myappe yönlendirilicek,

                        }
                      }
                    },
                    child: Text(
                      "Oluştur",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ))));
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
                                  setState(() {
                                    is_verify = true;
                                  });
                                  print("doğrualama başarılı");
                                } else {
                                  print("doğrulama başarısız");
                                }
                              });
                              Navigator.pop(context);
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
