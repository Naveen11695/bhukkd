// flutter
import 'package:flutter/material.dart';

// custom
import '../Components/HorizontalScroll.dart';
import '../api/HttpRequest.dart';
import 'package:http/http.dart';
import '../models/SharedPreferance/SharedPreference.dart';
import '../api/LocationRequest.dart';
import '../models/Restruant/Restruant.dart';
import 'package:html/parser.dart';
import '../models/GeoCodeInfo/GeoCode.dart';

class TrendingPage extends StatefulWidget {
  _TrendingPageState createState() => new _TrendingPageState();

  void fetchRestByGeoCode() {
    StoreUserLocation.getLocation().then((loc) {
      latitude = loc[0].toString();
      longitude = loc[1].toString();
      print("$longitude, $latitude");
    });
    requestGeoCode("https://developers.zomato.com/api/v2.1/geocode?lat=28.7367039&lon=77.1346744", latitude, longitude);
    //return dataFromGeoCode;
    // await dataFromGeoCode.then((data){
    //   print(data.link);
    // });

  }
}

// temp variable
String latitude;
String longitude;



//Restaurant restaurant;
// void _fetchRestaurant() {
//    //requestRestaurant("https://developers.zomato.com/api/v2.1/restaurant?res_id=1806", "1806").then((rest){
//   //  print(rest.restruant_Name);
//   //print(rest.restruant_Menu);
//   //fetchPhotos(rest.restruant_Photo_url);
//   //fetchMenu(rest.restruant_Menu);
//   //rest=restaurant;
// });
// }

Future fetchPhotos(String url) async {
  var client = new Client();
  Response response = await client.get(url);
  var photos = parse(response.body);
  //thumbnails
  List<dynamic> thumbLinks = photos
      .querySelectorAll('div.photos_container_load_more>div>a.res-info-thumbs');
  //photos
  List<dynamic> photoLinks = photos.querySelectorAll(
      'div.photos_container_load_more>div.photobox>a.res-info-thumbs>img');
  print("-----------extra photo info links-----------");
  for (var link in thumbLinks) {
    print(link.attributes['href']);
  }
  print("----------Photo links------------");
  List<String> restarauntPhotos = new List<String>();
  for (var photoLink in photoLinks) {
    restarauntPhotos.add(photoLink.attributes['data-original']
        .replaceAll("?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A", ""));
  }

  for (var link in restarauntPhotos) {
    print(link);
  }
}

Future fetchMenu(String url) async {
  var client = new Client();
  Response response = await client.get(url);
  var menu = parse(response.body);
  List<dynamic> menuLink = menu.querySelectorAll('div#menu-image>img');
  print("----------Menu Image-------------");
  for (var link in menuLink) {
    print(link.attributes['src']);
  }
}

class _TrendingPageState extends State<TrendingPage> {
  @override
  void initState() {
    super.initState();
    //fetchRestByGeoCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Column(
            children: <Widget>[
              new Text("Now",
                  style: new TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      height: 1.9,
                      fontWeight: FontWeight.bold)),
//              Container(
//                height: 10.0,
//                width: 40.0,
//                child: Text(" Now",
//
//                  style: TextStyle(color: Colors.black,
//                      fontSize: 15.0, height: 1.9,
//                      fontWeight: FontWeight.bold
//                  ),
//                ),
//
//              ),
              SizedBox(height: 0.5),
              Text(
                "-------",
                style: TextStyle(color: Colors.black, fontSize: 15.0),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Icon(
              Icons.arrow_forward,
              color: Colors.black,
              size: 12.0,
            ),
          ),
          SizedBox(
            width: 70,
          ),
          Column(
            children: <Widget>[
              Container(
                height: 20.0,
                width: 100.0,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                "                                                                     ",
                style: TextStyle(color: Colors.black, fontSize: 15.0),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                child: Text(
                  "Latest Offers",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 1),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
            child: Column(
              children: <Widget>[
               new Container(width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.40,

                child: new ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index){
                  return HorizontalScroll();
                },
                ),
               ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: Row(
              children: <Widget>[
                Text(
                  "Resturaunt",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 210.0),
                Icon(
                  Icons.sort,
                  color: Colors.grey,
                  size: 15.0,
                ),
                Text(
                  "Sort/Filter",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Container(
                    height: 75.0,
                    width: 75.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child:
                        Image.asset("assets/images/food.png", fit: BoxFit.fill),
                  ),
                  subtitle: Column(
                    children: <Widget>[
                      Text(
                        "haldirams",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading: Container(
                    height: 75.0,
                    width: 75.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child:
                    Image.asset("assets/images/food.png", fit: BoxFit.fill),
                  ),
                  subtitle: Column(
                    children: <Widget>[
                      Text(
                        "haldirams",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading: Container(
                    height: 75.0,
                    width: 75.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child:
                    Image.asset("assets/images/food.png", fit: BoxFit.fill),
                  ),
                  subtitle: Column(
                    children: <Widget>[
                      Text(
                        "haldirams",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading: Container(
                    height: 75.0,
                    width: 75.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child:
                    Image.asset("assets/images/food.png", fit: BoxFit.fill),
                  ),
                  subtitle: Column(
                    children: <Widget>[
                      Text(
                        "haldirams",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading: Container(
                    height: 75.0,
                    width: 75.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child:
                    Image.asset("assets/images/food.png", fit: BoxFit.fill),
                  ),
                  subtitle: Column(
                    children: <Widget>[
                      Text(
                        "haldirams",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading: Container(
                    height: 75.0,
                    width: 75.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child:
                    Image.asset("assets/images/food.png", fit: BoxFit.fill),
                  ),
                  subtitle: Column(
                    children: <Widget>[
                      Text(
                        "haldirams",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ), 
                      
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                  child: Column(
                    children: <Widget>[
                    new Container(width: double.infinity,
                      height: 275,

                      child: new ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index){
                        return HorizontalScroll();
                      },
                      ),
                    ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
