import 'package:basketv2/profil/MyUserProfil.dart';
import 'package:basketv2/profil/api.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../ArGe.dart';
import '../authentication/construction.dart';
import '../bottomNavigationBarPage.dart';
import '../configuration/settings.dart';

class editPage extends StatefulWidget {
  const editPage({Key? key}) : super(key: key);

  @override
  _editPageState createState() => _editPageState();
}

class _editPageState extends State<editPage> {
  File? _image;
  User? user_info;

  final _picker = ImagePicker();
  TextEditingController username = TextEditingController(text: "tahakockar" );
  TextEditingController phone = TextEditingController(text: "kral oyunda");

  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);

        print(_image!.path);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(

          primarySwatch: Colors.deepOrange,
        ),
        home:Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear,color: Colors.black,),
        ),
        actions: [
          TextButton(onPressed: ()async{
            var r = await ProfilServices.set_profil_image(profil_photo: _image,);
            if(r["succes"] == true){
              Navigator.push (
                context,
                MaterialPageRoute (
                  builder: (BuildContext context) => bottomNavigationBarPage(index: 2,),
                ),
              );
            }

          },
              child: Text("Kaydet",style:TextStyle(fontWeight: FontWeight.bold),))
        ],

      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(20),
            child: Text("Profil Düzenle",style: TextStyle(color: Colors.deepOrange,fontSize: 25,fontWeight: FontWeight.w500),),
            ),

            Padding(
              padding: EdgeInsets.only(top: 30,bottom: 30),
              child:GestureDetector(
                onTap: _openImagePicker,
                child:Container(
                  height: 150,
                  width: 150,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child:  _image != null ? Image.file(_image!, fit: BoxFit.fill) :Image.network( "https://static.thenounproject.com/png/1646800-200.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(30),
              child:TextField(
                controller: username,
                cursorColor: Colors.black,
                cursorWidth: 1,
                decoration: InputDecoration(

                  hintText: "New Username",
                  prefixIcon:Icon(Icons.short_text) ,
                  suffixIcon:Icon(
                    Icons.drive_file_rename_outline,
                    color: Colors.black,
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

            ),
            Padding(padding: EdgeInsets.all(30),
              child:TextField(
                controller: phone,
                cursorColor: Colors.black,
                cursorWidth: 1,
                decoration: InputDecoration(
                  hintText: "New Name",
                  prefixIcon:Icon(Icons.short_text) ,
                  suffixIcon:Icon(
                    Icons.drive_file_rename_outline,
                    color: Colors.black,
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

            ),

            ElevatedButton(
                onPressed: ()async{
                  var r = await ProfilServices.delete_profil_image();

                  if(r["succes"] == true){
                    Navigator.push (
                      context,
                      MaterialPageRoute (
                        builder: (BuildContext context) => bottomNavigationBarPage(index: 2,),
                      ),
                    );
                  }
                },
                child: Text("Sil"))

          ],
        ),
      ) ,
        )
    );
  }
}
