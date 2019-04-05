import 'package:bhukkd/Pages/ExplorePage.dart';
import 'package:bhukkd/models/Search/SearchRestaurant.dart';
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
  Iterable<dynamic> key =
      (await parseJsonFromAssets('assets/api/config.json')).values;
  api_key = key.elementAt(0);
  print('api-key : $api_key');
}

Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  return rootBundle
      .loadString(assetsPath)
      .then((jsonStr) => jsonDecode(jsonStr));
}

//.........................................<End>.....getting Api-key from assets.........................................

String query;

void fetchSearchRestraunts(String _query) {

  query = _query;
  StoreUserLocation.get_CurrentLocation().then((loc) {
    latitude = loc[0].toString();
    longitude = loc[1].toString();
    print("$longitude, $latitude");
  });
  RequestSearchRestraunts(
          "https://developers.zomato.com/api/v2.1/search?q=$query&lat=$latitude&lon=$longitude&radius=100000&order=asc")
      .then((SearchRestraunts searchRestraunts) {
    if (searchRestraunts != null) {
      clear();
      print(
          "----List of nearby restaurants according to the location---------");
      for (int i = 0; i < searchRestraunts.restaurants.length; i++) {
        //print(searchRestraunts.restaurants[i].id);
        // print(searchRestraunts.restaurants[i].thumb);
        print(searchRestraunts.restaurants[i].name);
        print(searchRestraunts.restaurants[i].near_by_restaurants_location["address"]);

        add_search_content(i,
            searchRestraunts.restaurants[i].id,
            searchRestraunts.restaurants[i].thumb,
            searchRestraunts.restaurants[i].name,
            searchRestraunts.restaurants[i]
                .near_by_restaurants_location["address"]);
      }
    }
  });
}

void clear() {
 // Search_id.clear();
 // Search_resturaunt_thumb.clear();
  Search_resturaunt_name.clear();
  Search_resturant_location.clear();
}

void add_search_content(int index, String id, String thumb, String name, near_by_restaurants_location) {
  //  Search_id.add(id);
  //  Search_resturaunt_thumb.add(thumb);
    Search_resturaunt_name.add(name);
    Search_resturant_location.add(near_by_restaurants_location);
}

Future<SearchRestraunts> RequestSearchRestraunts(requestUrl) async {
  getKey();
  final response = await http
      .get(Uri.encodeFull(requestUrl), headers: {"user-key": api_key});
  if (response.statusCode == 200) {
    print(response.body);
    SearchRestraunts searchRestraunts = parseSearchRestraunts(response.body);
    return searchRestraunts;
  } else if (response.statusCode == 403) {
    fetchSearchRestraunts(requestUrl);
  } else {
    print(response.statusCode);
  }
}

SearchRestraunts parseSearchRestraunts(String responseBody) {
  final parsed = json.decode(responseBody);
  SearchRestraunts Result = SearchRestraunts.fromJson(parsed);
  return Result;
}

void requestCategories(requestUrl) async {
  getKey();
  final response = await http
      .get(Uri.encodeFull(requestUrl), headers: {"user-key": api_key});
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print(response.statusCode);
  }
}

Future<GeoCode> requestGeoCode(requestUrl, latitude, longitude) async {
  getKey();
  final response = await http.get(Uri.encodeFull(requestUrl), headers: {
    "user-key": api_key,
    "lat": latitude,
    "lon": longitude,
  });
  if (response.statusCode == 200) {
    //  print(response.body);
    GeoCode geo = parseGeoCode(response.body);
    return geo;
  } else if (response.statusCode == 403) {
    fetchRestByGeoCode();
  } else {
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

var nearByrestaurants = [];
var cuisines = [];
var thumb = [];

GeoCode fetchRestByGeoCode() {
  StoreUserLocation.get_CurrentLocation().then((loc) {
    latitude = loc[0].toString();
    longitude = loc[1].toString();
    print("$longitude, $latitude");
  });
  requestGeoCode(
          "https://developers.zomato.com/api/v2.1/geocode?lat=$latitude&lon=$longitude",
          latitude,
          longitude)
      .then((GeoCode geoCode) {
    if (geoCode != null) {
      print(
          "----List of nearby restaurants according to the location---------");
      nearByrestaurants.clear();
      cuisines.clear();
      thumb.clear();
      for (int i = 0; i < geoCode.nearby_restaurants.length; i++) {
        print(geoCode.nearby_restaurants[i].name);
        nearByrestaurants.add(geoCode.nearby_restaurants[i].name);
        cuisines.add(geoCode.nearby_restaurants[i].cuisines);
        if (geoCode.nearby_restaurants[i].thumb != "") {
          thumb.add(geoCode.nearby_restaurants[i].thumb);
        } else {
          thumb.add(geoCode.nearby_restaurants[i % 2].thumb);
        }
      }
      return geoCode;
    }
  });
  return null;
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
void _fetchRestaurant(String res_id) {
  requestRestaurant(
          "https://developers.zomato.com/api/v2.1/restaurant?res_id=$res_id",
          res_id)
      .then((rest) {
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
