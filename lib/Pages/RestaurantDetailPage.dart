import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:async/async.dart';
import 'package:bhukkd/Booking/Pages/BookingMain.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Pages/TrendingPage/Componets/CustomHorizontalScroll.dart';
import 'package:bhukkd/Pages/TrendingPage/Componets/Slider.dart';
import 'package:bhukkd/Services/HttpRequest.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../models/Reviews/Reviews.dart';

class RestaurantDetailPage extends StatefulWidget {
  final productid;

  RestaurantDetailPage({this.productid});

  RestaurantDetailPageState createState() => new RestaurantDetailPageState();
}

class RestaurantDetailPageState extends State<RestaurantDetailPage>
    with SingleTickerProviderStateMixin {
  final _resDetailPageCache = new AsyncMemoizer();
  final _resComments = new AsyncMemoizer();
  var restruant_Photo_url;
  var Menu;
  double c_height = 0;
  double c_width = 0;
  double _initialScale = 2;
  var coverImage;
  var restruantInfo;

  Future resDetailPageCache() => _resDetailPageCache.runOnce(() async {
        return fetchRestaurant(widget.productid.toString());
      });

  final resPhotosCache = new AsyncCache(const Duration(hours: 1));

  get _resPhotosCache =>
      resPhotosCache.fetch(() {
        return fetchPhotos(restruant_Photo_url);
      });

  final resMenu = new AsyncCache(const Duration(hours: 1));

  get _resMenu =>
      resMenu.fetch(() {
        return fetchMenu(Menu);
      });


  Future resComments() => _resComments.runOnce(() async {
        return fetchReviews(widget.productid);
      });

  AnimationController _controller;
  Animation<double> _heightFactorAnimation;
  final double collapsedHeightFactor = 0.37;
  final double expendedHeightFactor = 0.842;


  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _heightFactorAnimation =
        Tween<double>(begin: collapsedHeightFactor, end: expendedHeightFactor)
            .animate(_controller);

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (coverImage != null) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      BookingMain(coverImage, restruantInfo)));
            } else {
              print("no");
            }
          },
          child: Icon(
            Icons.restaurant,
            size: 30,
          ),
          tooltip: "Reserve a seat",
          mini: false,
          foregroundColor: Colors.white,
          backgroundColor: SECONDARY_COLOR_2,
        ));
  }

  String res_name;

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
                if (snapshot.data == "error") {
                  return FlareActor(
                    "assets/animations/restaurant_details.flr",
                    animation: "image_loading",
                    fit: BoxFit.fill,
                  );
                } else if (snapshot.data != null) {
                  restruant_Photo_url = snapshot.data.restruant_Photo_url;
                  restruantInfo = snapshot.data;
                  Menu = snapshot.data.restruant_Menu;
                  coverImage = snapshot.data.restruant_Thumb;
                  return CustomScrollView(
                    scrollDirection: Axis.vertical,
                    slivers: <Widget>[
                      SliverAppBar(
                        backgroundColor: SECONDARY_COLOR_1,
                        expandedHeight: 300.0,
                        primary: true,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: false,
                          background: FutureBuilder(
                              future: _resPhotosCache,
                              // ignore: missing_return
                              builder: (BuildContext context,
                                  AsyncSnapshot _snapShot) {
                                if (_snapShot.connectionState ==
                                    ConnectionState.done) {
                                  if (_snapShot.connectionState ==
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
                                  } else if (_snapShot.data != null) {
                                    return Container(
                                      color: SECONDARY_COLOR_1,
                                      child: buildSlider(context, _snapShot),
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
                                    color: SECONDARY_COLOR_1,
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
                          collapseMode: CollapseMode.parallax,
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
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 80.0,
                                          left: 10.0,
                                          right: 10.0,
                                          bottom: 80.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
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
                                                        fontFamily:
                                                        FONT_TEXT_SECONDARY,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        color:
                                                        TEXT_SECONDARY_COLOR,
                                                        fontSize: 20.0,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: c_width * 0.35,
                                                  ),
                                                  Container(
                                                    width: c_width * 0.5,
                                                    child: snapshot.data
                                                        .restruant_Is_delivery_now ==
                                                        0
                                                        ? Text(
                                                      "Closed",
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontFamily:
                                                        FONT_TEXT_PRIMARY,
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
                                                        FONT_TEXT_PRIMARY,
                                                        fontSize: 25,
                                                        fontStyle: FontStyle
                                                            .normal,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        letterSpacing: 1.1,
                                                      ),
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
                                                        fontFamily:
                                                        FONT_TEXT_PRIMARY,
                                                        color: Colors.black54),
                                                  ))),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Row(children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, bottom: 8.0),
                                                child: Text(
                                                  "Average Cost for Two",
                                                  style: TextStyle(
                                                    fontFamily:
                                                    FONT_TEXT_SECONDARY,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.0,
                                                  ),
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
                                                      color:
                                                      TEXT_SECONDARY_COLOR,
                                                      fontFamily:
                                                      FONT_TEXT_PRIMARY,
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8.0),
                                            child: titleBar("Menu", c_width),
                                          ),
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
                                                  future: _resMenu,
                                                  // ignore: missing_return
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
                                                                      builder: (
                                                                          BuildContext context) =>
                                                                          Container(
                                                                            color: Colors
                                                                                .black,
                                                                            child: PhotoViewGallery
                                                                                .builder(
                                                                              scrollPhysics: const BouncingScrollPhysics(),
                                                                              builder: (
                                                                                  BuildContext context,
                                                                                  int index) {
                                                                                return PhotoViewGalleryPageOptions(
                                                                                  imageProvider: NetworkImage(
                                                                                    snapShot
                                                                                        .data[index],
                                                                                  ),
                                                                                  initialScale: PhotoViewComputedScale
                                                                                      .contained *
                                                                                      1,
                                                                                  minScale: PhotoViewComputedScale
                                                                                      .contained *
                                                                                      1,
                                                                                  maxScale: PhotoViewComputedScale
                                                                                      .contained *
                                                                                      2,
                                                                                  heroTag: index,
                                                                                );
                                                                              },
                                                                              itemCount: snapShot
                                                                                  .data
                                                                                  .length,
                                                                              loadingChild: Center(
                                                                                child: Container(
                                                                                  height: 50,
                                                                                  width: 50,
                                                                                  child: new FlareActor(
                                                                                    "assets/animations/dotLoader.flr",
                                                                                    animation: "load",
                                                                                    fit: BoxFit
                                                                                        .contain,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              pageController: PageController(
                                                                                  initialPage: _index,
                                                                                  keepPage: true,
                                                                                  viewportFraction: 1),
                                                                            ),
                                                                          )));
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      2.0),
                                                                  child:
                                                                  Container(
                                                                    color: SECONDARY_COLOR_1,
                                                                    child:
                                                                    CachedNetworkImage(
                                                                      imageUrl:
                                                                      snapShot
                                                                          .data[index],
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      width:
                                                                      150,
                                                                      height:
                                                                      150,
                                                                      placeholder:
                                                                          (
                                                                          context,
                                                                          url) =>
                                                                          Center(
                                                                            child:
                                                                            Container(
                                                                              width:
                                                                              150,
                                                                              height:
                                                                              100,
                                                                              child:
                                                                              Center(
                                                                                child:
                                                                                new FlareActor(
                                                                                  "assets/animations/loading_Untitled.flr",
                                                                                  animation: "Untitled",
                                                                                  fit: BoxFit
                                                                                      .fitHeight,
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8.0),
                                            child: titleBar("Details", c_width),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Text("Address",
                                                style: TextStyle(
                                                    fontFamily:
                                                    FONT_TEXT_PRIMARY,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 20.0,
                                                    color: Colors.black87)),
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
                                                      fontFamily:
                                                      FONT_TEXT_SECONDARY,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize: 16.0,
                                                      color:
                                                      TEXT_SECONDARY_COLOR),
                                                ),
                                              )
                                            ]),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, top: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  height: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height *
                                                      0.3,
                                                  width: double.infinity,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        20),
                                                    child: FlutterMap(
                                                      options: new MapOptions(
                                                        center: new LatLng(
                                                            double.parse(
                                                                snapshot
                                                                    .data
                                                                    .restruant_Location
                                                                    .latitude),
                                                            double.parse(
                                                                snapshot
                                                                    .data
                                                                    .restruant_Location
                                                                    .longitude)),
                                                        zoom: 13.0,
                                                      ),
                                                      layers: [
                                                        new TileLayerOptions(
                                                          urlTemplate:
                                                          "https://api.tiles.mapbox.com/v4/"
                                                              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                                                          additionalOptions: {
                                                            'accessToken':
                                                            map_api_key,
                                                            'id':
                                                            'mapbox.streets',
                                                          },
                                                        ),
                                                        new MarkerLayerOptions(
                                                          markers: [
                                                            new Marker(
                                                              width: 100.0,
                                                              height: 100.0,
                                                              point: new LatLng(
                                                                  double.parse(
                                                                      snapshot
                                                                          .data
                                                                          .restruant_Location
                                                                          .latitude),
                                                                  double.parse(
                                                                      snapshot
                                                                          .data
                                                                          .restruant_Location
                                                                          .longitude)),
                                                              builder: (ctx) =>
                                                              new Container(
                                                                child: new Icon(
                                                                    Icons
                                                                        .restaurant),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0),
                                            child: titleBar("Reviews", c_width),
                                          ),
                                          FutureBuilder(
                                              future: resComments(),
                                              // ignore: missing_return
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
                                                                ClipOval(
                                                                  child: CachedNetworkImage(
                                                                    imageUrl: snapShot
                                                                        .data
                                                                        .user_reviews[
                                                                    index]
                                                                        .review
                                                                        .user
                                                                        .profile_image,
                                                                    fit: BoxFit
                                                                        .fitHeight,
                                                                    height:
                                                                    MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.14,
                                                                    placeholder: (
                                                                        context,
                                                                        url) =>
                                                                        Image
                                                                            .asset(
                                                                          "assets/images/icons/default_userImage.png",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                    errorWidget: (
                                                                        context,
                                                                        url,
                                                                        error) =>
                                                                        Icon(
                                                                            Icons
                                                                                .error),
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
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      maxLines:
                                                                      1,
                                                                      style:
                                                                      TextStyle(
                                                                        color:
                                                                        TEXT_PRIMARY_COLOR,
                                                                        fontFamily:
                                                                        FONT_TEXT_EXTRA,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w600,
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
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            maxLines:
                                                                            3,
                                                                            style: TextStyle(
                                                                                color: Colors.black54,
                                                                                fontFamily: FONT_TEXT_SECONDARY,
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
                                                        animation:
                                                        "Untitled",
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: c_width * 1.2,
                                      child: new Text(
                                        snapshot.data.restruant_Name,
                                        textDirection: TextDirection.ltr,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        textAlign: TextAlign.start,
                                        style: new TextStyle(
                                          color: Colors.white,
                                          fontFamily: FONT_TEXT_EXTRA,
                                          fontSize: 25,
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
                                    SizedBox(
                                      width: c_width * 0.2,
                                    ),
                                    DecoratedBox(
                                      child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Text(
                                              snapshot.data
                                                  .restruant_User_rating
                                                  .aggregate_rating,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FONT_TEXT_PRIMARY,
                                                fontSize: 25,
                                              ))),
                                      decoration: BoxDecoration(
                                        color: SECONDARY_COLOR_1,
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
                            );
                          },
                          childCount: 1,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    child: FlareActor(
                      "assets/animations/restaurant_details.flr",
                      animation: "image_loading",
                      fit: BoxFit.fill,
                    ),
                  );
                }
              } else {
                return Container(
                  child: FlareActor(
                    "assets/animations/restaurant_details.flr",
                    animation: "image_loading",
                    fit: BoxFit.fill,
                  ),
                );
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
