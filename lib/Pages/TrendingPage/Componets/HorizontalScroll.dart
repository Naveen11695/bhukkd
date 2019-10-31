import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:bhukkd/Components/CustomTransition.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Pages/RestaurantDetailPage.dart';
import 'package:bhukkd/Pages/TrendingPage/TrendingPage.dart';
import 'package:bhukkd/Services/HttpRequest.dart';
import 'package:bhukkd/Services/SharedPreference.dart';
import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/NearByRestaurants.dart';
import 'package:bhukkd/models/Locations/Locations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HorizontalScroll extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HorizontalScrollState();
  }
}

final _fetchRestByGeoCodeData = new AsyncMemoizer();

Future fetchRestByGeoCodeData() =>
    _fetchRestByGeoCodeData.runOnce(() {
      return getNearByRestaurants();
    });


class HorizontalScrollState extends State<HorizontalScroll>
    with AutomaticKeepAliveClientMixin {
  var count = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: fetchRestByGeoCodeData(),
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          count++;
          isReloading = false;
          if (snapshot.data == "error") {
            return Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
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
                        ));
                  }),
            );
          } else if (snapshot.data != null) {
            return ListView.builder(
                addAutomaticKeepAlives: true,
                cacheExtent: 10,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(7)),
                    child: new Container(
                      constraints: BoxConstraints.expand(
                        width: 185.0,
                      ),
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
                        child: new Container(
                          child: Card(
                            margin:
                            EdgeInsets.only(left: 5, top: 2, bottom: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            elevation: 10,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: (snapshot.data[index]
                                            .thumb ==
                                            "")
                                            ? new Image.asset(
                                          "assets/images/default.jpg",
                                          fit: BoxFit.cover,
                                          width: 150,
                                          height: 105,
                                        )
                                            : CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data[index].thumb,
                                          fit: BoxFit.cover,
                                          width: 150,
                                          height: 105,
                                          placeholder: (context, url) =>
                                          new Image.asset(
                                            "assets/images/default.jpg",
                                            fit: BoxFit.cover,
                                            width: 150,
                                            height: 105,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 5.0, right: 5.0),
                                  child: new Text(
                                    snapshot.data[index].name,
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                        fontFamily: FONT_TEXT_PRIMARY,
                                        color: TEXT_PRIMARY_COLOR,
                                        fontSize: 14,
                                        shadows: [
                                          Shadow(
                                              offset: Offset(0.5, 0.1),
                                              color: Colors.grey),
                                        ]),
                                    softWrap: true,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: new Text(
                                    snapshot.data[index].cuisines,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                        fontSize: 12.0,
                                        color: TEXT_SECONDARY_COLOR,
                                        fontFamily: FONT_TEXT_SECONDARY),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
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
                      // height: 100,
                      width: 180,
                      child: new Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: new FlareActor(
                          "assets/animations/near_by_rest_loading.flr",
                          animation: "loading",
                          fit: BoxFit.cover,
                        ),
                      ));
                }),
          );
        }
      },
    );
  }
}


void saveNearByRestaurantsLocation(String nameOfTheLocation, String data) {
  Firestore.instance
      .collection("Location")
      .document(nameOfTheLocation)
      .setData({
    nameOfTheLocation: data
  });
}
Future getEntityFromLocations() async {
  double latitude, longitude;
  await StoreUserLocation.get_CurrentLocation().then((loc) {
    latitude = double.parse(loc[0]);
    longitude = double.parse(loc[1]);
  });


  try {
    String nameOfTheLocation;
    LocationName().then((loc) {
      nameOfTheLocation = loc.locality;
    });
    if (nameOfTheLocation == "") {
      return "error";
    }
    getKey();

    bool flag = false;
    Locations loc;
    Map<String, dynamic> location_suggestion_data;
    var fireStore = Firestore.instance;
    DocumentReference snapshot =
    fireStore.collection('Location').document(nameOfTheLocation);
    await snapshot.get().then((dataSnapshot) {
      if (dataSnapshot.exists) {
        var _response = dataSnapshot.data[nameOfTheLocation];
        Map<String, dynamic> jsonParsed = json.decode(_response);
        List<dynamic> data = jsonParsed["location_suggestions"];
        location_suggestion_data = data[0];
      }
      else {
        flag =true;
      }
    });

    if(flag) {
      print("<location_suggestions>");
      String url =
          "https://developers.zomato.com/api/v2.1/locations?query=$nameOfTheLocation";
      final response = await http.get(Uri.encodeFull(url),
          headers: {"Accept": "application/json", "user-key": api_key});
      if (response.statusCode == 200) {
        saveNearByRestaurantsLocation(nameOfTheLocation, response.body);
        Map<String, dynamic> jsonParsed = json.decode(response.body);
        List<dynamic> data = jsonParsed["location_suggestions"];
        location_suggestion_data = data[0];
      } else {
        print("getEntityFromLocations Problem");
        return "error";
      }
    }

    loc = new Locations(
        entity_type: location_suggestion_data["entity_type"],
        entity_id: location_suggestion_data["entity_id"],
        city_id: location_suggestion_data['city_id'],
        city_name: location_suggestion_data['city_name'],
        country_id: location_suggestion_data['country_id'],
        country_name: location_suggestion_data['country_name'],
        latitude: location_suggestion_data['latitude'],
        longitude: location_suggestion_data['longitude'],
        title: location_suggestion_data['title']);
    return loc;
  } catch (e) {
    print('not connected');
    return "error";
  }
}

Future getNearByRestaurants() async {
  try {
    getKey();
    String entity_id;
    String entity_type;
    String latitude;
    String longitude;
    await getEntityFromLocations().then((loc) {
      entity_id = loc.entity_id.toString();
      entity_type = loc.entity_type.toString();
      longitude = loc.longitude.toString();
      latitude = loc.latitude.toString();
    });
    bool flag = false;
    Map<String, dynamic> jsonParsed;
    var fireStore = Firestore.instance;
    DocumentReference snapshot =
    fireStore.collection('NearByRestaurants').document(
        entity_type + "-" + entity_id);
    await snapshot.get().then((dataSnapshot) {
      if (dataSnapshot.exists && DateTime
          .now()
          .day != 1) {
        final response = dataSnapshot.data[entity_type + "-" + entity_id];
        jsonParsed = json.decode(response);
      }
      else {
        flag = true;
      }
    });

    if (flag) {
      print("<NearByRestaurants>");
      String url =
          "https://developers.zomato.com/api/v2.1/geocode?lat=$latitude&lon=$longitude";
      final response = await http.get(Uri.encodeFull(url),
          headers: {"Accept": "application/json", "user-key": api_key});
      if (response.statusCode == 200) {
        saveNearByRestaurants(entity_type + "-" + entity_id, response.body);
        jsonParsed = json.decode(response.body);
      } else {
        print("<NearByRestaurants> Problem");
        return "error";
      }
    }
    List<dynamic> bestRestaurants = jsonParsed['nearby_restaurants'];
    List<NearByRestaurants> bestRest = [];
    for (var r in bestRestaurants) {
      NearByRestaurants res = NearByRestaurants.fromJson(r);
      bestRest.add(res);
    }
    return bestRest;
  } catch (e) {
    print("<NearByRestaurants> Problem");
    return "error";
  }
}


void saveNearByRestaurants(String entity_id_type, String data) {
  Firestore.instance
      .collection("NearByRestaurants")
      .document(entity_id_type)
      .setData({
    entity_id_type: data
  });
}







