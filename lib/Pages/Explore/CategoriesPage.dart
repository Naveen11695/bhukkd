import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Components/CustomTransition.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Pages/RestaurantDetailPage/RestaurantDetailPage.dart';
import 'package:bhukkd/Pages/Search/SearchRestaurant.dart';
import 'package:bhukkd/Pages/TrendingPage/Componets/HorizontalScroll.dart';
import 'package:bhukkd/Services/HttpRequest.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class CategoriesPage extends StatefulWidget {
  final int id;
  final String name;
  final String photo;

  CategoriesPage({this.id, this.name, this.photo});

  CategoriesPageState createState() => CategoriesPageState();
}

String getSortingValue() {}

List<dynamic> copydata = [];

class CategoriesPageState extends State<CategoriesPage> {
  ScrollController _controller = new ScrollController();
  bool isInitializingRequest = false;
  List<dynamic> rests = [];

  var _status = "Active";

  @override
  void initState() {
    super.initState();
    _callitAsync;
    _controller.addListener(() async {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (_status.compareTo("Active") == 0) {
          Toast.show("loading! more results", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          fetchRestByCategoryID(widget.id, widget.name.toLowerCase(),
              sorting: null);
        } else {
          Toast.show("Sorry! no more results", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      }
    });
  }

  final _callit = new AsyncCache(const Duration(days: 1));

  get _callitAsync =>
      _callit.fetch(() {
        return fetchRestByCategoryID(widget.id, widget.name.toLowerCase(),
            sorting: null);
      });

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  int start = 0;

  @override
  Widget build(BuildContext context) {
    if (rests.toString().compareTo("[]") != 0) {
      return Scaffold(
          body: CustomScrollView(controller: _controller, slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              backgroundColor: SECONDARY_COLOR_1,
              floating: true,
              expandedHeight: 200,
              centerTitle: true,
              title: Text(
                widget.name,
                style: TextStyle(
                    fontSize: 35, fontFamily: "Pacifico", color: Colors.white),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/images/icons/" + widget.photo,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.medium,
                ),
              ),
            ),
            SliverGrid(
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            HorizontalTransition(
                                builder: (BuildContext context) =>
                                    RestaurantDetailPage(
                                      productid: rests[index].id,
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black12),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: rests[index].featured_image == null ||
                                    rests[index].featured_image == ""
                                    ? Image.asset(
                                  "assets/images/default.jpg",
                                  fit: BoxFit.cover,
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.16,
                                )
                                    : Stack(
                                  children: <Widget>[
                                    Container(
                                      color: Colors.black,
                                      child: Center(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          rests[index].featured_image,
                                          fit: BoxFit.cover,
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height *
                                              0.14,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width *
                                              0.5,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                                "assets/images/default.jpg",
                                                fit: BoxFit.cover,
                                                height: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height *
                                                    0.14,
                                              ),
                                          errorWidget:
                                              (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          .150,
                                      alignment: Alignment.bottomRight,
                                      child: ClipOval(
                                        child: getRating(rests[index]
                                            .user_rating
                                            .aggregate_rating
                                            .toString()),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              rests[index].name,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: FONT_TEXT_PRIMARY,
                                  color: TEXT_PRIMARY_COLOR),
                            ),
                            Text(
                              rests[index].cuisines,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: FONT_TEXT_SECONDARY,
                                  color: TEXT_SECONDARY_COLOR),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }, childCount: rests.length, addRepaintBoundaries: true))
          ]));
    } else {
      return Scaffold(
          body: CustomScrollView(controller: _controller, slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              backgroundColor: SECONDARY_COLOR_1,
              floating: true,
              expandedHeight: 200,
              centerTitle: true,
              title: Text(
                widget.name,
                style: TextStyle(
                    fontSize: 35, fontFamily: "Pacifico", color: Colors.white),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/images/icons/" + widget.photo,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.medium,
                ),
              ),
            ),
            SliverGrid(
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
                  return Card(
                    elevation: 2,
                    child: Center(
                      child: FlareActor(
                        "assets/animations/near_by_rest_loading.flr",
                        animation: "loading",
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }, childCount: 6, addRepaintBoundaries: true))
          ]));
    }
  }

  fetchRestByCategoryID(int id, String q, {String sorting}) async {
    try {
      String city_id;
      SearchRestraunts searchByCategory;
      await getNearByRestaurants().then((res) {
        city_id = res[0].near_by_restaurants_location["city_id"].toString();
      });
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        bool flag = false;
        var fireStore = Firestore.instance;
        DocumentReference snapshot = fireStore
            .collection('Recommended')
            .document(city_id + "-city-" + q + '-' + start.toString());
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
            if (sorting == null && id != null) {
              http.Response _response = await http.get(
                  "https://developers.zomato.com/api/v2.1/search?entity_id=$city_id&entity_type=city&q=$q&order=$sorting&start=$start",
                  headers: {"Accept": "application/json", "user-key": apiKey});
              saveRecommended(
                  city_id + "-city-" + q, start.toString(), _response.body);
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
            Toast.show("Sorry! no more results", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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
}

void saveRecommended(String doc, String start, String data) async {
  var fireStore = Firestore.instance;
  DocumentReference snapshot =
  fireStore.collection('Recommended').document(doc + '-' + start);
  await snapshot.get().then((dataSnapshot) {
    if (dataSnapshot.exists) {
      Firestore.instance
          .collection("Recommended")
          .document(doc + '-' + start)
          .updateData({start: data});
    } else {
      Firestore.instance
          .collection("Recommended")
          .document(doc + '-' + start)
          .setData({start: data});
    }
  });
}
