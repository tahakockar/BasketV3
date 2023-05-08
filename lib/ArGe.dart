import 'package:basketv2/profil/api.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class editPage extends StatefulWidget {
  const editPage({Key? key}) : super(key: key);

  @override
  _editPageState createState() => _editPageState();
}

class _editPageState extends State<editPage> {
  File? _image;

  final _picker = ImagePicker();
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text("Yeni Gönderi"),
      leading: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(Icons.clear,color: Colors.black,),
      ),
      actions: [
        TextButton(onPressed: ()async{
          var response = await ProfilServices.set_profil(profil_photo: _image, username: username.text);
          print(response);

        },
            child: Text("Kaydet",style:TextStyle(fontWeight: FontWeight.bold),))
      ],

    ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Padding(
               padding: EdgeInsets.only(top: 30),
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
                     child:  _image != null ? Image.file(_image!, fit: BoxFit.fill) :Image.network( "https://instagram.fist1-1.fna.fbcdn.net/v/t51.2885-19/333624764_2046034162268815_5189389350621667776_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fist1-1.fna.fbcdn.net&_nc_cat=107&_nc_ohc=P2ihdF3i_pAAX-VFE4-&edm=AAAAAAABAAAA&ccb=7-5&oh=00_AfDzXpICReYM7Wt9ZBRrP9nzLSQOPSi6_x35mBsYpxLGgw&oe=6449A1D5&_nc_sid=022a36",
                       fit: BoxFit.fill,
                     ),
                   ),
                   color: Colors.red,
                 ),
               ),
             ),
            ),
            Padding(padding: EdgeInsets.all(20),
            child: TextField(
              controller: username,
              decoration:  InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'New username',
              ),

            ),
            ),
            Padding(padding: EdgeInsets.all(20),
            child: TextField(
              controller: phone,
              decoration:  InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'New Name',
              ),

            ),
            ),

          ],
        ),
      ) ,

    );
  }
}



//jlkjklj
