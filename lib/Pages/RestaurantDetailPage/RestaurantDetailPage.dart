import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:async/async.dart';
import 'package:bhukkd/Booking/Pages/BookingMain.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Pages/RestaurantDetailPage/Componets/Slider.dart';
import 'package:bhukkd/Pages/RestaurantDetailPage/Componets/WidgetAddress.dart';
import 'package:bhukkd/Pages/RestaurantDetailPage/Componets/WidgetMenu.dart';
import 'package:bhukkd/Pages/RestaurantDetailPage/Componets/WidgetReview.dart';
import 'package:bhukkd/Pages/RestaurantDetailPage/Componets/WidgetSubDetails.dart';
import 'package:bhukkd/Services/HttpRequest.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import '../../models/Reviews/Reviews.dart';

class RestaurantDetailPage extends StatefulWidget {
  final productid;

  RestaurantDetailPage({this.productid});

  RestaurantDetailPageState createState() => new RestaurantDetailPageState();
}

class RestaurantDetailPageState extends State<RestaurantDetailPage>
    with SingleTickerProviderStateMixin {
  final _resDetailPageCache = new AsyncCache(const Duration(days: 30));

  var restruant_Photo_url;
  var Menu;
  double c_height = 0;
  double c_width = 0;
  double _initialScale = 2;
  var coverImage;
  var restruantInfo;

  var textExpendValue = 1.0;

  get resDetailPageCache => _resDetailPageCache.fetch(() {
        return fetchRestaurant(widget.productid.toString());
      });

  final _resComments = new AsyncCache(const Duration(hours: 1));

  get resComments => _resComments.fetch(() {
        return fetchReviews(widget.productid);
      });

  AnimationController _controller;
  final double collapsedHeightFactor = 0.37;
  final double expendedHeightFactor = 0.842;

  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  int i = 0;

  @override
  Widget build(BuildContext context) {
    c_height = MediaQuery.of(context).size.height * 0.5;
    c_width = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, widget) {
          return getWidget();
        },
      ),
    );
  }

  String res_name;

  Widget getWidget() {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new FutureBuilder(
            future: resDetailPageCache,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == "error") {
                  print("error");
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            "assets/images/no_data.gif",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50.0),
                          child: Column(
                            children: <Widget>[
                              Text("Ooops!",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: FONT_TEXT_PRIMARY,
                                      letterSpacing: 2,
                                      wordSpacing: 2)),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                                child: Text("Sorry no information available.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black45,
                                        fontFamily: FONT_TEXT_SECONDARY,
                                        letterSpacing: 2,
                                        wordSpacing: 2)),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                            splashColor: Colors.white24,
                            highlightColor: Colors.white10,
                            child: Icon(
                              FontAwesomeIcons.arrowCircleLeft,
                              color: SECONDARY_COLOR_1,
                              size: 40,
                            )),
                      ],
                    ),
                  );
                } else if (snapshot.data != null) {
                  restruant_Photo_url = snapshot.data.restruant_Photo_url;
                  restruantInfo = snapshot.data;
                  Menu = snapshot.data.restruant_Menu;
                  coverImage = snapshot.data.restruant_Thumb;
                  return Scaffold(
                    body: Stack(
                      children: <Widget>[
                        CustomScrollView(
                          scrollDirection: Axis.vertical,
                          slivers: <Widget>[
                            SliverAppBar(
                              backgroundColor: SECONDARY_COLOR_1,
                              expandedHeight: 300.0,
                              primary: true,
                              pinned: true,
                              title: new Text(
                                snapshot.data.restruant_Name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontFamily: FONT_TEXT_EXTRA,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                  wordSpacing: 0.2,
                                  shadows: [
                                    Shadow(
                                        // bottomLeft
                                        offset: Offset(1.5, 1.5),
                                        color: Colors.white,
                                        blurRadius: 20),
                                    Shadow(
                                        // bottomRight
                                        offset: Offset(1.5, 1.5),
                                        color: Colors.black54,
                                        blurRadius: 5),
                                    Shadow(
                                        // topRight
                                        offset: Offset(1.5, 1.5),
                                        color: Colors.black54,
                                        blurRadius: 5),
                                    Shadow(
                                        // topLeft
                                        offset: Offset(1.5, 1.5),
                                        color: Colors.black54,
                                        blurRadius: 5),
                                  ],
                                ),
                              ),
                              flexibleSpace: FlexibleSpaceBar(
                                titlePadding: EdgeInsets.zero,
                                centerTitle: true,
                                background: ExtendedImage.network(
                                  snapshot.data.restruant_Thumb,
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.low,
                                  height: MediaQuery.of(context).size.height *
                                      0.110,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  timeLimit: Duration(days: 1),
                                  cache: true,
                                ),
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return Stack(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(40),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                              left: 10.0,
                                              right: 10.0,
                                              bottom: 50.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              //----------------------------------------------------SubDetails----------------------------->

                                              buildSubDetails(
                                                  snapshot, context, c_width),

                                              //----------------------------------------------------SubDetails-----------------------------<

                                              //----------------------------------------------------Menu----------------------------->

//                                              FutureBuilder(
//                                                  future: _resMenu,
//                                                  builder: (BuildContext
//                                                  context,
//                                                      AsyncSnapshot snapShot) {
//                                                    if (snapShot
//                                                        .connectionState ==
//                                                        ConnectionState.done) {
//                                                      if (snapShot.data !=
//                                                          null) {
//                                                        if (snapShot.data
//                                                            .toString() !=
//                                                            "[]") {
//                                                          return Container(
//                                                            height: 150,
//                                                            child: buildMenu(
//                                                                snapShot,
//                                                                context,
//                                                                c_width),
//                                                          );
//                                                        } else {
//                                                          return Container();
//                                                        }
//                                                      } else {
//                                                        return Container(
//                                                          height: 150,
//                                                          child:
//                                                          buildMenuWaiting(
//                                                              c_width),
//                                                        );
//                                                      }
//                                                    } else if (snapShot
//                                                        .connectionState ==
//                                                        ConnectionState
//                                                            .waiting) {
//                                                      return Container(
//                                                        height: 150,
//                                                        child: buildMenuWaiting(
//                                                            c_width),
//                                                      );
//                                                    } else {
//                                                      return Container(
//                                                        height: 150,
//                                                        child: buildMenuWaiting(
//                                                            c_width),
//                                                      );
//                                                    }
//                                                  }),

                                              //----------------------------------------------------Menu-----------------------------<

                                              //----------------------------------------------------Address----------------------------->

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, bottom: 8.0),
                                                child: titleBar(
                                                    "Details", c_width),
                                              ),

                                              buildAddress(
                                                  snapshot, context, c_width),

                                              //----------------------------------------------------Address-----------------------------<

                                              SizedBox(
                                                height: 20,
                                              ),

                                              //----------------------------------------------------ReView----------------------------->

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: titleBar(
                                                    "Reviews", c_width),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 50.0),
                                                child: FutureBuilder(
                                                    future: resComments,
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot
                                                                snapShot) {
                                                      if (snapShot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .done) {
                                                        if (snapShot.hasData) {
                                                          return buildReviews(
                                                              snapShot,
                                                              c_width);
                                                        } else {
                                                          return buildRatingWaiting(
                                                              c_width);
                                                        }
                                                      } else if (snapShot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return buildRatingWaiting(
                                                            c_width);
                                                      } else {
                                                        return buildRatingWaiting(
                                                            c_width);
                                                      }
                                                    }),
                                              ),

                                              //----------------------------------------------------ReView-----------------------------<
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                childCount: 1,
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Container(
                            height: MediaQuery.of(context).size.height * .08,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                top: 10.0,
                                left: 50.0,
                                right: 50.0,
                                bottom: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50.0),
                                  topRight: Radius.circular(50.0)),
                              color: SECONDARY_COLOR_1,
                            ),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Booking charges',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FONT_TEXT_EXTRA,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.0),
                                    ),
                                    Text(
                                      '₹ ' +
                                          _securityPerPerson(snapshot.data
                                                  .restruant_Avg_cost_for_two)
                                              .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FONT_TEXT_PRIMARY,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 20.0),
                                Spacer(),
                                RaisedButton(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  onPressed: () {
                                    if (coverImage != null) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  BookingMain(coverImage,
                                                      restruantInfo)));
                                    } else {
                                      print("no");
                                    }
                                  },
                                  color: TEXT_SECONDARY_COLOR,
                                  textColor: Colors.white,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "BOOK TABLE",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FONT_TEXT_PRIMARY,
                                            fontSize: 16.0),
                                      ),
                                      const SizedBox(width: 20.0),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 3.0, bottom: 8.0, top: 8.0, right: 3.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.orange,
                                          size: 16.0,
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    child: FlareActor(
                      "assets/animations/loading_Untitled.flr",
                      animation: "Untitled",
                      fit: BoxFit.contain,
                    ),
                  );
                }
              } else {
                return Container(
                  child: FlareActor(
                    "assets/animations/loading_Untitled.flr",
                    animation: "Untitled",
                    fit: BoxFit.contain,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  _securityPerPerson(var Avg_cost_for_two) {
    return double.parse(((double.parse(Avg_cost_for_two.toString()) /
                (2.0 * AVERAGE_TABLE_COST)) <
            999)
        ? (double.parse(Avg_cost_for_two.toString()) /
                (2.0 * AVERAGE_TABLE_COST))
            .toString()
        : formatter.format(double.parse(Avg_cost_for_two.toString()) /
            (2.0 * AVERAGE_TABLE_COST)));
  }
}

Future fetchReviews(String rest_id) async {
  getKey();
  http.Response response = await http.get(
      Uri.encodeFull(
          "https://developers.zomato.com/api/v2.1/reviews?res_id=${rest_id.toString()}"),
      headers: {"Accept": 'json/application', "user_key": api_key});
  Reviews r = Reviews.fromJson(json.decode(response.body));
  if (r.reviews_count == 0) {
    return "error";
  }
  return r;
}
