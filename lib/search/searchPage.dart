import 'package:basketv2/profil/MyUserProfil.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../YardimciWidgetlar.dart';
import '../authentication/construction.dart';
import '../configuration/dataBase.dart';
import '../configuration/settings.dart';
import '../profil/userProfilPage.dart';

class searcPage extends StatefulWidget {
  const searcPage({Key? key}) : super(key: key);

  @override
  _searcPageState createState() => _searcPageState();
}

class _searcPageState extends State<searcPage> {
  List<User>? persons;
  final textFieldContoroller = TextEditingController();


  void _qrDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.withOpacity(0.9),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            elevation: 0,
            title: Text("Geliştiriyoruz",style: TextStyle(color: Colors.white),),
            content: Text("Bu Özellik Şuan Hazır Degil",style: TextStyle(color: Colors.white),),
            actionsAlignment: MainAxisAlignment.center,
            actions:[
              MaterialButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,

                onPressed: (){
                  Navigator.pop(context);
                },
                child:Text("Tamam",style: TextStyle(color: Colors.white),) ,
              ),
            ],
          );
        }
    );
  }


  void getData(String filter) async {
    String token = await DatabaseService().readToken();
    var response = await Dio().get(

        "${BASE_URL}/api/search-user",
        queryParameters: {
          "search": filter
        },
        options: Options(
          headers: {
            "Authorization": "Token ${token}",
          },
        )
    );

    print(response.data);

    setState(() {
      persons = User.fromJsonList(response.data);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          controller: textFieldContoroller,
          onChanged:getData,
          cursorColor: Colors.black,
          cursorWidth: 1,
          decoration: InputDecoration(
            hintText: "Ara",
            prefixIcon: Icon(Icons.search,color: Colors.grey,),

            prefixIconColor: Colors.grey,
            filled: true,
            fillColor: Colors.grey.shade300,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),

          ),

        ),
        actions: [
          Padding(padding: EdgeInsets.only(left: 10,right: 20),
              child:IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: (){
                  _qrDialog(context);
                },
                icon: Icon(Icons.qr_code_scanner,color: Colors.black,),
              )
          )
        ],
      ),
        body:ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
                itemCount: persons?.length == null ? 0 :persons!.length,
                itemBuilder: (context, index){
                  return ListTile(
                    onTap:(){Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext
                          context) =>
                              userProfilPage(id:persons![index].id,),
                        ),
                      );},

                    leading:  CircleAvatar(
                      backgroundImage:NetworkImage("${persons?[index].profile_image}", // No matter how big it is, it won't overflow
                    ),
                    ),

                    title: Text("${persons?[index].username}"),

                    subtitle:Row(children: [
                      Text("${persons?[index].first_name}"),
                      Text("${persons?[index].last_name}"),

                    ],)

                  );
                }
            ))
    );
  }
}
