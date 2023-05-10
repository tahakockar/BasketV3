import 'package:basketv2/profil/change%C4%B0nformationPage.dart';
import 'package:basketv2/profil/accountInfo.dart';
import 'package:flutter/material.dart';


class settingsPage extends StatefulWidget {
  const settingsPage({Key? key}) : super(key: key);

  @override
  _settingsPageState createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
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
            ],
          ),
        )
    );
  }
}
