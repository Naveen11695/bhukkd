import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:bhukkd/Auth/Home/GetterSetter/GetterSetterAppConstant.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Components/CustomTransition.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Pages/Explore/CategoriesPage.dart';
import 'package:bhukkd/Pages/RestaurantDetailPage/RestaurantDetailPage.dart';
import 'package:bhukkd/Pages/Search/SearchRestaurant.dart';
import 'package:bhukkd/Pages/Search/search.dart';
import 'package:bhukkd/Pages/TrendingPage/Componets/CustomHorizontalScroll.dart';
import 'package:bhukkd/Pages/TrendingPage/Componets/HorizontalScroll.dart';
import 'package:bhukkd/Services/HttpRequest.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as prefix0;

List<dynamic> copydata = [];

bool isReloading = false;
double latitude, longitude;

class TrendingPage extends StatefulWidget {
  const TrendingPage({Key key}) : super(key: key);

  _TrendingPageState createState() => new _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage>
    with AutomaticKeepAliveClientMixin {
  bool isInitializingRequest = false;
  List<dynamic> rests = [];

  int start;

  ListView listBuilder;

  String _status = "Active";

  @override
  bool get wantKeepAlive => true;

  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              new CustomScrollView(
                physics: ScrollPhysics(),
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
                              height: 45,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 35.0),
                            child: Container(
                              alignment: AlignmentDirectional.topStart,
                              padding: EdgeInsets.only(left: 18.0, bottom: 5.0),
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
                      Container(height: 185, child: HorizontalScroll()),
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        padding:
                        EdgeInsets.only(top: 5, left: 18.0, bottom: 5.0),
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
                            .height * 0.19,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 2, 0, 2),
                          child: CustomHorizontalScroll(),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.height * 0.92,
                        alignment: AlignmentDirectional.topStart,
                        padding:
                        EdgeInsets.only(top: 5, left: 18.0, bottom: 5.0),
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
                              "(" + prefix0.DateFormat('EEEE').format(
                                  DateTime.now()).toString() + " Special)",
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
                                  // fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                  wordSpacing: 0.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  (rests.toString().compareTo("[]") != 0)
                      ? SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          delegate: SliverChildBuilderDelegate(
                            // ignore: missing_return
                              (BuildContext context, int index) {
                                if (rests[index].featured_image
                                    .toString()
                                    .length !=
                                    0)
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          HorizontalTransition(
                                              builder: (BuildContext context) =>
                                                  RestaurantDetailPage(
                                                    productid: rests[index].id,
                                                  )));
                                    },
                                    child: Card(
                                      elevation: 5,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0,
                                                left: 2.0,
                                                right: 2.0,
                                                bottom: 2.0),
                                            child: Stack(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      left: 5.0, right: 10.0),
                                                  child: Container(
                                                    color: Colors.black,
                                                    child: Center(
                                                      child: CachedNetworkImage(
                                                        imageUrl: rests[index]
                                                            .featured_image,
                                                        fit: BoxFit.fill,
                                                        height:
                                                        MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.14,
                                                        width:
                                                        MediaQuery
                                                            .of(context)
                                                            .size
                                                            .width *
                                                            0.5,
                                                        placeholder:
                                                            (context, url) =>
                                                            Image.asset(
                                                              "assets/images/default.jpg",
                                                              fit: BoxFit.cover,
                                                              height:
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height *
                                                                  0.14,
                                                            ),
                                                        errorWidget:
                                                            (context, url,
                                                            error) =>
                                                            Icon(Icons.error),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height *
                                                      .150,
                                                  alignment: Alignment
                                                      .bottomRight,
                                                  child: ClipOval(
                                                    child: getRating(
                                                        rests[index]
                                                            .user_rating
                                                            .aggregate_rating
                                                            .toString()),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2.0, right: 2.0),
                                            child: Text(
                                              rests[index].name,
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: FONT_TEXT_EXTRA,
                                                  color: TEXT_PRIMARY_COLOR),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0,
                                                left: 10.0,
                                                right: 10.0),
                                            child: Container(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.75,
                                              child: Text(
                                                rests[index].cuisines,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: FONT_TEXT_SECONDARY,
                                                    color: TEXT_SECONDARY_COLOR),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                          },
                              childCount: rests.length,
                              addRepaintBoundaries: true))
                      : SliverGrid(
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Card(
                              child: Center(
                                child: FlareActor(
                                  "assets/animations/near_by_rest_loading.flr",
                                  animation: "loading",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }, childCount: 6, addRepaintBoundaries: true))
                ],
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

  final _callit = new AsyncCache(const Duration(days: 30));

  get _callitAsync =>
      _callit.fetch(() {
        return fetchRestByCollectionID(1, "", "desc");
      });

  @override
  void dispose() {
    super.dispose();
  }

  Future fetchRestByCollectionID(int id, String q, String sorting) async {
    try {
      String city_id;
      SearchRestraunts searchByCategory;
      await getNearByRestaurants().then((res) {
        if (res != null) {
          city_id = res[0].near_by_restaurants_location["city_id"].toString();
        }
      });
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        bool flag = false;
        var fireStore = Firestore.instance;
        DocumentReference snapshot = fireStore
            .collection('Recommended')
            .document(city_id + "-city-" + "Popular" + '-' + start.toString());
        await snapshot.get().then((dataSnapshot) {
          if (dataSnapshot.exists &&
              DateTime
                  .now()
                  .day != 1 &&
              dataSnapshot.data[start.toString()] != null) {
            var _response = dataSnapshot.data[start.toString()];
            searchByCategory =
                SearchRestraunts.fromJson(json.decode(_response));
          } else {
            flag = true;
          }
        });

        if (flag) {
          print("<fetchRestByCollectionID>");
          Iterable<dynamic> key =
              (await parseJsonFromAssets('assets/api/config.json')).values;
          var apiKey = key.elementAt(0);
          if (!isInitializingRequest) {
            try {
              setState(() {
                isInitializingRequest = true;
              });
            } catch (e) {
              print("<Categories Exception> " + e.toString());
            }
            if (sorting != null && id != null) {
              http.Response _response = await http.get(
                  "https://developers.zomato.com/api/v2.1/search?entity_id=$city_id&entity_type=city&q=$q&order=$sorting&start=$start&sort=rating",
                  headers: {"Accept": "application/json", "user-key": apiKey});
              saveRecommended(city_id + "-city-" + "Popular", start.toString(),
                  _response.body);
              searchByCategory =
                  SearchRestraunts.fromJson(json.decode(_response.body));
            }
          }
        }

        if (searchByCategory != null) {
          start += 20;
          copydata = List.from(searchByCategory.restaurants);
          List<dynamic> addRest = [];
          if (copydata.length == 20)
            addRest = new List.generate(20, (index) => copydata[index]);
          else {
            _status = "finished";
          }
          try {
            setState(() {
              rests.addAll(addRest);
              isInitializingRequest = false;
            });
          } catch (e) {
            print("exception <categories>: " + e.toString());
          }
        }
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  @override
  void initState() {
    super.initState();
    (DateTime
        .now()
        .weekday == 1)
        ? start = 0
        : start = DateTime
        .now()
        .weekday * 10;
    getMapKey();
    _callitAsync;
  }

  Future<Null> refresh() async {
    isReloading = true;
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      CustomHorizontalScroll();
      HorizontalScroll();
      _callitAsync;
    });
    return null;
  }
}
