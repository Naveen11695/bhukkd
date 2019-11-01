import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:bhukkd/Components/CustomTransition.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Pages/RestaurantDetailPage.dart';
import 'package:bhukkd/Pages/TrendingPage/Componets/HorizontalScroll.dart';
import 'package:bhukkd/Pages/TrendingPage/TrendingPage.dart';
import 'package:bhukkd/Services/HttpRequest.dart';
import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/NearByRestaurants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomHorizontalScroll extends StatefulWidget {
  @override
  _CustomHorizontalScrollState createState() => _CustomHorizontalScrollState();
}

final fetchRestGeoCode = new AsyncMemoizer();

Future asyncfetchRestGeoCode() =>
    fetchRestGeoCode.runOnce(() {
      return getTopRestaurants();
    });

class _CustomHorizontalScrollState extends State<CustomHorizontalScroll> {

  @override
  void initState() {
    super.initState();
  }

  TrendingPage trendingPage;

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery
        .of(context)
        .size
        .width * 0.4;
    return Container(
        height: 150,
        child: FutureBuilder(
          future: asyncfetchRestGeoCode(),
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == "error") {
                return Container(
                  child: ListView.builder(
                      cacheExtent: 10,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            color: Colors.grey.shade100,
                            height: 100,
                            width: 300,
                            child: new Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: new FlareActor(
                                "assets/animations/top_restaurant_loading.flr",
                                animation: "circular_loading",
                                fit: BoxFit.cover,
                              ),
                            ));
                      }),
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  reverse: false,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: new Material(
                        elevation: 10.0,
                        child: Container(
                          margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                          height: 100,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.8,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: <Widget>[
                                new ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data[index].thumb,
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 105,
                                    placeholder: (context, url) =>
                                    new Image.asset(
                                      "assets/images/default.jpg",
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 105,
                                    ),
                                  ),
                                ),
                                new SizedBox(
                                  width: 20,
                                ),
                                new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: c_width,
                                      child: new Text(
                                        snapshot.data[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: TextStyle(
                                            fontFamily: FONT_TEXT_PRIMARY,
                                            fontSize: 15,
                                            color: TEXT_PRIMARY_COLOR),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, bottom: 5.0),
                                      child: Container(
                                        width: c_width,
                                        child: new Text(
                                          snapshot.data[index]
                                              .near_by_restaurants_location[
                                          "address"],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: FONT_TEXT_SECONDARY,
                                              fontSize: 11,
                                              color: TEXT_SECONDARY_COLOR),
                                        ),
                                      ),
                                    ),

                                    new SizedBox(
                                      height: 8,
                                    ),
                                    new Container(
                                      height: 1,
                                      width: 60,
                                      color: TEXT_SECONDARY_COLOR,
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: getStarWidgets(
                                        snapshot.data[index].user_rating
                                            .aggregate_rating,
                                      ),
                                    ),
                                    new SizedBox(height: 8),
                                    new Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: <Widget>[],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            HorizontalTransition(
                                builder: (BuildContext context) =>
                                    RestaurantDetailPage(
                                      productid: snapshot.data[index].id,
                                    )));
                      },
                    );
                  },
                );
              }
            } else {
              return Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          color: Colors.grey.shade100,
                          height: 100,
                          width: 300,
                          child: new Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: new FlareActor(
                              "assets/animations/top_restaurant_loading.flr",
                              animation: "circular_loading",
                              fit: BoxFit.cover,
                            ),
                          ));
                    }),
              );
            }
          },
        ));
  }
}


Future getTopRestaurants() async {
  try {
    getKey();
    String entity_id;
    String entity_type;
    await getEntityFromLocations().then((loc) {
      entity_id = loc.entity_id.toString();
      entity_type = loc.entity_type.toString();
    });

    bool flag = false;
    Map<String, dynamic> jsonParsed;
    var fireStore = Firestore.instance;
    DocumentReference snapshot =
    fireStore.collection('TopRestaurants').document(
        entity_type + "-" + entity_id);
    await snapshot.get().then((dataSnapshot) {
      if (dataSnapshot.exists && DateTime
          .now()
          .day != 2) {
        final response = dataSnapshot.data[entity_type + "-" + entity_id];
        jsonParsed = json.decode(response);
      }
      else {
        flag = true;
      }
    });

    if (flag) {
      print("<TopRestaurants>");
      String url =
          "https://developers.zomato.com/api/v2.1/location_details?entity_id=$entity_id&entity_type=$entity_type";
      final response = await http.get(Uri.encodeFull(url),
          headers: {"Accept": "application/json", "user-key": api_key});
      if (response.statusCode == 200) {
        jsonParsed = json.decode(response.body);
        saveTopByRestaurants(entity_type + "-" + entity_id, response.body);
      } else {
        print("<TopRestaurants> Problem");
        return "error";
      }
    }
    List<dynamic> bestRestaurants = jsonParsed['best_rated_restaurant'];
    List<NearByRestaurants> bestRest = [];
    for (var r in bestRestaurants) {
      NearByRestaurants res = NearByRestaurants.fromJson(r);
      if (res.thumb.length != 0) {
        bestRest.add(res);
      }
    }

    return bestRest;
  } catch (e) {
    print("<TopRestaurants> Problem" + e.toString());
    return "error";
  }
}

void saveTopByRestaurants(String entity_id_type, String data) {
  Firestore.instance
      .collection("TopRestaurants")
      .document(entity_id_type)
      .setData({
    entity_id_type: data
  });
}


Widget getStarWidgets(String size) {
  var Size = double.parse(size);
  var list = [];
  for (int i = 1; i <= Size; i++) {
    list.add("s");
  }
  for (int i = list.length; i < 5; i++) {
    list.add("u");
  }
  return new Row(
      children: list
          .map((item) =>
      item == "s"
          ? Icon(Icons.star, color: SECONDARY_COLOR_1, size: 20,)
          : Icon(Icons.star, color: Colors.black12))
          .toList());
}
