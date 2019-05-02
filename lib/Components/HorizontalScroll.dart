import 'dart:convert';

import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/NearByRestaurants.dart';
import 'package:bhukkd/models/Locations/Locations.dart';
import 'package:bhukkd/models/SharedPreferance/SharedPreference.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/GeoCodeInfo/GeoCode.dart';
import '../models/Restruant/Restruant.dart';
import '../Pages/RestaurantDetailPage.dart';
import '../Components/CustomTransition.dart';
import '../api/HttpRequest.dart';
import 'package:bhukkd/flarecode/flare_actor.dart';
import '../Pages/TrendingPage.dart';
import '../Pages/HomePage.dart';
import 'package:http/http.dart' as http;

class HorizontalScroll extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HorizontalScrollState();
  }
}
AsyncSnapshot fetchRestByGeoCodeData;
class HorizontalScrollState extends State<HorizontalScroll> with AutomaticKeepAliveClientMixin{
  Future<dynamic> fetchRestGeoCode;
  int count=1;
  @override
  void initState() {
    super.initState();
    fetchRestGeoCode = _getEntityFromLocations();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: count==1 || isReloading == true?_getEntityFromLocations() : fetchRestGeoCode,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          fetchRestByGeoCodeData=snapshot;
          count++;
          isReloading=false;
          if (snapshot.data == "error") {
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
          } else if (snapshot.data != null) {
            return ListView.builder(
                addAutomaticKeepAlives: true,
                cacheExtent: 10,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      child: ClipRRect(
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
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
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
                                              child: (snapshot
                                                          .data[
                                              index]
                                                          .thumb ==
                                                      "")
                                                  ? new Image.asset(
                                                      "assets/images/5.jpg",
                                                      fit: BoxFit.cover,
                                                      width: 150,
                                                      height: 105,
                                                    )
                                                  : CachedNetworkImage(
                                                      imageUrl: snapshot
                                                          .data
                                                          [
                                                              index]
                                                          .thumb,
                                                      fit: BoxFit.cover,
                                                      width: 150,
                                                      height: 105,
                                                      placeholder: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(35.0),
                                                        child:
                                                            Center(child: CircularProgressIndicator()),
                                                      ),
                                                      errorWidget:
                                                          Icon(Icons.error),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: new Text(
                                          snapshot.data[index].name,
                                          textDirection: TextDirection.ltr,
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(
                                              fontFamily: "Raleway",
                                              shadows: [
                                                Shadow(
                                                    offset: Offset(0.3, 0.1),
                                                    color: Colors.grey),
                                              ]),
                                          softWrap: true,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: new Text(
                                          snapshot
                                              .data[index]
                                              .cuisines,
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.deepOrange),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ));
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

  Future _getEntityFromLocations() async {
    double latitude, longitude;
      await StoreUserLocation.get_CurrentLocation().then((loc) {
        latitude = double.parse(loc[0]);
        longitude = double.parse(loc[1]);
//    print("$longitude, $latitude");
      });
    try {
      String nameOfTheLocation;
      await getLocationName().then((loc) {
        nameOfTheLocation = loc.subLocality;
      });
      getKey();
      print("NearByRestaurants Api Key: "+ api_key);
      String url =
          "https://developers.zomato.com/api/v2.1/locations?query=$nameOfTheLocation";
      final response = await http.get(Uri.encodeFull(url),
          headers: {"Accept": "application/json", "user-key": api_key});
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonParsed = json.decode(response.body);
        List<dynamic> data = jsonParsed["location_suggestions"];
        Map<String, dynamic> location_suggestion_data = data[0];
        Locations loc = new Locations(
            entity_type: location_suggestion_data["entity_type"],
            entity_id: location_suggestion_data["entity_id"],
            city_id: location_suggestion_data['city_id'],
            city_name: location_suggestion_data['city_name'],
            country_id: location_suggestion_data['country_id'],
            country_name: location_suggestion_data['country_name'],
            latitude: location_suggestion_data['latitude'],
            longitude: location_suggestion_data['longitude'],
            title: location_suggestion_data['title']);


        if(nameOfTheLocation==""){
          return "error";
        }
        else{
          print("ok!");
          return getNearByRestaurants(loc.entity_id.toString(), loc.entity_type, latitude.toString(), longitude.toString());
        }

      } else {
        print("getEntityFromLocations Problem");
        return "error";
      }
    } catch (e) {
      print('not connected');
      return "error";
    }
  }


  Future getNearByRestaurants(String entity_id, String entity_type, String latitude, String longitude) async {
    getKey();
//  print("entity id: " + entity_id);
//  print("entity type: " + entity_type);
    String url =
        "https://developers.zomato.com/api/v2.1/search?entity_id=$entity_id&entity_type=$entity_type&lat=$latitude&lon=$longitude&&sort=real_distance";
    final response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json", "user-key": api_key});
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonParsed = json.decode(response.body);
      List<dynamic> bestRestaurants = jsonParsed['restaurants'];
      List<NearByRestaurants> bestRest = [];
      for (var r in bestRestaurants) {
        NearByRestaurants res = NearByRestaurants.fromJson(r);
        bestRest.add(res);
      }
      return bestRest;
    } else {
      print("getNearByRestaurants Problem");
    }
  }

}
