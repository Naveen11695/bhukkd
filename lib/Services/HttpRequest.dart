import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/Restruant/Restruant.dart';

String api_key = "";

void getKey() async {
  Iterable<dynamic> key =
      (await parseJsonFromAssets('assets/api/config.json')).values;
  api_key = key.elementAt(0);
}

String map_api_key;

void getMapKey() async {
  Iterable<dynamic> key =
      (await parseJsonFromAssets('assets/api/config.json')).values;
  map_api_key = key.elementAt(1);
}

Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  return rootBundle
      .loadString(assetsPath)
      .then((jsonStr) => jsonDecode(jsonStr));
}


Future requestZomatoApiRestaurant(requestUrl, res_id) async {
  try {
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
      return "error";
    }
  } catch (e) {
    print("<Restaurant exception>" + e.toString());
    return "error";
  }
}

Restaurant parseRestaurant(String responseBody) {
  final parsed = json.decode(responseBody);
  Restaurant r = Restaurant.fromJson(parsed);
  return r;
}

Future fetchRestaurant(String res_id) async {
  getMapKey();
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
  Restaurant rest = await parseRestaurant(data);
  return rest;
}

void StoreRestaurantInFireStore(var res_id, var data) async {
  Firestore.instance
      .collection("Restaurant")
      .document(res_id)
      .setData({res_id: data});
}
