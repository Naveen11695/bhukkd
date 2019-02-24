import 'package:bhukkd/models/SharedPreferance/SharedPreference.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import '../models/Restruant/Restruant.dart';
import '../models/GeoCodeInfo/GeoCode.dart';

//String url = "https://developers.zomato.com/api/v2.1/categories";



  String api_key = "";
  Restaurant restruant;

//.........................................<Start>.....getting Api-key from assets.........................................
  void getKey() async {
    Iterable<dynamic> key = (await parseJsonFromAssets(
        'assets/api/config.json')).values;
    api_key = key.elementAt(0);
    print('api-key : $api_key');
  }

  Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    return rootBundle.loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

//.........................................<End>.....getting Api-key from assets.........................................

  void requestCategories(requestUrl) async {
    getKey();
    final response = await http.get(Uri.encodeFull(requestUrl),
        headers: {
          "user-key": api_key
        });
    if (response.statusCode == 200) {
      print(response.body);
    }
    else {
      print(response.statusCode);
    }
  }

  Future<GeoCode> requestGeoCode(requestUrl, latitude, longitude) async {
    getKey();
    final response = await http.get(Uri.encodeFull(requestUrl),
        headers: {
          "user-key": api_key,
          "lat": latitude,
          "lon": longitude,
        });
    if (response.statusCode == 200) {
      //  print(response.body);
      GeoCode geo = parseGeoCode(response.body);
      return geo;
    }
    else if (response.statusCode == 403){
    requestGeoCode(
    "https://developers.zomato.com/api/v2.1/geocode?lat=28.7367039&lon=77.1346744",
    latitude, longitude);
    }
    else {
      print("Error: ${response.statusCode}");
      print("Error: ${response.body}");
    }
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


  GeoCode fetchRestByGeoCode() {
    StoreUserLocation.getLocation().then((loc) {
      latitude = loc[0].toString();
      longitude = loc[1].toString();
      print("$longitude, $latitude");
    });
    requestGeoCode(
        "https://developers.zomato.com/api/v2.1/geocode?lat=28.7367039&lon=77.1346744",
        latitude, longitude).then((GeoCode geoCode) {
          if(geoCode != null) {
            print(
                "----List of nearby restaurants according to the location---------");
            for (int i = 0; i < geoCode.nearby_restaurants.length; i++) {
              print(geoCode.nearby_restaurants[i].name);
            }
            return geoCode;
          }
          else {
            return null;
          }
    });
  }


  Future requestRestaurant(requestUrl, res_id) async {
    getKey();
    final response = await http.get(Uri.encodeFull(
        requestUrl),
        headers: {
          "user-key": api_key,
          "res_id": res_id,
        });
    if (response.statusCode == 200) {
      Restaurant r = parseRestaurant(response.body);
      return r;
    }
    else {
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
  void _fetchRestaurant() {
    requestRestaurant("https://developers.zomato.com/api/v2.1/restaurant?res_id=1806", "1806").then((rest){
      print(rest.restruant_Name);
      print(rest.restruant_Menu);
      fetchPhotos(rest.restruant_Photo_url);
      fetchMenu(rest.restruant_Menu);
      //rest=restaurant;
    });
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

