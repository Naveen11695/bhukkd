import 'dart:async';
import 'dart:ui';

import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Components/CustomHorizontalScroll.dart';
import 'package:bhukkd/flarecode/flare_actor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/GeoCodeInfo/GeoCode.dart';
import '../api/HttpRequest.dart';
import '../models/Restruant/Restruant.dart';
import 'package:bhukkd/flarecode/flare_actor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/Reviews/Reviews.dart';
import 'package:async/async.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class RestaurantDetailPage extends StatefulWidget {
  final productid;

  RestaurantDetailPage({this.productid});

  RestaurantDetailPageState createState() => new RestaurantDetailPageState();
}

class RestaurantDetailPageState extends State<RestaurantDetailPage>
    with SingleTickerProviderStateMixin {
  final _resDetailPageCache = new AsyncMemoizer();
  final _resPhotosCache = new AsyncMemoizer();
  final _resMenu = new AsyncMemoizer();
  final _resComments = new AsyncMemoizer();

  var restruant_Photo_url;
  var Menu;

  double c_height = 0;
  double c_width = 0;

  var _bookingButton = new FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.restaurant),
    tooltip: "Reserve a seat",
    mini: true,
    foregroundColor: Colors.white,
    backgroundColor: Colors.deepOrange,
  );

  double _initialScale = 2;

  Future resDetailPageCache() => _resDetailPageCache.runOnce(() async {
        return fetchRestaurant(widget.productid.toString());
      });

  Future resPhotosCache() => _resPhotosCache.runOnce(() async {
        return fetchPhotos(restruant_Photo_url);
      });

  Future resMenu() => _resMenu.runOnce(() async {
        return fetchMenu(Menu);
      });

  Future resComments() => _resComments.runOnce(() async {
        return fetchReviews(widget.productid);
      });

  AnimationController _controller;
  Animation<double> _heightFactorAnimation;
  final double collapsedHeightFactor = 0.37;
  final double expendedHeightFactor = 0.842;
  bool isAnimationCompleted = false;

  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _heightFactorAnimation =
        Tween<double>(begin: collapsedHeightFactor, end: expendedHeightFactor)
            .animate(_controller);
  }

  int i = 0;

  onBottomPartTap() {
    setState(() {
      if (isAnimationCompleted) {
        _controller.reverse();
        _initialScale = 2;
        _bookingButton = new FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.restaurant),
          tooltip: "Reserve a seat",
          mini: true,
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepOrange,
        );
      } else {
        _controller.forward();
        _initialScale = 1;
        _bookingButton = null;
      }
      isAnimationCompleted = !isAnimationCompleted;
    });
  }

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
      floatingActionButton: _bookingButton,
    );
  }

  Widget getWidget() {
    return WillPopScope(
      onWillPop: () {
        print("back button pressed");
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new FutureBuilder(
            future: resDetailPageCache(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if(snapshot.data == "error") {
                  return FlareActor(
                    "assets/animations/restaurant_details.flr",
                    animation: "image_loading",
                    fit: BoxFit.fill,
                  );
                }
                else if (snapshot.data != null) {
                  restruant_Photo_url = snapshot.data.restruant_Photo_url;
                  Menu = snapshot.data.restruant_Menu;
                  return Stack(
                    fit: StackFit.passthrough,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          onBottomPartTap();
                        },
                        child: FractionallySizedBox(
                          alignment: Alignment.topCenter,
                          heightFactor: _heightFactorAnimation.value,
                          child: Stack(
                            children: <Widget>[
                              FutureBuilder(
                                  future: resPhotosCache(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapShot) {
                                    if (snapShot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapShot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container(
                                          child: Center(
                                            child: Image.asset(
                                              "assets/images/default.jpg",
                                              fit: BoxFit.fitHeight,
                                              height: 350,
                                            ),
                                          ),
                                        );
                                      } else if (snapShot.data != null) {
                                        return Container(
                                          color: Colors.black,
                                          child: PhotoViewGallery.builder(
                                            scrollPhysics:
                                                const BouncingScrollPhysics(),
                                            builder: (BuildContext context,
                                                int index) {
                                              return PhotoViewGalleryPageOptions(
                                                imageProvider: NetworkImage(
                                                    snapShot.data[index]),
                                                initialScale:
                                                    PhotoViewComputedScale
                                                            .contained *
                                                        _initialScale,
                                                minScale: PhotoViewComputedScale
                                                        .contained *
                                                    1,
                                                maxScale: PhotoViewComputedScale
                                                        .contained *
                                                    2,
                                              );
                                            },
                                            itemCount: snapShot.data.length,
                                            loadingChild: Center(
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                child: new FlareActor(
                                                  "assets/animations/dotLoader.flr",
                                                  animation: "load",
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          child: Center(
                                            child: Image.asset(
                                              "assets/images/default.jpg",
                                              fit: BoxFit.fitHeight,
                                              height: 350,
                                            ),
                                          ),
                                        );
                                      }
                                    } else {
                                      return Container(
                                        color: Colors.black,
                                        child: Center(
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            child: new FlareActor(
                                              "assets/animations/dotLoader.flr",
                                              animation: "load",
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 40.0, left: 10.0),
                                child: Container(
                                  child: new IconButton(
                                    icon: new Icon(
                                      FontAwesomeIcons.arrowLeft,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FractionallySizedBox(
                        alignment: Alignment.bottomCenter,
                        heightFactor: 1.04 - _heightFactorAnimation.value,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),
                                color: Color.fromRGBO(255, 255, 255, 250),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  ),
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 50.0, left: 10, right: 10),
                                      child: ListView(
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, bottom: 5),
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    width: c_width,
                                                    child: Text(
                                                      snapshot
                                                          .data
                                                          .restruant_Location
                                                          .locality_verbose,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black87,
                                                        fontSize: 20.0,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: c_width * 0.4,
                                                  ),
                                                  snapshot.data
                                                              .restruant_Is_delivery_now ==
                                                          0
                                                      ? Text(
                                                          "Closed",
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                            fontFamily:
                                                                "Montserrat-Bold",
                                                            fontSize: 25,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 1.1,
                                                          ),
                                                        )
                                                      : Text(
                                                          "Open",
                                                          style: TextStyle(
                                                            color: Colors.green,
                                                            fontFamily:
                                                                "Montserrat-Bold",
                                                            fontSize: 25,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 1.1,
                                                          ),
                                                        ),
                                                ],
                                              )),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Container(
                                                  width: c_width,
                                                  child: Text(
                                                    snapshot.data
                                                        .restruant_Cuisines,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black54),
                                                  ))),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Row(children: [
                                              Text(
                                                "Average Cost for Two",
                                                style: TextStyle(
                                                  fontFamily: "Roboto",
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  snapshot.data.currency +
                                                      ((snapshot.data
                                                                  .restruant_Avg_cost_for_two <
                                                              999)
                                                          ? snapshot.data
                                                              .restruant_Avg_cost_for_two
                                                              .toString()
                                                          : formatter.format(
                                                              snapshot.data
                                                                  .restruant_Avg_cost_for_two)),
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                      color: Colors.deepOrange,
                                                      fontFamily: "Roboto",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0),
                                                ),
                                              )
                                            ]),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          titleBar("Menu", c_width),
                                          Container(
                                            height: 200.0,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1.0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: FutureBuilder(
                                                  future: resMenu(),
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot snapShot) {
                                                    if (snapShot
                                                            .connectionState ==
                                                        ConnectionState.done) {
                                                      if (snapShot.data !=
                                                          null) {
                                                        return Material(
                                                          child:
                                                              ListView.builder(
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount: snapShot
                                                                .data.length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              int _index =
                                                                  index;
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (BuildContext context) => Container(
                                                                                color: Colors.black,
                                                                                child: PhotoViewGallery.builder(
                                                                                  scrollPhysics: const BouncingScrollPhysics(),
                                                                                  builder: (BuildContext context, int index) {
                                                                                    return PhotoViewGalleryPageOptions(
                                                                                      imageProvider: NetworkImage(snapShot.data[index]),
                                                                                      initialScale: PhotoViewComputedScale.contained * 1,
                                                                                      minScale: PhotoViewComputedScale.contained * 1,
                                                                                      maxScale: PhotoViewComputedScale.contained * 2,
                                                                                      //heroTag: galleryItems[index].id,
                                                                                    );
                                                                                  },
                                                                                  itemCount: snapShot.data.length,
                                                                                  loadingChild: Center(
                                                                                    child: Container(
                                                                                      height: 50,
                                                                                      width: 50,
                                                                                      child: new FlareActor(
                                                                                        "assets/animations/dotLoader.flr",
                                                                                        animation: "load",
                                                                                        fit: BoxFit.contain,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  pageController: PageController(initialPage: _index, keepPage: true, viewportFraction: 1),
                                                                                ),
                                                                              )));
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          2.0),
                                                                  child:
                                                                      Material(
                                                                    elevation:
                                                                        10.0,
                                                                    child:
                                                                        Container(
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              5,
                                                                          right:
                                                                              5,
                                                                          top:
                                                                              5,
                                                                          bottom:
                                                                              5),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        imageUrl:
                                                                            snapShot.data[index],
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        width:
                                                                            150,
                                                                        height:
                                                                            150,
                                                                        placeholder: (context,
                                                                                url) =>
                                                                            Center(
                                                                              child: Container(
                                                                                width: 150,
                                                                                height: 100,
                                                                                child: Center(
                                                                                  child: new FlareActor(
                                                                                    "assets/animations/loading_Untitled.flr",
                                                                                    animation: "Untitled",
                                                                                    fit: BoxFit.contain,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      }
                                                    } else if (snapShot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return ListView.builder(
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: 3,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return Center(
                                                              child: Container(
                                                                width: 130,
                                                                height: 100,
                                                                child: Center(
                                                                  child:
                                                                      new FlareActor(
                                                                    "assets/animations/loading_Untitled.flr",
                                                                    animation:
                                                                        "Untitled",
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    }
                                                  }),
                                            ),
                                          ),
                                          titleBar("Details", c_width),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, top: 10),
                                            child: Row(
                                              children: <Widget>[
                                                Text("Address",
                                                    style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontWeight:
                                                            FontWeight.w200,
                                                        fontSize: 20.0,
                                                        color: Colors.black87)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, top: 6),
                                            child: Row(children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  snapshot
                                                      .data
                                                      .restruant_Location
                                                      .address,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                      fontFamily: "Roboto",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16.0,
                                                      color: Colors.black87),
                                                ),
                                              )
                                            ]),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          titleBar("Reviews", c_width),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: FutureBuilder(
                                                  future: resComments(),
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot snapShot) {
                                                    if (snapShot
                                                            .connectionState ==
                                                        ConnectionState.done) {
                                                      if (snapShot.data ==
                                                          "error") {
                                                        return Container(
                                                            child: Text(
                                                                "No Reviews Available"));
                                                      } else if (snapShot
                                                              .data !=
                                                          null) {
                                                        return Container(
                                                            child: ListView
                                                                .separated(
                                                          shrinkWrap: true,
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          itemCount: snapShot
                                                                      .data
                                                                      .reviews_count >
                                                                  5
                                                              ? 5
                                                              : snapShot
                                                                  .data
                                                                  .user_reviews
                                                                  .length,
                                                          separatorBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return Divider(
                                                              color: Colors
                                                                  .black54,
                                                            );
                                                          },
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return ListTile(
                                                              leading:
                                                                  Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .black,
                                                                        offset: Offset(
                                                                            5.0,
                                                                            5.0),
                                                                        blurRadius:
                                                                            5)
                                                                  ],
                                                                ),
                                                                child:
                                                                    CircleAvatar(
                                                                  maxRadius: 30,
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                    snapShot
                                                                        .data
                                                                        .user_reviews[
                                                                            index]
                                                                        .review
                                                                        .user
                                                                        .profile_image,
                                                                  ),
                                                                ),
                                                              ),
                                                              title: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      snapShot
                                                                          .data
                                                                          .user_reviews[
                                                                              index]
                                                                          .review
                                                                          .user
                                                                          .name,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .justify,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontFamily:
                                                                            "Roboto",
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                    ),
                                                                    Column(
                                                                      children: <
                                                                          Widget>[
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 8.0,
                                                                              bottom: 8.0),
                                                                          child:
                                                                              Text(
                                                                            snapShot.data.user_reviews[index].review.review_text,
                                                                            style: TextStyle(
                                                                                color: Colors.black54,
                                                                                fontFamily: "Roboto",
                                                                                fontWeight: FontWeight.w300,
                                                                                fontSize: 14),
                                                                          ),
                                                                        ),
                                                                        getStarWidgets(snapShot
                                                                            .data
                                                                            .user_reviews[index]
                                                                            .review
                                                                            .rating
                                                                            .toString()),
                                                                      ],
                                                                    )
                                                                  ]),
                                                            );
                                                          },
                                                        ));
                                                      }
                                                    } else if (snapShot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return Container(
                                                        height: 200,
                                                        width: 200,
                                                        child: Center(
                                                          child: new FlareActor(
                                                            "assets/animations/loading_Untitled.flr",
                                                            animation: "Untitled",
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  })),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Container(
                                    width: c_width * 1.3,
                                    child: new Text(
                                      snapshot.data.restruant_Name,
                                      textDirection: TextDirection.ltr,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.start,
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Montserrat-Bold",
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2,
                                        wordSpacing: 0.5,
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
                                  ),
                                ),
                                SizedBox(
                                  width: c_width * 0.2,
                                ),
                                DecoratedBox(
                                  child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Text(
                                          snapshot.data.restruant_User_rating
                                              .aggregate_rating,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ))),
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          offset: Offset(5.0, 5.0),
                                          blurRadius: 20)
                                    ],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              } else {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return FlareActor(
                    "assets/animations/restaurant_details.flr",
                    animation: "image_loading",
                    fit: BoxFit.fill,
                  );
                }
              }
            },
          ),
        ],
      ),
    );
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
