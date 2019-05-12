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
import 'package:cloud_firestore/cloud_firestore.dart';

String api_key = "";

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

String latitude;
String longitude;

Future requestZomatoApiRestaurant(requestUrl, res_id) async {
  getKey();
  final response = await http.get(Uri.encodeFull(requestUrl), headers: {
    "user-key": api_key,
    "res_id": res_id,
  });
  if (response.statusCode == 200) {

    StoreRestaurantInFireStore(res_id, response.body);
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
}

//Restaurant restaurant;
Future fetchRestaurant(String res_id) async {
  Future<dynamic> rest;
  var fireStore = Firestore.instance;
  DocumentReference snapshot =
      fireStore.collection('Restaurant').document(res_id);
  await snapshot.get().then((dataSnapshot) {
    if (dataSnapshot.exists) {
      rest = requestRestaurant(dataSnapshot.data[res_id]);
    } else {
      rest = requestZomatoApiRestaurant(
          "https://developers.zomato.com/api/v2.1/restaurant?res_id=$res_id",
          res_id);
    }
  });

  return rest;
}

Future requestRestaurant(var data) async {
  Restaurant rest =  await parseRestaurant(data);
  return rest;
}


void StoreRestaurantInFireStore(var res_id, var data) async {
    Firestore.instance
        .collection("Restaurant")
        .document(res_id)
        .setData({
      res_id: data
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
/*  print("-----------extra photo info links-----------");
  for (var link in thumbLinks) {
    print(link.attributes['href']);
  }
  print("----------Photo links------------");*/
  List<String> restarauntPhotos = new List<String>();
  List<String> splittedUrl;
  for (var photoLink in photoLinks) {
    splittedUrl=photoLink.attributes['data-original'].split("?");
    /*print(splittedUrl[0]);*/
    restarauntPhotos.add(splittedUrl[0]);

  }

  return restarauntPhotos;
}

Future fetchMenu(String url) async {
  var client = new Client();
  Response response = await client.get(url);
  var menu = parse(response.body);

  List<dynamic> urls = menu.querySelectorAll("div.item a.paginator_item");
  var urlsToBeFetchedForMenu = [];
  for(var url in urls){
    // print("https://www.zomato.com"+url.attributes['href']);
    urlsToBeFetchedForMenu.add("https://www.zomato.com"+url.attributes['href']);
  }

  var menuLinks=[];
  for(var url in urlsToBeFetchedForMenu){
    Response response = await client.get(url);
    var menuPhotos=parse(response.body);
    if(menuLinks.contains(url)){
      continue;
    }
    else{
      menuLinks.addAll(menuPhotos.querySelectorAll('div#menu-image>img'));
    }
  }

  // for(var link in menuLinks){
  //   print(link.attributes['src']);
  // }
  
  var restaurant_menu = [];
  for (var link in menuLinks) {
    restaurant_menu.add(link.attributes['src']);

  }

  return restaurant_menu;
}
