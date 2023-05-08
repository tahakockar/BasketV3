import 'package:basketv2/ArGe.dart';
import 'package:basketv2/authentication/construction.dart';
import 'package:basketv2/challenge/construction.dart';
import 'package:basketv2/configuration/settings.dart';
import 'package:basketv2/profil/api.dart';
import 'package:basketv2/profil/settingsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import '../YardimciWidgetlar.dart';
import '../configuration/widgets.dart';

class myUserProfilPage extends StatefulWidget {
  const myUserProfilPage({Key? key}) : super(key: key);

  @override
  _myUserProfilPageState createState() => _myUserProfilPageState();
}

class _myUserProfilPageState extends State<myUserProfilPage> {

  Color? _appBarColor;

  User? user_info;
  List<Challenge>? future;
  List<Challenge>? current;
  List<Challenge>? past;
  Map<String, dynamic>? detail;

  var snappingSheetController = SnappingSheetController();
  final ScrollController listViewController = ScrollController();
  final scaffoldKey2 = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    ProfilServices.get_my_user_info().then((value) {
      print(value);
      future =
          Challenge.fromJsonList(value["response"]["challenge_info"]["future"]);
      current = Challenge.fromJsonList(
          value["response"]["challenge_info"]["current"]);
      past =
          Challenge.fromJsonList(value["response"]["challenge_info"]["past"]);
      user_info = User.fromJson(value["response"]["user_info"]);

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (user_info != null) {
      return Scaffold(
          key: scaffoldKey2,
          backgroundColor: Color(0xFFECE9FF),
            body: SnappingSheet(

  controller: snappingSheetController,
  lockOverflowDrag: true,
  snappingPositions: [
    /// Sheet pozisyon
    SnappingPosition.factor(
      snappingCurve: Curves.easeInOutCubicEmphasized,
      positionFactor: 0.0,
      snappingDuration: Duration(milliseconds: 600),
      grabbingContentOffset: GrabbingContentOffset.top,
    ),
    SnappingPosition.factor(
      snappingCurve: Curves.easeInOutCubicEmphasized,
      snappingDuration: Duration(milliseconds: 400),
      positionFactor: 0.6,
    ),
    SnappingPosition.pixels(
      snappingCurve: Curves.easeInOutCubicEmphasized,
      grabbingContentOffset: GrabbingContentOffset.bottom,
      snappingDuration: Duration(milliseconds: 80),
      positionPixels: MediaQuery.of(context).size.height,
    ),
  ],



  sheetBelow: sheetAbove(context:context, detail:detail?["challenge"], MyPageState:_myUserProfilPageState(), controller:snappingSheetController, listViewController:listViewController),
  child: NestedScrollView(
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverAppBar(
          title: Text(
            "Hello",
            style: TextStyle(color: Colors.black87),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push (
                  context,
                  MaterialPageRoute (
                    builder: (BuildContext context) => const editPage(),
                  ),
                );
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push (
                  context,
                  MaterialPageRoute (
                    builder: (BuildContext context) => settingsPage(),
                  ),
                );
              },
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
            ),
          ],
          pinned: false,
          floating: false,
          forceElevated: innerBoxIsScrolled,



        ),
      ];
},
    body:  ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push (
                          context,
                          MaterialPageRoute (
                            builder: (BuildContext context) => const editPage(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(),
                        child: Container(
                          height: 150,
                          width: 150,
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child:CircleAvatar(
                              backgroundImage:NetworkImage("${BASE_URL + user_info!.profile_image}", // No matter how big it is, it won't overflow
                              ),
                            ),
                            color: Colors.red,
                          ),
                        ),
                      ),),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "${user_info!.first_name} ${user_info!.last_name}",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 30),
                      child: Text(
                        "@${user_info!.username}",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                                child: ListView.builder(

                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: current!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                          padding: EdgeInsets.only(
                                              top: 10,
                                              bottom: 30,
                                              left: 20,
                                              right: 20),
                                          child: GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                snappingSheetController
                                                    .snapToPosition(
                                                    SnappingPosition.factor(
                                                      positionFactor: 0,
                                                    ));
                                                detail = {"time":"current", "challenge":current![index]};
                                              });
                                              await Future.delayed(
                                                  Duration(seconds: 1));

                                              snappingSheetController
                                                  .snapToPosition(
                                                  SnappingPosition.factor(
                                                    positionFactor: 0.6,
                                                  ));
                                            },
                                            child: Card(
                                              elevation: 5,
                                              margin: EdgeInsets.fromLTRB(
                                                  0.0, 0.0, 0.0, 16.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(30),
                                              ),
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                            EdgeInsets.all(
                                                                0),
                                                            child: Text(
                                                              "Oynanıyor",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 15),
                                                            )),
                                                        Padding(
                                                            padding:
                                                            EdgeInsets.all(
                                                                0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  color: Color(
                                                                      0xFF525252),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                      left:
                                                                      8,
                                                                      right:
                                                                      8),
                                                                  child: Text(
                                                                    current![index].place.name,
                                                                    /* userdetail["historys"][index]
                                                        .place
                                                        .name
                                                        .length >
                                                        25
                                                        ? userdetail["historys"][index]
                                                        .place
                                                        .name
                                                        .substring(0, 15) +
                                                        '...'
                                                        : userdetail["historys"][index]
                                                        .place
                                                        .name,*/
                                                                    style:
                                                                    TextStyle(
                                                                      color: Color(
                                                                          0xFF525252),
                                                                      fontSize:
                                                                      12,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                                right: 15),
                                                            child: Text(
                                                              "36",
                                                              style: TextStyle(
                                                                fontSize: 30,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700,
                                                                color: Color(
                                                                    0xFF525252),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                                left: 15),
                                                            child: Text(
                                                              "36",
                                                              style: TextStyle(
                                                                fontSize: 30,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700,
                                                                color: Color(
                                                                    0xFF525252),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 20, top: 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                                top: 10),
                                                            child: Text(
                                                              "${current![index].gameSize.nof} vs ${current![index].gameSize.nof}",
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700,
                                                                color: Color(
                                                                    0xFF525252),
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ));
                                    })),
                            Flexible(
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    reverse: false,
                                    itemCount: future!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: 30,
                                            left: 20,
                                            right: 20),
                                        child:GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                snappingSheetController
                                                    .snapToPosition(
                                                    SnappingPosition.factor(
                                                      positionFactor: 0,
                                                    ));
                                                detail = {"type":"future", "challenge":future![index]};
                                              });
                                              await Future.delayed(
                                                  Duration(seconds: 1));

                                              snappingSheetController
                                                  .snapToPosition(
                                                  SnappingPosition.factor(
                                                    positionFactor: 0.6,
                                                  ));
                                            },
                                            child: Card(
                                              elevation: 5,
                                              margin: EdgeInsets.fromLTRB(
                                                  0.0, 0.0, 0.0, 16.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(30),
                                              ),
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          EdgeInsets.all(0),
                                                          child: Text("Oynanıcak"),
                                                        ),
                                                        Padding(
                                                            padding:
                                                            EdgeInsets.all(0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                              children: [
                                                                Icon(
                                                                  Icons.location_on,
                                                                  color: Color(
                                                                      0xFF525252),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                      left: 8,
                                                                      right: 8),
                                                                  child: Text(
                                                                    future![index].place.name,
                                                                    /* userdetail["historys"][index]
                                                        .place
                                                        .name
                                                        .length >
                                                        25
                                                        ? userdetail["historys"][index]
                                                        .place
                                                        .name
                                                        .substring(0, 15) +
                                                        '...'
                                                        : userdetail["historys"][index]
                                                        .place
                                                        .name,*/
                                                                    style:
                                                                    TextStyle(
                                                                      color: Color(
                                                                          0xFF525252),
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                      EdgeInsets.only(top: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                                right: 15),
                                                            child: Text(
                                                              "36",
                                                              style: TextStyle(
                                                                fontSize: 30,
                                                                fontWeight:
                                                                FontWeight.w700,
                                                                color: Color(
                                                                    0xFF525252),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                                left: 15),
                                                            child: Text(
                                                              "36",
                                                              style: TextStyle(
                                                                fontSize: 30,
                                                                fontWeight:
                                                                FontWeight.w700,
                                                                color: Color(
                                                                    0xFF525252),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 20, top: 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                                top: 10),
                                                            child: Text(
                                                              "${future![index].gameSize.nof} Vs ${future![index].gameSize.nof}",
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                FontWeight.w700,
                                                                color: Color(
                                                                    0xFF525252),
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      );

                                    })
                            ),
                            Flexible(
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: past!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                          padding: EdgeInsets.only(
                                              top: 10,
                                              bottom: 30,
                                              left: 20,
                                              right: 20),
                                          child:GestureDetector(
                                            onTap: ()async {
                                              setState(() {
                                                snappingSheetController
                                                    .snapToPosition(
                                                    SnappingPosition.factor(
                                                      positionFactor: 0,
                                                    ));
                                                detail = {"type":"past", "challenge":past![index]};
                                              });
                                              await Future.delayed(
                                                  Duration(seconds: 1));

                                              snappingSheetController
                                                  .snapToPosition(
                                                  SnappingPosition.factor(
                                                    positionFactor: 0.6,
                                                  ));
                                            },
                                            child: Card(
                                              elevation: 5,
                                              margin: EdgeInsets.fromLTRB(
                                                  0.0, 0.0, 0.0, 16.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(30),
                                              ),
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          EdgeInsets.all(0),
                                                          child: Text("oynandı"),
                                                        ),
                                                        Padding(
                                                            padding:
                                                            EdgeInsets.all(0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                              children: [
                                                                Icon(
                                                                  Icons.location_on,
                                                                  color: Color(
                                                                      0xFF525252),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                      left: 8,
                                                                      right: 8),
                                                                  child: Text(
                                                                    past![index].place.name,
                                                                    /* userdetail["historys"][index]
                                                        .place
                                                        .name
                                                        .length >
                                                        25
                                                        ? userdetail["historys"][index]
                                                        .place
                                                        .name
                                                        .substring(0, 15) +
                                                        '...'
                                                        : userdetail["historys"][index]
                                                        .place
                                                        .name,*/
                                                                    style:
                                                                    TextStyle(
                                                                      color: Color(
                                                                          0xFF525252),
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                      EdgeInsets.only(top: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                                right: 15),
                                                            child: Text(
                                                              "36",
                                                              style: TextStyle(
                                                                fontSize: 30,
                                                                fontWeight:
                                                                FontWeight.w700,
                                                                color: Color(
                                                                    0xFF525252),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                                left: 15),
                                                            child: Text(
                                                              "36",
                                                              style: TextStyle(
                                                                fontSize: 30,
                                                                fontWeight:
                                                                FontWeight.w700,
                                                                color: Color(
                                                                    0xFF525252),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 20, top: 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                                top: 10),
                                                            child: Text(
                                                              "${past![index].gameSize.nof} Vs ${past![index].gameSize.nof}",
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                FontWeight.w700,
                                                                color: Color(
                                                                    0xFF525252),
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                      );
                                    })),
                          ]))),
            ],
          ),
        )),)


) ,



      );
    } else {
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
