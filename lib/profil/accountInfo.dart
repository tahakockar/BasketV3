import 'package:basketv2/authentication/construction.dart';
import 'package:basketv2/profil/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../profil/changeİnformationPage.dart';


class passwordResetPage extends StatefulWidget {
  const passwordResetPage({Key? key}) : super(key: key);

  @override
  _passwordResetPageState createState() => _passwordResetPageState();
}

class _passwordResetPageState extends State<passwordResetPage> {

  User? user_info;
  @override
  void initState() {
    ProfilServices.my_info().then((value){
      print(value);
      setState(() {
        user_info = User.fromJson(value["response"]);
      });
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    if(user_info != null){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            onPressed:(){ Navigator.pop(context);},
            icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          ),
          title: Text("Hesap Bilgileri",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500),),
        ),
        body: SingleChildScrollView(
            child:
            Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(20),
                    child: ListTile(
                      onTap: (){
                        Navigator.push (
                          context,
                          MaterialPageRoute (
                            builder: (BuildContext context) => numberChangePage(),
                          ),
                        );
                      },
                      title: Text("Number"),
                      subtitle: Text(user_info!.number),
                    )
                ),
               /* Padding(
                    padding: EdgeInsets.all(20),
                    child:ListTile(
                      onTap: (){
                        Navigator.push (
                          context,
                          MaterialPageRoute (
                            builder: (BuildContext context) => eMailChangePage(),
                          ),
                        );
                      },
                      title: Text("E-mail"),
                      subtitle:Text(user_info.) ,
                    )
                ),*/
                Padding(padding: EdgeInsets.all(20),
                  child: ListTile(
                    title: Text("Doğum Tarihi"),
                    subtitle: Text(DateFormat("dd MM yyyy").format(DateTime.parse(user_info!.birthday.toString())),),
                  ),
                ),

              ],
            )
        ),
      );
    }else{
      return Container(
          color: Colors.white,
          child: Center(
              child: CircularProgressIndicator(
                  color: Colors.black54,
                  strokeWidth: 1,
                  backgroundColor: Colors.grey)));
    }

  }
}
