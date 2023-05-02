import 'package:flutter/material.dart';

class passwordResetPage extends StatefulWidget {
  const passwordResetPage({Key? key}) : super(key: key);

  @override
  _passwordResetPageState createState() => _passwordResetPageState();
}

class _passwordResetPageState extends State<passwordResetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child:
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 40,right: 40,bottom: 40,top: 40),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: '+90 532 058 13 94',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40,right: 40,bottom: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'tahakockar@gmail.com',
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(20),
            child: ListTile(
              title: Text("Doğum Tarihi"),
              subtitle: Text("26 Ocak 2000"),
              trailing: MaterialButton(
                onPressed: (){},
                elevation: 1,
                color: Colors.white,
                child: Text("Düzenle"),
              ),
            ),
            ),

            Padding(padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: (){},
              child: Text("Değişiklikleri kaydet"),

            ),
            )
          ],
        )
      ),
    );
  }
}
