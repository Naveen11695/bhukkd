import 'dart:async';
import 'dart:convert' show json, utf8;

import 'package:bhukkd/Pages/Search/SearchRestaurant.dart';
import 'package:bhukkd/Services/HttpRequest.dart';
import 'package:bhukkd/Services/SharedPreference.dart';
import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/NearByRestaurants.dart';
import 'package:http/http.dart' as http;

class Api {

  static String latitude;
  static String longitude;
  static SearchRestraunts searchRestraunts;

  static Future<List<NearByRestaurants>> getRepositoriesWithSearchQuery(String query) async {
    StoreUserLocation.get_CurrentLocation().then((loc) {
      latitude = loc[0].toString();
      longitude = loc[1].toString();
    });

    String _url = "https://developers.zomato.com/api/v2.1/search?q=$query&lat=$latitude&lon=$longitude&radius=1000000";
    Iterable<dynamic> key =
        (await parseJsonFromAssets('assets/api/config.json')).values;
    final jsonResponse = await http
        .get(Uri.encodeFull(_url), headers: {"user-key": key.elementAt(0)});

    if (jsonResponse.statusCode == 200) {
      parseSearchRestraunts(jsonResponse.body).then((searchResult){
        searchRestraunts = searchResult;
      });
      return searchRestraunts.restaurants;
    }
   else{
     return null;
    }
  }

  static Future<SearchRestraunts> parseSearchRestraunts(String responseBody) async {
    final parsed = json.decode(responseBody);
    SearchRestraunts Result = SearchRestraunts.fromJson(parsed);
    return Result;
  }
}
