import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
 import 'dart:convert';
 import 'dart:async';
 import '../models/Restruant/Restruant.dart';

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

  void requestGeoCode(requestUrl, latitude, longitude) async {
    getKey();
    final response = await http.get(Uri.encodeFull(requestUrl),
        headers: {
          "user-key": api_key,
          "lat": latitude,
          "lon": longitude,
        });
    if (response.statusCode == 200) {
      print(response.body);
    }
    else {
      print(response.statusCode);
    }
  }


void requestRestaurant(requestUrl, res_id) async {
    getKey();
    final response = await http.get(Uri.encodeFull(
        requestUrl),
        headers: {
          "user-key": api_key,
          "res_id": res_id,
        });
    if (response.statusCode == 200) {
      parseRestaurant(response.body);
    }
    else {
      print(response.statusCode);
      print(response.body);
    }
  }

// A function that will convert a response body into a List<Restaurant>
void parseRestaurant(String responseBody) {
  final parsed = json.decode(responseBody);
  Restaurant r = Restaurant.fromJson(parsed);
  r.print_res();
}





