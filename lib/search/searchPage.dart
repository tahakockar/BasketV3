
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../YardimciWidgetlar.dart';
import '../authentication/construction.dart';
import '../configuration/dataBase.dart';
import '../configuration/settings.dart';
import '../profil/userProfilPage.dart';
import '../configuration/widgets.dart';


class searcPage extends StatefulWidget {
  const searcPage({Key? key}) : super(key: key);

  @override
  _searcPageState createState() => _searcPageState();
}

class _searcPageState extends State<searcPage> {
  List<User>? persons;
  List<User>? last_search;

  @override
  void initState() {
    get_recived_search();
    super.initState();
  }

  final textFieldContoroller = TextEditingController();


  void getData(String filter) async {
    print("sadap");
    String token = await DatabaseService().readToken();
    var response = await Dio().get("${BASE_URL}/api/search-user",
        queryParameters: {"search": filter},
        options: Options(
          headers: {
            "Authorization": "Token ${token}",
          },
        ));

    print(response.data);

    setState(() {
      persons = User.fromJsonList(response.data);
    });
  }

  
  void get_recived_search()async{
    String token = await DatabaseService().readToken();
    var response = await Dio().get(BASE_URL + "/api/recived-search",
        options: Options(headers: {"Authorization": "Token ${token}"}));
    setState(() {
      last_search = User.fromJsonList(response.data["response"]);
    });
  }
  void save_recived_search(id) async {
    String token = await DatabaseService().readToken();
    print(id);
    print(id.runtimeType);
    var response = await Dio().post(BASE_URL + "/api/recived-search",
        data: FormData.fromMap({"user": id}),
        options: Options(headers: {"Authorization": "Token ${token}"}));
  }

  void delete_recived_search(id) async {
    String token = await DatabaseService().readToken();
    print(id);
    print(id.runtimeType);
    var response = await Dio().delete(BASE_URL + "/api/recived-search",
        data: FormData.fromMap({"user": id}),
        options: Options(headers: {"Authorization": "Token ${token}"}));
        get_recived_search();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFECE9FF),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          backgroundColor: Color(0xFFECE9FF),
          elevation: 0,
          title: TextField(
            controller: textFieldContoroller,
            onChanged: (value){
              getData(value);
              if (value == null || value == ""){
                get_recived_search();
              }
              },
              cursorColor: Colors.black,
              cursorWidth: 1,
              decoration: InputDecoration(
              hintText: "Ara",
              prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
              ),
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
              Padding(
              padding: EdgeInsets.only(left: 10, right: 20),
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    error(context: context, error_content: "hata var");
                  },
                  icon: Icon(
                    Icons.qr_code_scanner,
                    color: Colors.deepOrange,
                  ),
                ))
          ],
        ),
        body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: textFieldContoroller.text == null ||
                    textFieldContoroller.text == ""
                ? ListView.builder(
                    itemCount: last_search?.length == null ? 1 : last_search!.length,
                    itemBuilder: (context, index) {

                        if (last_search != null){
                          print(last_search?[index].profile_image);
                          return ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        userProfilPage(
                                          id: last_search![index].id,
                                        ),
                                  ),
                                );

                              },
                              trailing:IconButton(
                                icon: Icon(Icons.close,color: Colors.black,),
                                onPressed: (){
                                  delete_recived_search(last_search?[index].id);
                                },
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  "${BASE_URL + last_search![index].profile_image}", // No matter how big it is, it won't overflow
                                ),
                              ),
                              title: Text("${last_search?[index].username}"),
                              subtitle: Row(
                                children: [
                                  Text("${last_search?[index].first_name}"),
                                  Text("${last_search?[index].last_name}"),
                                ],
                              ));
                        }else{
                          return Container(
                              child: Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.black54,
                                      strokeWidth: 1,
                                      backgroundColor: Colors.grey)));
                        }

                    })
                : ListView.builder(
                    itemCount: persons?.length == null ? 0 : persons!.length,
                    itemBuilder: (context, index) {
                      print(persons?[index].profile_image);
                      return ListTile(
                          onTap: () {
                            var r = save_recived_search(persons![index].id);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    userProfilPage(
                                  id: persons![index].id,
                                ),
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              "${persons?[index].profile_image}", // No matter how big it is, it won't overflow
                            ),
                          ),
                          title: Text("${persons?[index].username}"),
                          subtitle: Row(
                            children: [
                              Text("${persons?[index].first_name}"),
                              Text("${persons?[index].last_name}"),
                            ],
                          ));
                    })));
  }
}
