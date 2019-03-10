import 'package:bhukkd/Pages/ExplorePage.dart';
import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/NearByRestaurants.dart';
import 'package:bhukkd/models/Search/SearchRestaurant.dart';
import 'package:bhukkd/models/SharedPreferance/SharedPreference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  StoreUserLocation.getLocation().then((loc) {
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
  StoreUserLocation.getLocation().then((loc) {
    latitude = loc[0].toString();
    longitude = loc[1].toString();
    print("$longitude, $latitude");
  });
  requestGeoCode(
          "https://developers.zomato.com/api/v2.1/geocode?lat=28.6276&lon=77.2784",
          latitude,
          longitude)
      .then((GeoCode geoCode) {
    if (geoCode != null) {
      print(
          "----List of nearby restaurants according to the location---------");
      for (int i = 0; i < geoCode.nearby_restaurants.length; i++) {
        print(geoCode.nearby_restaurants[i].name);
        nearByrestaurants.add(geoCode.nearby_restaurants[i].name);
        cuisines.add(geoCode.nearby_restaurants[i].cuisines);
        if (geoCode.nearby_restaurants[i].thumb != "") {
          thumb.add(geoCode.nearby_restaurants[i].thumb);
        } else {
          thumb.add(geoCode.nearby_restaurants[i % 2].thumb);
        }
        //send_data_to_firestore(geoCode.nearby_restaurants[i]);
      }
      return geoCode;
    }
  });
}

Future<void> send_data_to_firestore(NearByRestaurants nearby_restaurants) async {
  DocumentReference documentReference = Firestore.instance.collection('NearByRestaurants').document(nearby_restaurants.id);
  _fetchRestaurant(nearby_restaurants.id);
  await Firestore.instance.runTransaction((Transaction tx) async{
    DocumentSnapshot snapshot  = await tx.get(documentReference);
    if(!snapshot.exists) {
      await tx.set(documentReference, {
        "id": [nearby_restaurants.id],
        "restaurant_name": [nearby_restaurants.name],
        "cuisines": [nearby_restaurants.cuisines],
//        "near_by_restaurants_location":[nearby_restaurants.near_by_restaurants_location],
        "average_cost_for_two": [nearby_restaurants.average_cost_for_two],
        "price_range": [nearby_restaurants.price_range],
        "currency": [nearby_restaurants.currency],
//        "offers":[nearby_restaurants.offers],
//        "zomato_events":[nearby_restaurants.zomato_events],
        "opentable_support": [nearby_restaurants.opentable_support],
        "is_zomato_book_res": [nearby_restaurants.is_zomato_book_res],
        "mezzo_provider": [nearby_restaurants.medio_provider],
        "book_form_web_view_url": [nearby_restaurants.book_form_web_view_url],
        "book_again_url": [nearby_restaurants.book_again_url],
        "thumb": [nearby_restaurants.thumb],
//        "user_rating":[nearby_restaurants.user_rating],
        "menu_url": [nearby_restaurants.menu_url],
//        "photo_url":[nearby_restaurants.photo_url],
        "featured_image": [nearby_restaurants.featured_image],
        "medio_provider": [nearby_restaurants.medio_provider],
        "has_online_delivery": [nearby_restaurants.has_online_delivery],
        "is_delivery_now": [nearby_restaurants.is_delivery_now],
        "include_bogo_offers": [nearby_restaurants.include_bogo_offers],
        "deeplink": [nearby_restaurants.deeplink],
        "is_table_reservation_supported": [
          nearby_restaurants.is_table_reservation_supported],
        "has_table_booking": [nearby_restaurants.has_table_booking],
        "book_url": [nearby_restaurants.book_url],
        "events_url": [nearby_restaurants.events_url],
//        "all_reviews":[nearby_restaurants.all_reviews],
      });
//    Future f =fetchPhotos(nearby_restaurants);
    }

  });
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
