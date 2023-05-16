import 'package:basketv2/challenge/api.dart';
import 'package:basketv2/challenge/construction.dart';
import 'package:basketv2/configuration/settings.dart';
import 'package:basketv2/profil/userProfilPage.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import '../YardimciWidgetlar.dart';
import '../bottomNavigationBarPage.dart';

SnappingSheetContent sheetAbove(
    {required BuildContext context,
      Challenge? detail,
      MyPageState,
      required SnappingSheetController controller,
      required ScrollController listViewController,
      bool? is_show_join
    }) {
  if (detail != null) {
    String _date =
    DateFormat("dd.MM.yyyy").format(DateTime.parse(detail!.start_time));
    String _start_time =
    DateFormat("HH:mm").format(DateTime.parse(detail!.start_time));
    String _end_time =
    DateFormat("HH:mm").format(DateTime.parse(detail!.end_time));
    String _place = detail!.place.name;

    return SnappingSheetContent(

      ///Detail Sheet
        draggable: true,
        childScrollController: listViewController,
        child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Color(0xFFECE9FF),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Container(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView.builder(
                  controller: listViewController,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            /// Kaldırma çizgisi
                            Container(
                              height: 50,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 15),
                                    child: Container(
                                      width: 100,
                                      height: 7,
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// Resim
                            Container(
                              height: 250,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8,
                                    color: Colors.grey,
                                    offset: Offset(0.1, 6),
                                  ),
                                ],
                              ),
                              child: Padding(
                                  padding: EdgeInsets.only(),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      "https://www.sabancivakfi.org/i/content/1286_1_rsz_dilek_sabanci_parki_5.jpg",
                                    ),
                                  )),
                            ),

                            /// Konum , Saat , Tarih , Katılan Oyuncular
                            Padding(
                              padding: EdgeInsets.only(top: 30, bottom: 30),
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Maç sahası ismi
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 40, left: 25, top: 10),
                                      child: Text(
                                        _place,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),

                                    /// Maç Takvimi
                                    ListTile(
                                      leading: Icon(
                                        Icons.calendar_month,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      title: Transform.translate(
                                        offset: Offset(-12, 0),
                                        child: Text(
                                          _date,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),

                                    /// Aralık
                                    Transform.translate(
                                      offset: Offset(-0, -10),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: DottedDashedLine(
                                          height: 40,
                                          width: 0,
                                          axis: Axis.vertical,
                                          dashHeight: 3,
                                          dashSpace: 4,
                                        ),
                                      ),
                                    ),

                                    /// Maç Saati
                                    Transform.translate(
                                      offset: Offset(
                                        -0,
                                        -20,
                                      ),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.access_time_sharp,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        title: Transform.translate(
                                          offset: Offset(-12, 0),
                                          child: Text(
                                            "${_start_time} - ${_end_time}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ),

                                    ///Aralık
                                    Transform.translate(
                                      offset: Offset(
                                        -0,
                                        -30,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 30, bottom: 5),
                                        child: DottedDashedLine(
                                          height: 40,
                                          width: 0,
                                          axis: Axis.vertical,
                                          dashHeight: 3,
                                          dashSpace: 4,
                                        ),
                                      ),
                                    ),

                                    /// Maç Konumu
                                    Transform.translate(
                                      offset: Offset(
                                        -0,
                                        -45,
                                      ),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        title: Transform.translate(
                                          offset: Offset(-12, 0),
                                          child: Text(
                                            "Levent, Dilek Sabancı Parkı, 34330 Beşiktaş/İstanbul",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ),

                                    /// Aralık
                                    Transform.translate(
                                      offset: Offset(
                                        -0,
                                        -55,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 30, bottom: 5),
                                        child: DottedDashedLine(
                                          height: 30,
                                          width: 0,
                                          axis: Axis.vertical,
                                          dashHeight: 3,
                                          dashSpace: 4,
                                        ),
                                      ),
                                    ),

                                    /// Katılan Oyuncular
                                    Transform.translate(
                                      offset: Offset(
                                        -0,
                                        -70,
                                      ),
                                      child: Theme(
                                        data: ThemeData(
                                          dividerColor: Colors.transparent,
                                        ),
                                        child: ExpansionTile(
                                          expandedCrossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          trailing: Icon(Icons
                                              .keyboard_arrow_down_rounded),
                                          leading: Icon(
                                            Icons.person,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          title: Container(
                                            padding: EdgeInsets.only(right: 80),
                                            height: 30,
                                            child: FlutterImageStack(
                                              imageList: List<String>.generate(
                                                  detail!.players.length,
                                                      (index) =>
                                                  BASE_URL +
                                                      detail!.players[index]
                                                          .profile_image),
                                              showTotalCount: true,
                                              totalCount:
                                              detail!.players.length,
                                              itemRadius: 60,
                                              itemCount: 3,
                                              itemBorderWidth: 2,
                                            ),
                                          ),
                                          children: [
                                            SizedBox(
                                              child: ListView.builder(
                                                  physics:
                                                  NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                  detail!.players.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (BuildContext
                                                              context) =>
                                                                  userProfilPage(id:detail!.players[index].id,),
                                                            ),
                                                          );
                                                        },
                                                        child: Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                              bottom: 20,
                                                              top: 30,
                                                            ),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      20)),
                                                              child: Card(
                                                                shape:
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      20),
                                                                  //set border radius more than 50% of height and width to make circle
                                                                ),
                                                                color: Colors.white,
                                                                child: ListTile(
                                                                  contentPadding:
                                                                  EdgeInsets
                                                                      .all(
                                                                      10),
                                                                  leading:
                                                                  CircleAvatar(
                                                                    backgroundColor:
                                                                    Colors
                                                                        .orange,
                                                                    child: Icon(
                                                                      Icons
                                                                          .person,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  title: Text(
                                                                    detail!
                                                                        .players[
                                                                    index]
                                                                        .first_name +
                                                                        " " +
                                                                        detail!
                                                                            .players[index]
                                                                            .last_name,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  subtitle:
                                                                  Text(
                                                                    "@" +
                                                                        detail!
                                                                            .players[index]
                                                                            .username,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black54),
                                                                  ),
                                                                  trailing:
                                                                  IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (BuildContext context) =>
                                                                              userProfilPage(
                                                                                id: detail!.players[index].id,
                                                                              ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    icon: Icon(
                                                                        Icons.arrow_forward_ios,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                              ),
                                                            )));
                                                  }),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            /// Katıl Butonu

                            detail.can_join == true
                                ? Transform.translate(
                                offset: Offset(
                                  -0,
                                  -50,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 3,
                                        backgroundColor: Colors.white,
                                        shape: StadiumBorder()),
                                    onPressed: () async {
                                      var x = await ChallengeServices
                                          .join_challenge(detail!.id);


                                      if(x["succes"] == true){
                                        Navigator.push (
                                          context,
                                          MaterialPageRoute (
                                            builder: (BuildContext context) =>  bottomNavigationBarPage(index: 0,),
                                          ),
                                        );

                                      }else{
                                        error(context: context,title:x["error"]["title"]  ,error_content: x["error"]["message"]);
                                      }


                                    },
                                    child: Container(
                                      height: 50,
                                      width: 90,
                                      child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "Katıl",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.black,
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                ))
                                : Transform.translate(
                                offset: Offset(
                                  -0,
                                  -50,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 3,
                                        backgroundColor: Colors.red,
                                        shape: StadiumBorder()),
                                    onPressed: () async{

                                      var x = await ChallengeServices
                                          .leave_challenge(detail!.id);
                                      print(x);

                                      if(x["succes"] == true){
                                        Navigator.push (
                                          context,
                                          MaterialPageRoute (
                                            builder: (BuildContext context) =>  bottomNavigationBarPage(index: 0,),
                                          ),
                                        );

                                      }else{
                                        error(context: context,title:x["error"]["title"]  ,error_content: x["error"]["message"]);
                                      }

                                    },
                                    child: Container(
                                      height: 50,
                                      width: 90,
                                      child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "Ayrıl",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17),
                                              ),
                                              Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                ))
                          ],
                        ));
                  },
                ),
              ),
            )));
  } else {
    return SnappingSheetContent(

      ///Detail Sheet
        draggable: true,
        childScrollController: listViewController,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Container(
              color: Colors.white,
              child: Center(
                  child: CircularProgressIndicator(
                      color: Colors.black54,
                      strokeWidth: 1,
                      backgroundColor: Colors.grey))),
        ));
  }
}



void error({required BuildContext context, String? title, required String error_content}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.withOpacity(0.9),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          elevation: 0,
          title: Text(
            title != null? title!: "Sorun Oluştu",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            error_content,
            style: TextStyle(color: Colors.white),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            MaterialButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Tamam",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      });
}
