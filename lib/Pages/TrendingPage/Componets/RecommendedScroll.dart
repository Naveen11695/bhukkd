import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Components/CustomTransition.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Pages/Explore/CategoriesPage.dart';
import 'package:bhukkd/Pages/RestaurantDetailPage/RestaurantDetailPage.dart';
import 'package:bhukkd/Pages/Search/SearchRestaurant.dart';
import 'package:bhukkd/Pages/TrendingPage/Componets/HorizontalScroll.dart';
import 'package:bhukkd/Services/HttpRequest.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecommendedScroll extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecommendedScrollState();
  }
}

final _callit = new AsyncMemoizer();

int start;

Future fetchRestByCollectionIDAsync() => _callit.runOnce(() {
      return fetchRestByCollectionID(1, "", "desc", start);
    });


class BodyWidget extends StatelessWidget {
  final Color color;

  BodyWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      color: color,
      alignment: Alignment.center,

    );
  }
}
class RecommendedScrollState extends State<RecommendedScroll> {
  @override
  void initState() {
    super.initState();
    (DateTime.now().weekday == 1)
        ? start = 0
        : start = DateTime.now().weekday * 10;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchRestByCollectionIDAsync(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == "error") {
            return GridView.builder(
                shrinkWrap: true,
                addRepaintBoundaries: true,
                itemCount: 10,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.grey.shade100,
                    width: 180,
                    child: new Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: new FlareActor(
                        "assets/animations/near_by_rest_loading.flr",
                        animation: "loading",
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                });
          } else if (snapshot.data != null) {
            return GridView.builder(
                itemCount:
                snapshot.data.length >= 8 ? 8 : snapshot.data.length,
                cacheExtent: 8,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.2, crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(7)),
                    child: new Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              HorizontalTransition(
                                  builder: (BuildContext context) =>
                                      RestaurantDetailPage(
                                        productid: snapshot.data[index].id,
                                      )));
                        },
                        child: Card(
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, left: 5.0, right: 2.0),
                                child: Stack(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2.0, right: 8.0),
                                      child: Container(
                                        color: Colors.black,
                                        child: Center(
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot.data[index]
                                                .featured_image,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                            new Image.asset(
                                              "assets/images/default.jpg",
                                              fit: BoxFit.cover,
                                              height: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height *
                                                  0.110,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.5,
                                            ),
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.110,
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          .115,
                                      alignment: Alignment.bottomRight,
                                      child: ClipOval(
                                        child: getRating(snapshot.data[index]
                                            .user_rating.aggregate_rating
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
                                  snapshot.data[index].name,
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
                                    top: 2.0, left: 10.0, right: 10.0),
                                child: Container(
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.75,
                                  child: Text(
                                    snapshot.data[index].cuisines,
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
                      ),
                    ),
                  );
                });
          } else {
            return GridView.builder(
                shrinkWrap: true,
                addRepaintBoundaries: true,
                itemCount: 10,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.grey.shade100,
                    // height: 100,
                    width: 180,
                    child: new Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: new FlareActor(
                        "assets/animations/near_by_rest_loading.flr",
                        animation: "loading",
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                });
          }
        } else {
          return GridView.builder(
              shrinkWrap: true,
              addRepaintBoundaries: true,
              itemCount: 10,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.grey.shade100,
                  // height: 100,
                  width: 180,
                  child: new Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: new FlareActor(
                      "assets/animations/near_by_rest_loading.flr",
                      animation: "loading",
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              });
        }
      },
    );
  }
}

Future fetchRestByCollectionID(
    int id, String q, String sorting, int start) async {
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
            DateTime.now().day != 1 &&
            dataSnapshot.data[start.toString()] != null) {
          var _response = dataSnapshot.data[start.toString()];
          searchByCategory = SearchRestraunts.fromJson(json.decode(_response));
        } else {
          flag = true;
        }
      });

      if (flag) {
        print("<fetchRestByCollectionID>");
        Iterable<dynamic> key =
            (await parseJsonFromAssets('assets/api/config.json')).values;
        var apiKey = key.elementAt(0);
        if (sorting != null && id != null) {
          http.Response _response = await http.get(
              "https://developers.zomato.com/api/v2.1/search?entity_id=$city_id&entity_type=city&q=$q&order=$sorting&start=$start&sort=rating",
              headers: {"Accept": "application/json", "user-key": apiKey});
          saveRecommended(
              city_id + "-city-" + "Popular", start.toString(), _response.body);
          searchByCategory =
              SearchRestraunts.fromJson(json.decode(_response.body));
        }
      }
      if (searchByCategory != null) {
        start += 20;
        copydata = List.from(searchByCategory.restaurants);
        List<dynamic> addRest = [];
        if (copydata.length == 20) {
          for (int i = 0; i < copydata.length; i++) {
            if (copydata[i].featured_image.toString() == "") {} else {
              addRest.add(copydata[i]);
            }
          }
          return addRest;
        } else {
          print("Sorry! no result");
          return "error";
        }
      }
    }
  } on SocketException catch (_) {
    print('not connected');
    return "error";
  }
}
