import 'package:bhukkd/Components/CircularBorder.dart';
import 'package:bhukkd/Components/CustomTransition.dart';
import 'package:bhukkd/Pages/RestaurantDetailPage.dart';
import 'package:bhukkd/models/Search/SearchRestaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// custom
import 'package:bhukkd/models/Search/search.dart';
import 'package:progress_indicators/progress_indicators.dart';
import '../Components/HorizontalScroll.dart';
import '../api/HttpRequest.dart';
import '../Components/CustomHorizontalScroll.dart';
import 'package:http/http.dart' as http;
import '../models/SharedPreferance/SharedPreference.dart';
import '../api/LocationRequest.dart';
import '../models/Restruant/Restruant.dart';
import 'package:html/parser.dart';
import '../models/GeoCodeInfo/GeoCode.dart';
import "package:geolocator/geolocator.dart";
import 'dart:async';
import '../models/Locations/Locations.dart';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/GeoCodeInfo/NearByRestaurants/NearByRestaurants.dart';
import 'package:bhukkd/flarecode/flare_actor.dart';


/*------------------------------DISCLAIMER----------------------------------- */
// font used is OpenSans and Montserrat, please dont use any other font.

class TrendingPage extends StatefulWidget {
  TrendingPage({Key key}):super(key:key);
  _TrendingPageState createState() => new _TrendingPageState();
}

bool isReloading = false;

String getSortingValue() {}

List<dynamic> copydata = [];

class _TrendingPageState extends State<TrendingPage> with AutomaticKeepAliveClientMixin {
  String address;
  ScrollController _controller = new ScrollController();
  bool isInitializingRequest = false;
  List<dynamic> rests = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getLocationName().then((locality) {
      if(locality!=null) {
        address = locality.subLocality +
            " " +
            locality.subAdministrativeArea +
            ", " +
            locality.locality +
            " " +
            locality.postalCode;
      }
      });
    callit();
    _controller.addListener(() async {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        await fetchRestByCollectionID(1, sorting: null);
      }
    });
  }

  int start = 0;


  ListView listBuilder;
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body:RefreshIndicator(
        child: GestureDetector(
          onVerticalDragDown: (DragDownDetails scrolldetails) {
            double currentPosition = MediaQuery.of(context).size.height -
                scrolldetails.globalPosition.dy;
          },
          child: Stack(
            children: <Widget>[
              new CustomScrollView(
                controller: _controller,
                physics: ScrollPhysics(),
                slivers: <Widget>[
                  new SliverAppBar(
                    floating: false,
                    title: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.020,
                        ),
                        // new Text("   Your Location",
                        //     style: new TextStyle(
                        //       wordSpacing: 2.0,
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.bold,
                        //       fontFamily: "Montserrat",
                        //       fontSize: 10,
                        //     )),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child:  Align(
                                        alignment: FractionalOffset(0.1, 1),
                                        child: Column(children: <Widget>[
                                          Text("Your Location",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontFamily: "Montserrat",
                                              )),
                                          Text(address==null?"Fetching Your Location..":address,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontFamily: "Montserrat",
                                              )),
                                        ])),
                            ),
                      ],
                    ),
                    backgroundColor: Color.fromRGBO(249, 129, 42, 1),
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
                            letterSpacing: 0.8,
                            wordSpacing: 0.0,
                          ),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.92,
                          height: 175,
                          child: HorizontalScroll()),
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
                          "Recommended",
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
                    ]),
                  ),
                  rests != null
                      ? SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return InkWell(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    HorizontalTransition(
                                        builder: (BuildContext context) =>
                                            RestaurantDetailPage(
                                              productid: rests[index].id,
                                            )));
                              },
                              child: Card(
                                child: Column(
                                  verticalDirection: VerticalDirection.down,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: rests[index].featured_image ==
                                                  null ||
                                              rests[index].featured_image == ""
                                          ? Image.asset(
                                              "assets/images/default.jpg",
                                              fit: BoxFit.cover,
                                              height: 130,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl:
                                                  rests[index].featured_image,
                                              fit: BoxFit.cover,
                                              height: 130,
                                              placeholder: Image.asset(
                                                "assets/images/default.jpg",
                                                fit: BoxFit.cover,
                                                height: 130,
                                              ),
                                              errorWidget: Icon(Icons.error),
                                            ),
                                    ),
                                    Text(
                                      rests[index].name,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Roboto"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        rests[index].cuisines,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: "Roboto",
                                            color: Colors.deepOrange),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                              childCount: rests.length,
                              addRepaintBoundaries: true))
                      : Container(
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
//                          print("Search");
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
                                child: Icon(Icons.search,
                                    color: Colors.deepOrange),
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
        ),
        onRefresh: refresh,
      ),
    );
  }


  Future<Null> refresh() async {
    isReloading = true;
    getLocationName().then((locality) {
      if(locality!=null) {
        address = locality.subLocality +
            " " +
            locality.subAdministrativeArea +
            ", " +
            locality.locality +
            " " +
            locality.postalCode;
      }
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      CustomHorizontalScroll();
      HorizontalScroll();
      callit();
      _controller.addListener(() async {
        if (_controller.position.pixels == _controller.position.maxScrollExtent) {
          await fetchRestByCollectionID(1, sorting: null);
        }
      });
    });
    return null;
  }

  Future callit() async {
    await fetchRestByCollectionID(1, sorting: null);
  }



  Future fetchRestByCollectionID(int id, {String sorting}) async {
    Iterable<dynamic> key =
        (await parseJsonFromAssets('assets/api/config.json')).values;
    var apiKey = key.elementAt(0);

    double latitude, longitude;
    await StoreUserLocation.get_CurrentLocation().then((loc) {
      latitude = double.parse(loc[0]);
      longitude = double.parse(loc[1]);
      /*print("$longitude, $latitude");*/
    });

    if (!isInitializingRequest) {
      setState(() {
        isInitializingRequest = true;
      });
      if (sorting == null && id != null) {
        http.Response response = await http.get(
            "https://developers.zomato.com/api/v2.1/search?lat=${latitude.toString()}&lon=${longitude.toString()}&start=$start&sort=rating&order=desc",
            headers: {"Accept": "application/json", "user-key": apiKey});
        start += 20;
//        print(response.body);
        SearchRestraunts searchByCategory =
        SearchRestraunts.fromJson(json.decode(response.body));
        copydata = List.from(searchByCategory.restaurants);
        List<dynamic> addRest =
        new List.generate(20, (index) => copydata[index]);
        setState(() {
          rests.addAll(addRest);
          isInitializingRequest = false;
        });
      }
    }
  }
}


//.......................................important........................................//

Future<Placemark> getLocationName() async {
  double latitude, longitude;
try {
  await StoreUserLocation.get_CurrentLocation().then((loc) {
    latitude = double.parse(loc[0]);
    longitude = double.parse(loc[1]);
//    print("$longitude, $latitude");
  });

  //Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  Geolocator geolocator = Geolocator()
    ..forceAndroidLocationManager = true;
  GeolocationStatus geolocationStatus =
  await geolocator.checkGeolocationPermissionStatus();
  if (geolocationStatus == GeolocationStatus.granted) {
    List<Placemark> placemark =
    await Geolocator().placemarkFromCoordinates(latitude, longitude);
    return placemark[0];
  } else {
    print("Location denied ");
    return null;
  }
}catch(e){
  print("error: "+ e.message);
}
}

//.......................................important........................................//



