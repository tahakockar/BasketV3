import 'package:basketv2/challenge/api.dart';
import 'package:basketv2/challenge/construction.dart';
import 'package:basketv2/configuration/dataBase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../bottomNavigationBarPage.dart';
import '../configuration/settings.dart';
import '../configuration/widgets.dart';


class createChallangePage extends StatefulWidget {
  const createChallangePage({Key? key}) : super(key: key);

  @override
  _createChallangePageState createState() => _createChallangePageState();
}

//_selected_gameSize size boşsa hata mesajı veer

class _createChallangePageState extends State<createChallangePage>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;
  TextEditingController _search = TextEditingController();


  List dates = [];
  String? _token;
  List<BasketPlace>? _places;

  DateTime? _start_date;
  DateTime _end_time = DateTime.now();
  int? _selected_gameSize;
  BasketPlace? _selected_place;

  @override
  void initState() {
    DatabaseService().readDatabase().then((value) {
      _token = value["token"];
      setState(() {});
    });

    _tabController = TabController(length: 3, vsync: this);
    xxx();
    super.initState();
  }

  void xxx() {
    dates.clear();
    for (var i = 2; i >= 1; i--) {
      DateTime after = _start_date == null
          ? DateTime.now().add(Duration(days: i))
          : _start_date!.add(Duration(days: i));
      dates.add(
          {"date": after, "color": Color(0xFF2C2C2C)}); // yanlarındaki tarih
    }
    dates.add({
      "date": _start_date == null ? DateTime.now() : _start_date,
      "color": Colors.white10
    }); //Seçilern Tarih

    for (var i = 1; i <= 2; i++) {
      DateTime last = _start_date == null
          ? DateTime.now().subtract(Duration(days: i))
          : _start_date!.subtract(Duration(days: i));

      dates.add(
          {"date": last, "color": Color(0xFF2C2C2C)}); // yanlarındaki tarih
    }

    print(dates);
  }

  Future<void> _getPlace(String? filter) async {
    var response = await Dio().get("${BASE_URL}/api/search-place",
        queryParameters: {"search": filter},
        options: Options(
          headers: {
            "Authorization": "Token ${_token!}",
          },
        ));
    setState(() {
      _places = BasketPlace.fromJsonList(response.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_token != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: true,
          leading:Padding(

            padding: EdgeInsets.only(left: 20),
            child:IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon:Icon( Icons.arrow_back_ios,),
              color: Colors.black,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          elevation: 0,

          label:Icon(Icons.send),

          icon:  Text("Creat") ,
          backgroundColor: Colors.black,


          onPressed: () async {
            // veriler boş mu diye kontrol edilicek

            if(_start_date != null && _end_time != null && _selected_gameSize != null && _selected_place != null ){
              print(_start_date);
              Map<String, dynamic> data = {
                "start_time": _start_date!.toIso8601String(),
                "end_time": _end_time!.toIso8601String(),
                "game_size": {"id": _selected_gameSize!.toInt()},
                "place": {"id": _selected_place!.id!.toInt()}
              };
              print(data);
              ChallengeServices.create_challenge(data)
                  .then((value){
                    if(value["succes"]){
                      Navigator.push (
                        context,
                        MaterialPageRoute (
                          builder: (BuildContext context) => bottomNavigationBarPage(index: 0,),
                        ),
                      );
                    }else{
                      error(context: context, error_content: value["message"]);
                    }
              });
            }else{
              error(context: context, title: "Boş yer bırakma!" ,error_content: "Tüm yerleri doldurun");

            }
            }



        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(left: 30,bottom: 20,top: 0),
                    child:Text("Kaça Kaç",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),)
                ),
                SizedBox(
                    height: 120,
                    child: ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          index = index + 1;
                          return Padding(
                              padding: EdgeInsets.only(right: 20, left: 10),
                              child: SizedBox(
                                height: 70,
                                width: 80,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selected_gameSize = index;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: _selected_gameSize == index
                                            ? Colors.black
                                            : Colors.black54,
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    child: Center(
                                      child: Text(
                                        "${index}v${index}",
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                        })),
                Padding(padding: EdgeInsets.only(left: 30,bottom: 20,top: 30),
                    child:Text("Oynanacak Tarih ve Saat",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),)
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: GestureDetector(
                      onTap: () {
                        _tabController.index = 0;
                        showDialog(
                            barrierColor: Colors.black.withAlpha(200),
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return Dialog(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        1.6,
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(children: [
                                      // TabBar ekleyeceğimiz yer
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            bottom: 30,
                                            top: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                  _tabController.index >= 0
                                                      ? Colors.black
                                                      : Colors.grey,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      20)),
                                              width: 40,
                                              height: 5,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                  _tabController.index >= 1
                                                      ? Colors.black
                                                      : Colors.grey,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      20)),
                                              width: 40,
                                              height: 5,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                  _tabController.index >= 2
                                                      ? Colors.black
                                                      : Colors.grey,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      20)),
                                              width: 40,
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),

                                      // TabBarView ekleyeceğimiz yer
                                      Expanded(
                                        child: TabBarView(
                                          physics:
                                          NeverScrollableScrollPhysics(),
                                          controller: _tabController,
                                          // TabBarView içeriğini burada ayarlayabilirsiniz
                                          children: [
                                            Container(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 5,
                                                        bottom: 10,
                                                        left: 10),
                                                    child: Text(
                                                      "Oynanacak Tarih",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 280,
                                                    child: SfDateRangePicker(
                                                      initialSelectedDate:
                                                      _start_date,
                                                      selectionColor: Colors
                                                          .deepOrangeAccent,
                                                      selectionShape:
                                                      DateRangePickerSelectionShape
                                                          .circle,
                                                      showNavigationArrow: true,
                                                      selectionMode:
                                                      DateRangePickerSelectionMode
                                                          .single,
                                                      onSelectionChanged:
                                                          (DateRangePickerSelectionChangedArgs
                                                      args) {
                                                        if (args.value !=
                                                            null) {
                                                          setState(() {
                                                            _start_date =
                                                                args.value;
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: Icon(
                                                                Icons.clear),
                                                          ),
                                                          IconButton(
                                                            onPressed: () =>
                                                                setState(
                                                                      () {
                                                                    if (_start_date !=
                                                                        null) {
                                                                      _tabController
                                                                          .animateTo(
                                                                          (_tabController.index + 1) %
                                                                              2);
                                                                    } else {
                                                                      print(
                                                                          "tarih seç lütfen");

                                                                      error(context: context,title: "Bilgilendirme", error_content: "tarih seç lütfen");
                                                                    }
                                                                  },
                                                                ),
                                                            icon: Icon(Icons
                                                                .arrow_forward_ios),
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 5,
                                                        bottom: 10,
                                                        left: 10),
                                                    child: Text(
                                                      "Başlangıç Saati",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 280,
                                                    child: TimePickerSpinner(
                                                      time: DateTime(
                                                          DateTime.now().year,
                                                          DateTime.now().month,
                                                          DateTime.now().day,
                                                          0,
                                                          0),
                                                      minutesInterval: 5,
                                                      is24HourMode: true,
                                                      normalTextStyle:
                                                      TextStyle(
                                                          fontSize: 24,
                                                          color:
                                                          Colors.grey),
                                                      highlightedTextStyle:
                                                      TextStyle(
                                                          fontSize: 24,
                                                          color:
                                                          Colors.black),
                                                      spacing: 50,
                                                      itemHeight: 80,
                                                      isForce2Digits: true,
                                                      onTimeChange: (time) {
                                                        setState(() {
                                                          _start_date =
                                                              DateTime(
                                                                  _start_date!
                                                                      .year,
                                                                  _start_date!
                                                                      .month,
                                                                  _start_date!
                                                                      .day,
                                                                  time!.hour,
                                                                  time!.minute);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                        children: [
                                                          IconButton(
                                                            onPressed: () =>
                                                                setState(
                                                                      () {
                                                                    _tabController
                                                                        .animateTo(
                                                                        (_tabController.index -
                                                                            1) %
                                                                            2);
                                                                  },
                                                                ),
                                                            icon: Icon(Icons
                                                                .arrow_back_ios),
                                                          ),
                                                          IconButton(
                                                            onPressed: () =>
                                                                setState(
                                                                      () {
                                                                    print(
                                                                        _start_date);
                                                                    _tabController
                                                                        .animateTo(
                                                                        (_tabController.index +
                                                                            1) %
                                                                            3);
                                                                    print(
                                                                        _tabController
                                                                            .index);
                                                                  },
                                                                ),
                                                            icon: Icon(Icons
                                                                .arrow_forward_ios),
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 5,
                                                        bottom: 10,
                                                        left: 10),
                                                    child: Text(
                                                      "Bitiş Saati",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 280,
                                                    child: TimePickerSpinner(
                                                      minutesInterval: 5,
                                                      time: DateTime(
                                                          _start_date == null
                                                              ? DateTime.now()
                                                              .year
                                                              : _start_date!
                                                              .year,
                                                          _start_date == null
                                                              ? DateTime.now()
                                                              .month
                                                              : _start_date!
                                                              .month,
                                                          _start_date == null
                                                              ? DateTime.now()
                                                              .day
                                                              : _start_date!
                                                              .day,
                                                          0,
                                                          0),
                                                      is24HourMode: true,
                                                      normalTextStyle:
                                                      TextStyle(
                                                          fontSize: 24,
                                                          color:
                                                          Colors.grey),
                                                      highlightedTextStyle:
                                                      TextStyle(
                                                          fontSize: 24,
                                                          color:
                                                          Colors.black),
                                                      spacing: 50,
                                                      itemHeight: 80,
                                                      isForce2Digits: true,
                                                      onTimeChange: (time) {
                                                        setState(() {
                                                          _end_time = DateTime(
                                                              _start_date!.year,
                                                              _start_date!
                                                                  .month,
                                                              _start_date!.day,
                                                              time!.hour,
                                                              time!.minute);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                        children: [
                                                          IconButton(
                                                            onPressed: () =>
                                                                setState(
                                                                      () {
                                                                    _tabController
                                                                        .animateTo(
                                                                        (_tabController.index -
                                                                            1) %
                                                                            3);
                                                                    print(
                                                                        _tabController
                                                                            .index);
                                                                  },
                                                                ),
                                                            icon: Icon(Icons
                                                                .arrow_back_ios),
                                                          ),
                                                          IconButton(
                                                            onPressed: () {
                                                              int query =
                                                              _start_date!
                                                                  .compareTo(
                                                                  _end_time);
                                                              if (query > 0) {
                                                                print(
                                                                    "başlangıç saati bitiş saatinden büyük olamaz");
                                                                error(context: context, title:"Bilgilendirme", error_content: "başlangıç saati bitiş saatinden büyük olamaz");
                                                              } else {
                                                                int fark = _end_time
                                                                    .difference(
                                                                    _start_date!)
                                                                    .inMinutes;
                                                                if (fark < 30) {
                                                                  error(context: context,title:"Bilgilendirme",error_content: "en az 30 dk maç oynayabilirsi");
                                                                  print(
                                                                      "en az 30 dk maç oynayabilirsin");
                                                                } else {
                                                                  Navigator.pop(
                                                                      context);
                                                                  print(
                                                                      _start_date);
                                                                  print(
                                                                      _end_time);
                                                                }
                                                              }
                                                            },
                                                            icon: Icon(
                                                              Icons.check,
                                                              size: 35,
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ),
                                );
                              });
                            });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF2C2C2C),
                              borderRadius: BorderRadius.circular(20)),
                          width: double.infinity,
                          child: Center(
                              child: SizedBox(
                                height: 150,
                                child: Padding(
                                    padding: EdgeInsets.only(top: 5, left: 10),
                                    child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Icon(
                                              Icons.calendar_month,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Flexible(
                                            child: ListView.builder(
                                                itemCount: dates.length,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 10,
                                                          left: 10,
                                                          bottom: 10,
                                                          top: 10),
                                                      child: SizedBox(
                                                        height: 150,
                                                        width: 45,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: dates[index]
                                                              ["color"],

                                                              ///
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  15)),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Container(
                                                                  height: 35,
                                                                  width: 35,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          40),
                                                                      color: Color(
                                                                          0xFFA597FF),
                                                                      border:
                                                                      Border
                                                                          .all(
                                                                        color: Color(
                                                                            0xFFA597FF),
                                                                        width:
                                                                        1,
                                                                      )),
                                                                  child: Center(
                                                                    child: Text(
                                                                      dates![index][
                                                                      "date"]
                                                                          .day
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                          16),
                                                                    ),
                                                                  )),
                                                              Padding(
                                                                padding:
                                                                EdgeInsets.only(
                                                                    top: 10),
                                                                child: Text(
                                                                  DateFormat("EEE",
                                                                      'tr_TR')
                                                                      .format(dates![
                                                                  index]
                                                                  ["date"]),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: 13,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ));
                                                }),
                                          ),
                                        ])),
                              )))),
                ),
                Padding(padding: EdgeInsets.only(left: 30,bottom: 20,top: 30),
                    child:Text("Oynanacak Yer",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),)
                ),
                GestureDetector(
                  onTap: () async {
                    await _getPlace("");

                    showDialog(
                        barrierColor: Colors.black.withAlpha(200),
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            setState(() {});
                            return Dialog(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: _search,
                                        onChanged: (x) async {
                                          await _getPlace(x);
                                          setState(() {});
                                        },
                                        cursorColor: Colors.black,
                                        cursorWidth: 1,
                                        decoration: InputDecoration(
                                          hintText: "Ara",
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: Colors.grey,
                                          ),
                                          prefixIconColor: Colors.grey,
                                          filled: true,
                                          fillColor: Colors.grey.shade300,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                          child: ListView.separated(
                                              separatorBuilder:
                                                  (BuildContext context,
                                                  int index) =>
                                                  Container(
                                                    height: 1,
                                                    color: Colors.grey,
                                                    width: double.infinity,
                                                  ),
                                              itemCount: _places?.length == null
                                                  ? 0
                                                  : _places!.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                  int index) {
                                                return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        _selected_place =_places![index];
                                                        });
                                                      Navigator.pop(context, _places![index]);

                                                    },
                                                    child: Padding(
                                                        padding:
                                                        EdgeInsets.all(20),
                                                        child: SizedBox(
                                                          height: 200,
                                                          width: 100,
                                                          child: Container(
                                                            decoration:
                                                            BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10),
                                                              image:
                                                              DecorationImage(
                                                                fit:
                                                                BoxFit.fill,
                                                                colorFilter:
                                                                ColorFilter
                                                                    .mode(
                                                                  Colors.black
                                                                      .withOpacity(
                                                                      0.5),
                                                                  BlendMode
                                                                      .luminosity,
                                                                ),
                                                                image:
                                                                NetworkImage(
                                                                  BASE_URL +
                                                                      _places![
                                                                      index]
                                                                          .image,
                                                                ),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                              EdgeInsets
                                                                  .all(20),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        bottom:
                                                                        10),
                                                                    child: Text(
                                                                      _places![
                                                                      index]
                                                                          .name,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                          15,
                                                                          fontWeight:
                                                                          FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                    EdgeInsets
                                                                        .only(),
                                                                    child:
                                                                    Container(
                                                                      width:
                                                                      200,
                                                                      child:
                                                                      Text(
                                                                        _places![index]
                                                                            .addres,
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                            10,
                                                                            fontWeight:
                                                                            FontWeight.w600),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )));
                                              }))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                        }).then((value){
                          setState(() {
                            _selected_place = value;
                          });


                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only( right: 20, left: 20),
                    child: SizedBox(
                      height: 170,
                      child: Container(
                        height: 150,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5),
                              BlendMode.luminosity,
                            ),
                            image: NetworkImage(
                              _selected_place?.image != null
                                  ? BASE_URL + _selected_place!.image
                                  : "https://yapimtel.com.tr/media/2021/03/cok-amacli-spor-sahasi-4.jpg",
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 20, top: 10),
                                child: Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white,
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: 20, bottom: 10),
                                  child: Text(
                                    _selected_place?.name != null
                                        ? _selected_place!.name
                                        : "yer seçin",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: 20, bottom: 20),
                                  child: Container(
                                    width: 200,
                                    child: Text(
                                      _selected_place?.addres != null
                                          ? _selected_place!.addres
                                          : "kös kös",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),


              ],
            ),
          ),
        ),
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
