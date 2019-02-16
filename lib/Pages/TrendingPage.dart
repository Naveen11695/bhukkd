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


class TrendingPage extends StatefulWidget {
  _TrendingPageState createState() => new _TrendingPageState();
}
// temp variable
String latitude;
String longitude;
void _fetchRestByGeoCode(){
  StoreUserLocation.getLocation().then((loc){
    latitude = loc[0].toString();
    longitude = loc[1].toString();
  });
  requestGeoCode("https://developers.zomato.com/api/v2.1/geocode?lat=$latitude&lon=$longitude", latitude, longitude); 
}

//Restaurant restaurant; 
void _fetchRestaurant(){
  requestRestaurant("https://developers.zomato.com/api/v2.1/restaurant?res_id=1806", "1806").then((rest){
    print(rest.restruant_Name);
    //print(rest.restruant_Menu);
    fetchPhotos(rest.restruant_Photo_url);
    fetchMenu(rest.restruant_Menu);
    //rest=restaurant;
  });
}

Future fetchPhotos(String url) async{
  var client = new Client();
  Response response = await client.get(url);
  var photos = parse(response.body);
  //thumbnails
  List<dynamic> thumbLinks = photos.querySelectorAll('div.photos_container_load_more>div>a.res-info-thumbs');
  //photos
  List<dynamic> photoLinks = photos.querySelectorAll('div.photos_container_load_more>div.photobox>a.res-info-thumbs>img');
  print("-----------extra photo info links-----------");
  for(var link in thumbLinks){
    print(link.attributes['href']);
  }
  print("----------Photo links------------");
  for(var photoLink in photoLinks){
    print(photoLink.attributes['data-original'].replaceAll("?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A", ""));
  }
}

Future fetchMenu(String url) async{
  var client = new Client();
  Response response = await client.get(url);
  var menu = parse(response.body);
  List<dynamic> menuLink = menu.querySelectorAll('div#menu-image>img');
  print("----------Menu Image-------------");
  for(var link in menuLink){
    print(link.attributes['src']);
  }
}

class _TrendingPageState extends State<TrendingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          HorizontalScroll(),
          HorizontalScroll(),
          // never call the the fuction in onPressed method only pass the reference
          // bug solved(first time this function is giving a null error, second time it is executing fine)
          new FlatButton(
            onPressed:
              _fetchRestaurant,
              //_fetchRestByGeoCode,
              //getCurrentPosition();
               //requestCategories("https://developers.zomato.com/api/v2.1/categories");
               // requestGeoCode("https://developers.zomato.com/api/v2.1/geocode?lat=28.7041&lon=77.1025", "28.7041", "77.1025");
            child: new Text("Click"),
          )
        ],
      ),
    );
  }
}
