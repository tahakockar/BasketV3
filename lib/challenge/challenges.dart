
import 'package:basketv2/ArGe.dart';
import 'package:basketv2/challenge/api.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import '../configuration/widgets.dart';
import 'construction.dart';

class challengesPage extends StatefulWidget {
  const challengesPage({Key? key}) : super(key: key);

  @override
  _challengesPageState createState() => _challengesPageState();
}



class _challengesPageState extends State<challengesPage> {

  final ScrollController listViewController = ScrollController();
  var snappingSheetController = SnappingSheetController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Challenge>? data;
  Challenge? detail;

  @override
  void initState() {
    ChallengeServices.get_challenges().then((value) {
      print(value);
      data = Challenge.fromJsonList(value["response"]);
      setState(() {});
    });

    super.initState();
  }

  Future<void> loadData() async {
    var val = await ChallengeServices.get_challenges();

    data = Challenge.fromJsonList(val["response"]);
    setState(() {});
  }

  List deneme = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin iaculis egestas eros ut porttitor",
    "Vestibulum tincidunt tincidunt neque eget varius. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nulla tristique lorem ut pharetra maximus. Curabitur ipsum dolor",
    "hello3",
    "hello5",
    "hello4",
  ];


  @override
  Widget build(BuildContext context) {
    if (data != null) {
      return Scaffold(
          extendBody: true,
          key: scaffoldKey,
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
                  positionPixels: MediaQuery.of(context).size.height ,
                )
              ],

              /// Sheet içi
              sheetBelow: sheetAbove(context:context, detail:detail, MyPageState:_challengesPageState, controller:snappingSheetController, listViewController:listViewController),



              child: CustomRefreshIndicator(
                builder: MaterialIndicatorDelegate(
                  builder: (context, controller) {
                    return Icon(
                      Icons.sports_basketball_outlined,
                      color: Colors.orange,
                      size: 30,
                    );
                  },
                ),
                onRefresh: loadData,
                child: Container(
                    child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ///  Logo Ve Bildirim
                                SizedBox(
                                  height: 100,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      /// Logo
                                   GestureDetector(
                                  onTap: (){},
                                      child:Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: Icon(
                                              Icons.sports_basketball_outlined,
                                              size: 60,
                                              color: Colors.orange,
                                            )),),


                                      /// Bildirim
                                      PopupMenuButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)),

                                        elevation: 0,
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                right: 20,
                                                top: 10,
                                                bottom: 5),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        40)),
                                                width: 50,
                                                height: 50,
                                                child: Container(
                                                  child: Center(
                                                    child: Icon(Icons
                                                        .notifications_active),
                                                  ),
                                                ))),
                                        position: PopupMenuPosition.under,

                                        constraints: BoxConstraints(
                                          minWidth: 2.0 * 56.0,
                                          maxWidth: MediaQuery.of(context).size.width,
                                          maxHeight: 300,
                                        ),
                                        itemBuilder: (context) => List.generate(deneme.length, (index) =>
                                            PopupMenuItem(
                                              padding: EdgeInsets.all(10),
                                              
                                                child: ListTile(

                                                  title:Text("Challanges"),
                                                  subtitle: Text("${deneme[index]}"),
                                                  trailing: Icon(Icons.star,color: Colors.deepOrange,size: 15,),
                                                )
                                            )),
                                      )


                                    ],
                                  ),
                                ),

                                /// Challenges card
                                Flexible(
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        reverse:true,
                                        shrinkWrap: true,
                                        itemCount: data!.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 30,
                                                  left: 20,
                                                  right: 20),
                                              child: GestureDetector(
                                                /// Challenges Card Tıklama Fonksiyonu
                                                onTap: () async {
                                                  setState(() {
                                                    snappingSheetController.snapToPosition(
                                                        SnappingPosition
                                                            .factor(
                                                          positionFactor: 0,
                                                        ));
                                                    detail = data![index];
                                                  });
                                                  await Future.delayed(Duration(seconds: 1));

                                                  snappingSheetController
                                                      .snapToPosition(
                                                          SnappingPosition
                                                              .factor(
                                                    positionFactor: 0.6,
                                                  ));

                                                  /*var get_detail =
                                                      await ChallengeServices
                                                          .get_challange_detail(
                                                              data![index].id);
                                                  setState(() {
                                                    detail = Challenge.fromJson(
                                                        get_detail["response"]);
                                                  });*/
                                                },
                                                child: Card(
                                                  elevation: 5,
                                                  margin: EdgeInsets.all(0),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  color: Color(0xFFA597FF),
                                                  child: Column(
                                                    children: [
                                                      /// Card üst alan
                                                      Padding(
                                                        padding: EdgeInsets.all(10),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            /// Card Sol Basket Logosu
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(0),
                                                              child: Icon(
                                                                Icons
                                                                    .sports_basketball,
                                                                color: Colors
                                                                    .white,
                                                                size: 40,
                                                              ),
                                                            ),

                                                            /// Card Sağ Üst Wigetlar
                                                            Padding(
                                                                padding: EdgeInsets.all(0),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  children: [
                                                                    Column(
                                                                      children: [
                                                                        /// Konum iconu ve konum
                                                                        Padding(
                                                                            padding: EdgeInsets.only(left: 20, right: 0),
                                                                            child: Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.location_on,
                                                                                  color: Colors.white,
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(left: 5, right: 10),
                                                                                  child: Text(
                                                                                    data![index].place.name.length > 20 ? data![index].place.name.substring(0, 15) + '...' : data![index].place.name,
                                                                                    style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            )),

                                                                        /// Tarih
                                                                        Padding(
                                                                            padding:
                                                                                EdgeInsets.only(top: 0, left: 80),
                                                                            child: Text(
                                                                              DateFormat("dd MMMM EEEE", 'tr_TR').format(DateTime.parse(data![index].start_time)),
                                                                              style: TextStyle(color: Colors.white, fontSize: 15),
                                                                            ))


                                                                      ],
                                                                    )
                                                                  ],
                                                                ))


                                                          ],
                                                        ),
                                                      ),

                                                      /// card 3/6
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5),
                                                        child: Center(
                                                          child: Text(
                                                            "${data![index].players.length}/${data![index].gameSize.max_players}",
                                                            style: TextStyle(
                                                                fontSize: 35,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),

                                                      /// Card 3vs3
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          bottom: 15,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            10),
                                                                child: Text(
                                                                  "${data![index].gameSize.nof}v${data![index].gameSize.nof}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color: Colors
                                                                          .white),
                                                                ))
                                                          ],
                                                        ),
                                                      ),


                                                    ],
                                                  ),
                                                ),
                                              ));
                                        })),


                              ]);
                        })),

                /// AppBar ve Body
              ))
      );
    } else {
      /// Page Loading
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