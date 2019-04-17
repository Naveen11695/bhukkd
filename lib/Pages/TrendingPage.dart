// flutter
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// custom
import 'package:bhukkd/models/Search/search.dart';
import '../Components/HorizontalScroll.dart';
import '../api/HttpRequest.dart';
import '../Components/CustomHorizontalScroll.dart';
import '../Components/CategoriesComponent.dart';
import 'package:http/http.dart' as http;
import '../models/SharedPreferance/SharedPreference.dart';
import '../api/LocationRequest.dart';
import '../models/Restruant/Restruant.dart';
import 'package:html/parser.dart';
import '../models/GeoCodeInfo/GeoCode.dart';
import "package:geolocator/geolocator.dart";
import 'package:loading_card/loading_card.dart';
import 'package:geocoder/geocoder.dart';
import 'dart:async';
import '../models/Locations/Locations.dart';
import 'dart:convert';
import '../models/GeoCodeInfo/NearByRestaurants/NearByRestaurants.dart';

Future getEntityFromLocations(String nameOfTheLocation) async{
  getKey();
  String url="https://developers.zomato.com/api/v2.1/locations?query=$nameOfTheLocation";
  final response = await http.get(Uri.encodeFull(url), headers: {
    "Accept":"application/json",
    "user-key":api_key
  });
  print("----------Location entity--------------------------------------------------------------------");
  if(response.statusCode == 200){
    Map<String, dynamic> jsonParsed=json.decode(response.body);
    List<dynamic> data=jsonParsed["location_suggestions"];
    print(data[0]);
    Map<String, dynamic> location_suggestion_data = data[0];
    Locations loc = new Locations(entity_type: location_suggestion_data["entity_type"], entity_id: location_suggestion_data["entity_id"], city_id: location_suggestion_data['city_id'], city_name: location_suggestion_data['city_name'], country_id: location_suggestion_data['country_id'], country_name: location_suggestion_data['country_name'], latitude: location_suggestion_data['latitude'], longitude: location_suggestion_data['longitude'], title: location_suggestion_data['title']);
    
    return getTopRestaurants(loc.entity_id.toString(), loc.entity_type);

  }
  else{
    print("----------PROBLEM--------------------------------------------------------------------------");
  }
  print("---------------------------------------------------------------------------------------------");
}



Future getTopRestaurants(String entity_id, String entity_type) async{
  getKey();
  print("entity id: " + entity_id);
  print("entity type: " + entity_type);
  String url = "https://developers.zomato.com/api/v2.1/location_details?entity_id=$entity_id&entity_type=$entity_type";
  final response=await http.get(Uri.encodeFull(url), headers: {
    "Accept":"application/json",
    "user-key":api_key
  });
  if(response.statusCode == 200){
    print("----------------------top restaurant data according to the location----------------");
    //print(response.body);
    Map<String, dynamic> jsonParsed=json.decode(response.body);
    List<dynamic> bestRestaurants=jsonParsed['best_rated_restaurant'];
    List<NearByRestaurants> bestRest = [];
    for(var r in bestRestaurants){
      NearByRestaurants res =NearByRestaurants.fromJson(r);
      bestRest.add(res);
    }
    for(var i in bestRest){
      print(i.name);
    }
    print("--------------------------------------------------------------------------------------");
    return bestRest;
  }
  else{
    print("------------------------------------------------error------------------------------");
  }
}


/*------------------------------DISCLAIMER----------------------------------- */
// font used is OpenSans and Montserrat, please dont use any other font.

class TrendingPage extends StatefulWidget {
  _TrendingPageState createState() => new _TrendingPageState();
}

//.......................................important........................................//



var loc_address = "";

void getLocationName() async{
  var addresses;
  var first;
  getCurrentPosition().then((Position pos) async{
    final coordinates = new Coordinates(pos.latitude,pos.longitude);
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first = addresses.first;
    var temp = first.addressLine.split(",");
    print(temp);
    loc_address =  temp[1] + " " + temp[2] +", "+ temp[3];
    print(loc_address);
     //loc_address = temp[temp.length-5] + temp[temp.length-4] + temp[temp.length-3]  + temp[temp.length-2] + "," + temp[temp.length-1];
    // print(loc_address);
  });
}

//.......................................important........................................//

class _TrendingPageState extends State<TrendingPage> {
  @override
  void initState() {
    super.initState();
    refresh();
  }

  ListView listBuilder; //= ListView.builder(
  //     scrollDirection: Axis.horizontal,
  //     itemCount: nearByrestaurants.length,
  //     itemBuilder: (BuildContext context, index) {
  //       return HorizontalScroll(index);
  //     });

  Future<Null> refresh() async {
     getCurrentPosition();
    // getLocationName();
    // fetchRestByGeoCode();
    await Future.delayed(Duration(seconds: 5));
    // setState(() {
    //   listBuilder = ListView.builder(
    //       scrollDirection: Axis.horizontal,
    //       itemCount: nearByrestaurants.length,
    //       itemBuilder: (BuildContext context, index) {
    //         return HorizontalScroll();
    //       });
    // });
    return null;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: GestureDetector(
        onVerticalDragDown: (DragDownDetails scrolldetails) {
          double currentPosition = MediaQuery.of(context).size.height -
              scrolldetails.globalPosition.dy;
        },
        child: Stack(
          children: <Widget>[
            new CustomScrollView(
              physics: ScrollPhysics(),
              slivers: <Widget>[
                new SliverAppBar(
                  floating: false,
                  title: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                      new Text("   Your Location",
                          style: new TextStyle(
                            wordSpacing: 2.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                            fontSize: 20,
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0,0,0),
                        child: new Text(
                          loc_address,
                          style: new TextStyle(
                            color: Colors.white,
                            fontFamily: "Montserrat-Bold",
                            fontSize: 10,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Color.fromRGBO(249, 129, 42, 1),

                  leading: Padding(
                    padding: const EdgeInsets.fromLTRB(40,10,0,0),
                    child: new Icon(
                      Icons.location_on,
                      semanticLabel: "Your Location",
                      textDirection: TextDirection.ltr,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  titleSpacing: 0.4,
                  expandedHeight: MediaQuery.of(context).size.height * 0.13,
                  pinned: true,
                  primary: true,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.height * 0.92,
                      alignment: AlignmentDirectional.topStart,
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      child: new Text(
                        "Near By Restaurants",
                        textAlign: TextAlign.start,
                        style: new TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Montserrat-Bold",
                          // fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          wordSpacing: 0.0,
                        ),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.92,
                        height: 175,
                        child: HorizontalScroll()
                      ),
                    Container(
                      width: MediaQuery.of(context).size.height * 0.92,
                      alignment: AlignmentDirectional.topStart,
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      child: new Text(
                        "Top Restraunts",
                        textAlign: TextAlign.start,
                        style: new TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Monserrat-Bold",
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          wordSpacing: 0.0,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade100,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                        child: CustomHorizontalScroll(),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.height * 0.92,
                      alignment: AlignmentDirectional.topStart,
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      child: new Text(
                        "Categories",
                        textAlign: TextAlign.start,
                        style: new TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Montserrat-Bold",
                          // fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          wordSpacing: 0.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: CategoriesComponent(),
                    )
                  ]),
                ),
              ],
            ),
            new Container(
              height: 50,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.13,
                  right: 15,
                  left: 15),
              child: Material(
                type: MaterialType.canvas,
                elevation: 10.0,
                borderRadius: BorderRadius.circular(25.0),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    child: InkWell(
                      onTap: () {
                        print("Search");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchList(),
                            ));
                      },
                      splashColor: Colors.white24,
                      highlightColor: Colors.white10,
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Icon(Icons.search, color: Colors.deepOrange),
                            ),
                            Center(
                              child: Text(
                                "Search for trending restraunts nearby",
                                style: new TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16.0,
                                    color: Colors.deepOrange,
                                    shadows: [
                                      Shadow(
                                          offset: Offset(0.3, 0.1),
                                          color: Colors.grey),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ), onRefresh:refresh,
      ),
    );
  }
}
