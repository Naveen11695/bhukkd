import 'package:bhukkd/models/SharedPreferance/SharedPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import '../models/Restruant/Restruant.dart';
import '../models/GeoCodeInfo/GeoCode.dart';
import '../models/Catagories/Catagories.dart';

String api_key = "";
Restaurant restruant;

//.........................................<Start>.....getting Api-key from assets.........................................
void getKey() async {
  Iterable<dynamic> key =
      (await parseJsonFromAssets('assets/api/config.json')).values;
  api_key = key.elementAt(0);
  /*print('api-key : $api_key');*/
}

Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  return rootBundle
      .loadString(assetsPath)
      .then((jsonStr) => jsonDecode(jsonStr));
}


// This function will convert a respose body into a List<GeoCode>
GeoCode parseGeoCode(String responseBody) {
  final parsed = json.decode(responseBody);
  GeoCode geo = GeoCode.fromJson(parsed);
  //print(geo);
  return geo;
}

String latitude;
String longitude;

var nearByrestaurants = [];
var cuisines = [];
var thumb = [];
var costForTwo=[];
var reviews=[];
var hasOnlineDelivery=[];
var popularity=[];
var url=[];

Future fetchRestByGeoCode() async{
  try{
    final result = await InternetAddress.lookup('google.com');
    await StoreUserLocation.get_CurrentLocation().then((loc) {
      latitude = loc[0].toString();
      longitude = loc[1].toString();
//      print("$longitude, $latitude");
    });
    GeoCode geocode;

    getKey();
    final response = await http.get(Uri.encodeFull("https://developers.zomato.com/api/v2.1/geocode?lat=$latitude&lon=$longitude"), headers: {
      "user-key": api_key,
      "lat": latitude,
      "lon": longitude,
    });
    if (response.statusCode == 200) {
      geocode = parseGeoCode(response.body);

    } else if (response.statusCode == 403) {
      fetchRestByGeoCode();
    } else {
      print("Error: ${response.statusCode}");
      print("Error: ${response.body}");
      return "error";
    }

    if(geocode !=null){
      return geocode;
    }
    else{
      print("error in fetchRestByGeoCode");
    }
  }on SocketException catch (e) {
    print('not connected');
    return "error";
  }

}

Future requestRestaurant(requestUrl, res_id) async {
  getKey();
  final response = await http.get(Uri.encodeFull(requestUrl), headers: {
    "user-key": api_key,
    "res_id": res_id,
  });
  if (response.statusCode == 200) {
    Restaurant r = parseRestaurant(response.body);
    return r;
  } else {
    print(response.statusCode);
    print(response.body);
  }
}

// A function that will convert a response body into a List<Restaurant>
Restaurant parseRestaurant(String responseBody) {
  final parsed = json.decode(responseBody);
  Restaurant r = Restaurant.fromJson(parsed);
  return r;

  //r.print_res();
}

//Restaurant restaurant;
Future fetchRestaurant(String res_id) {
  Future<dynamic> rest = requestRestaurant("https://developers.zomato.com/api/v2.1/restaurant?res_id=$res_id",res_id);

  return rest;
}

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
/*  print("-----------extra photo info links-----------");
  for (var link in thumbLinks) {
    print(link.attributes['href']);
  }
  print("----------Photo links------------");*/
  List<String> restarauntPhotos = new List<String>();
  for (var photoLink in photoLinks) {
    restarauntPhotos.add(photoLink.attributes['data-original']
        /*.replaceAll("?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A", "")*/);
  }

  return restarauntPhotos;
}

Future fetchMenu(String url) async {
  var client = new Client();
  Response response = await client.get(url);
  var menu = parse(response.body);
  List<dynamic> menuLink = menu.querySelectorAll('div#menu-image>img');
 /* print("----------Menu Image-------------");*/
  var restaurant_menu=[];
  for (var link in menuLink) {
    restaurant_menu.add(link.attributes['src']);
  }

  return restaurant_menu;
}
