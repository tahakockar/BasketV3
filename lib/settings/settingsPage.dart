import 'package:basketv2/settings/change%C4%B0nformationPage.dart';
import 'package:basketv2/settings/accountInfo.dart';
import 'package:flutter/material.dart';

import '../authentication/api.dart';
import '../configuration/dataBase.dart';
import '../main.dart';


class settingsPage extends StatefulWidget {
  const settingsPage({Key? key}) : super(key: key);

  @override
  _settingsPageState createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {

  void _qrLogOut(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.withOpacity(0.9),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            elevation: 0,
            title: Text("Çıkış Yapıyorsunuz",style: TextStyle(color: Colors.white),),
            content: Text("Bu Hesaptan Çıkış Yapmak Üzeresiniz",style: TextStyle(color: Colors.white),),
            actionsAlignment: MainAxisAlignment.center,
            actions:[
              MaterialButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,

                onPressed: (){
                  Navigator.pop(context);
                },
                child:Text("Geri",style: TextStyle(color: Colors.white),) ,
              ),
              MaterialButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,

                onPressed: ()async{

                  var r = await AuthServices.logout();

                  if (r["succes"] != false) {
                    DatabaseService()
                        .DeleteLoginDatabase()
                        .then((value) {
                      if (value == true) {
                        Navigator.of(context)
                            .pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyApp()),
                                (Route<dynamic> route) =>
                            false);
                      }
                    });
                  };

                },
                child:Text("Log Out",style: TextStyle(color: Colors.white),) ,
              ),
            ],
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Ayarlar",style: TextStyle(color: Colors.black),),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios,color: Colors.black,)

          ),
        ),
        body:SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: (){
                          Navigator.push (
                            context,
                            MaterialPageRoute (
                              builder: (BuildContext context) => passwordResetPage(),
                            ),
                          );
                        },
                        leading: Icon(Icons.person_pin_outlined,color: Colors.black,),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                        title: Text("Hesap Bilgileri",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                      ),
                      ListTile(
                        onTap: (){
                          Navigator.push (
                            context,
                            MaterialPageRoute (
                              builder: (BuildContext context) => passwordChangePage(),
                            ),
                          );
                        },
                        leading: Icon(Icons.lock,color: Colors.black,),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                        title: Text("Password",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                      ),

                      Container(
                        width: double.infinity,
                        height: 5,
                        color: Colors.grey[100],
                      ),
                    ],
                  )),

              Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.all(20),
                        child:  Text("Destek",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey[600]),),
                      ),


                      ListTile(
                        onTap: (){},
                        leading: Icon(Icons.help_outline,color: Colors.black,),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                        title: Text("Yardım",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                      ),
                      ListTile(
                        onTap: (){},
                        leading: Icon(Icons.not_interested,color: Colors.black,),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                        title: Text("Gizlilik",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                      ),

                      Container(
                        width: double.infinity,
                        height: 5,
                        color: Colors.grey[100],
                      ),
                    ],
                  )),
              Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.all(20),
                        child:  Text("Çıkış",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey[600]),),
                      ),


                      ListTile(
                        onTap: (){
                          _qrLogOut(context);
                        },
                        leading: Icon(Icons.logout,color: Colors.red,),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.red,),
                        title: Text("Çıkış",style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.w500),),
                      ),

                      Container(
                        width: double.infinity,
                        height: 5,
                        color: Colors.grey[100],
                      ),
                    ],
                  )),
            ],
          ),
        )
    );
  }
}
