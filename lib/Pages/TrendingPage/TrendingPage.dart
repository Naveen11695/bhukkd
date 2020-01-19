import 'dart:async';

import 'package:bhukkd/Auth/Home/GetterSetter/GetterSetterAppConstant.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Pages/Search/search.dart';
import 'package:bhukkd/Pages/TrendingPage/Componets/CustomHorizontalScroll.dart';
import 'package:bhukkd/Pages/TrendingPage/Componets/HorizontalScroll.dart';
import 'package:bhukkd/Pages/TrendingPage/Componets/RecommendedScroll.dart';
import 'package:bhukkd/Services/HttpRequest.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart' as prefix0;

List<dynamic> copydata = [];

bool isReloading = false;
double latitude, longitude;

class TrendingPage extends StatefulWidget {
  const TrendingPage({Key key}) : super(key: key);

  _TrendingPageState createState() => new _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {


  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                child: new CustomScrollView(
                  slivers: <Widget>[
                    new SliverAppBar(
                      floating: false,
                      title: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.012,
                            right: 5,
                            left: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2.0),
                              child: Text("Your Location",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: FONT_TEXT_PRIMARY,
                                  )),
                            ),
                            Text(
                                GetterSetterAppConstant.address == null
                                    ? "Fetching Your Location.."
                                    : GetterSetterAppConstant.address,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: FONT_TEXT_SECONDARY,
                                )),
                          ],
                        ),
                      ),
                      backgroundColor: SECONDARY_COLOR_1,
                      leading: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: new Icon(
                          Icons.location_on,
                          semanticLabel: "Your Location",
                          textDirection: TextDirection.ltr,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                      titleSpacing: 0.4,
                      expandedHeight: MediaQuery
                          .of(context)
                          .size
                          .height * 0.10,
                      pinned: true,
                      primary: true,
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Stack(
                          children: <Widget>[
                            ClipPath(
                              clipper: WaveClipperTwo(),
                              child: Container(
                                color: SECONDARY_COLOR_1,
                                height: 50,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Container(
                                alignment: AlignmentDirectional.topStart,
                                padding: EdgeInsets.only(
                                    top: 15.0, left: 18.0, bottom: 20.0),
                                child: new Text(
                                  "Near By Restaurants - - - - - - - - - - - - - - - - - - - -",
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: new TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: FONT_TEXT_EXTRA,
                                    letterSpacing: 0.8,
                                    wordSpacing: 0.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            height: 175,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: HorizontalScroll(),
                            )),
                        Container(
                          padding: EdgeInsets.only(
                              left: 18.0, top: 10.0, bottom: 25.0),
                          child: new Text(
                            "Top Restraunts - - - - - - - - - - - - - - - - - - - - - - - - - -",
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: new TextStyle(
                              fontSize: 20.0,
                              fontFamily: FONT_TEXT_EXTRA,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                              wordSpacing: 0.0,
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.17,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                            child: CustomHorizontalScroll(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 18.0, top: 5.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Recommended ",
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: new TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: FONT_TEXT_EXTRA,
                                  // fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                  wordSpacing: 0.0,
                                ),
                              ),
                              Text(
                                "(" +
                                    prefix0.DateFormat('EEEE')
                                        .format(DateTime.now())
                                        .toString() +
                                    " Special)",
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: new TextStyle(
                                  fontSize: 15.0,
                                  color: TEXT_SECONDARY_COLOR,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FONT_TEXT_EXTRA,
                                  letterSpacing: 0.8,
                                  wordSpacing: 0.0,
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  " - - - - - - - - - - - - - - - - -",
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: new TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: FONT_TEXT_EXTRA,
                                    letterSpacing: 0.8,
                                    wordSpacing: 0.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: RecommendedScroll(),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              new Container(
                height: 50,
                margin: EdgeInsets.only(
                    top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.105,
                    right: 15,
                    left: 15),
                child: Material(
                  type: MaterialType.canvas,
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(25.0),
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    child: InkWell(
                      onTap: () {
                        if (GetterSetterAppConstant.address.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchList(),
                              ));
                        }
                      },
                      splashColor: Colors.white24,
                      highlightColor: Colors.white10,
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(
                                Icons.search,
                                color: TEXT_SECONDARY_COLOR,
                              ),
                            ),
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.36,
                              child: Center(
                                child: Text(
                                  "Search for trending restraunts nearby",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: new TextStyle(
                                      fontFamily: FONT_TEXT_SECONDARY,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.5,
                                      fontSize: 15.0,
                                      color: TEXT_SECONDARY_COLOR,
                                      shadows: [
                                        Shadow(
                                            offset: Offset(0.3, 0.1),
                                            color: Colors.grey),
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        onRefresh: refresh,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getMapKey();
  }

  Future<Null> refresh() async {
    isReloading = true;
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      CustomHorizontalScroll();
      HorizontalScroll();
      RecommendedScroll();
    });
    return null;
  }
}
