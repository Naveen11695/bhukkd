import 'dart:convert';
import 'package:bhukkd/api/HttpRequest.dart';
import 'package:bhukkd/models/Locations/Locations.dart';
import 'package:http/http.dart' as http;
import 'package:bhukkd/Components/CustomTransition.dart';
import 'package:bhukkd/flarecode/flare_actor.dart';
import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/NearByRestaurants.dart';
import 'package:flutter/material.dart';
import '../Pages/TrendingPage.dart';
import '../Pages/RestaurantDetailPage.dart';

class CustomHorizontalScroll extends StatelessWidget {
TrendingPage trendingPage;
  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.4;
    return Container(
        height: 150,
        child: FutureBuilder(
          future: _getEntityFromLocations(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if(snapshot.data=="error"){
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
              else if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: new Material(
                        elevation: 10.0,
                        child: Container(
                          margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                          height: 100,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: <Widget>[
                                new Container(
                                  margin: EdgeInsets.only(left: 3),
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                      image: snapshot.data[index].thumb ==
                                                  null ||
                                              snapshot.data[index].thumb == ""
                                          ? AssetImage(
                                              "assets/images/default.jpg")
                                          : NetworkImage(
                                              snapshot.data[index].thumb),
                                      fit: BoxFit.cover,
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
                                    new Text(
                                      snapshot.data[index].name,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: TextStyle(
                                          fontFamily: "Raleway", fontSize: 15),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:5.0,bottom: 5.0),
                                      child: Container(
                                        width: c_width,
                                        child: new Text(
                                        snapshot.data[index]
                                              .near_by_restaurants_location[
                                          "address"],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: "", fontSize: 11, color: Colors.deepOrange),
                                        ),
                                      ),
                                    ),

                                    new SizedBox(
                                      height: 8,
                                    ),
                                    new Container(
                                      height: 1,
                                      width: 60,
                                      color: Colors.deepOrange,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:10.0),
                                      child: new Row(
                                        children: <Widget>[
                                          Icon(Icons.star,
                                              color: Colors.deepOrange),
                                          Icon(Icons.star,
                                              color: Colors.deepOrange),
                                          Icon(Icons.star, color: Colors.orange),
                                          Icon(Icons.star, color: Colors.orange),
                                          Icon(Icons.star, color: Colors.black12),
                                        ],
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
Future _getEntityFromLocations() async {
  try {
    String nameOfTheLocation;
    await getLocationName().then((loc) {
      nameOfTheLocation = loc.subLocality;
    });
    getKey();
    print("TopRestaurants Api Key: "+ api_key);
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
        return getTopRestaurants(loc.entity_id.toString(), loc.entity_type);
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

Future getTopRestaurants(String entity_id, String entity_type) async {
  getKey();
//  print("entity id: " + entity_id);
//  print("entity type: " + entity_type);
  String url =
      "https://developers.zomato.com/api/v2.1/location_details?entity_id=$entity_id&entity_type=$entity_type";
  final response = await http.get(Uri.encodeFull(url),
      headers: {"Accept": "application/json", "user-key": api_key});
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonParsed = json.decode(response.body);
    List<dynamic> bestRestaurants = jsonParsed['best_rated_restaurant'];
    List<NearByRestaurants> bestRest = [];
    for (var r in bestRestaurants) {
      NearByRestaurants res = NearByRestaurants.fromJson(r);
      bestRest.add(res);
    }
    return bestRest;
  } else {
    print("getTopRestaurants Problem");
  }
}
}
