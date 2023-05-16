import 'package:basketv2/ArGe.dart';
import 'package:basketv2/profil/MyUserProfil.dart';
import 'package:basketv2/profil/userProfilPage.dart';
import 'package:basketv2/search/searchPage.dart';
import 'package:flutter/material.dart';
import 'challenge/challenges.dart';
import 'challenge/createChallenge.dart';



class bottomNavigationBarPage extends StatefulWidget {
  int? index;
  bottomNavigationBarPage({Key? key, this.index}) : super(key: key);

  @override
  _bottomNavigationBarPageState createState() => _bottomNavigationBarPageState();
}

class _bottomNavigationBarPageState extends State<bottomNavigationBarPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    if (widget.index != null){
      setState(() {
        _selectedIndex = widget.index!;
      });
    }
    super.initState();
  }

  static List<Widget> _widgetOptions = <Widget>[
    challengesPage(),
    searcPage(),
    myUserProfilPage(),
  ];

  void _onItemTapped(int index) {
    print(index);
    if (_widgetOptions.length > index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    switch (index) {
      case 0:
        print(index);
        // only scroll to top when current index is selected.


        break;

      case 3:
        showModal(context);
        break;
    }
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
              height: 300,
              child: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            width: 30,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Text(
                              "Oluştur",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            color: Colors.grey[200],
                            height: 2,
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => createChallangePage(),
                          ),
                        );
                      },
                      leading: Icon(
                        Icons.sports,
                        color: Colors.black,
                        size: 30,
                      ),
                      title: Text(
                        "Challange",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      color: Colors.grey[200],
                      height: 1,
                      margin: EdgeInsets.all(20).copyWith(top: 0, bottom: 0),
                    ),
                    ListTile(
                      onTap: () { },
                      leading: Icon(
                        Icons.sports,
                        size: 30,
                        color: Colors.black,
                      ),
                      title: Text("Team",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      color: Colors.grey[200],
                      height: 1,
                      margin: EdgeInsets.all(20).copyWith(top: 0, bottom: 0),
                    ),
                  ])));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
      body: Center(
                                                                                                                                                            child: _widgetOptions.elementAt(_selectedIndex),
      ),
        bottomNavigationBar: Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: BottomNavigationBar(


                type: BottomNavigationBarType.fixed,
                items:  <BottomNavigationBarItem>[
                  BottomNavigationBarItem(


                    activeIcon: Icon(Icons.home,color: Colors.black,),
                    label: "",
                    icon: Icon(
                      Icons.home_outlined,
                      color: Colors.black87,
                    ),
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.search_sharp,
                        color: Colors.black87,
                      ),
                      label: ""),
                  BottomNavigationBarItem(
                      activeIcon: Icon(Icons.person,color: Colors.black,),
                      icon:Icon(Icons.person_outline_outlined,
                        color: Colors.black87,
                      ),
                      label: ""),
                  BottomNavigationBarItem(

                      icon: Icon(
                        Icons.sports_basketball_rounded,
                        color: Colors.deepOrange,
                      ),
                      label: ""),

                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.amber[800],
                onTap: _onItemTapped,
              ),
            ))
    );
  }
}

