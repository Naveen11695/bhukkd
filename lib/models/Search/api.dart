import 'package:bhukkd/api/HttpRequest.dart';
import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/NearByRestaurants.dart';
import 'package:bhukkd/models/Search/SearchRestaurant.dart';
import 'package:bhukkd/models/SharedPreferance/SharedPreference.dart';
import 'package:date_format/date_format.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' show json, utf8;
import 'dart:io';
import 'dart:async';

class Api {
  static final HttpClient _httpClient = HttpClient();

  static String latitude;
  static String longitude;
  static SearchRestraunts searchRestraunts;

  static Future<List<NearByRestaurants>> getRepositoriesWithSearchQuery(String query) async {
    StoreUserLocation.get_CurrentLocation().then((loc) {
      latitude = loc[0].toString();
      longitude = loc[1].toString();
    });

    String _url = "https://developers.zomato.com/api/v2.1/search?q=$query&lat=$latitude&lon=$longitude&radius=1000000&order=asc&sort=rating";
    Iterable<dynamic> key =
        (await parseJsonFromAssets('assets/api/config.json')).values;
    print("key: " + key.elementAt(0));
    final jsonResponse = await http
        .get(Uri.encodeFull(_url), headers: {"user-key": key.elementAt(0)});

    if (jsonResponse.statusCode == 200) {
      print("result :"+ jsonResponse.body);
      parseSearchRestraunts(jsonResponse.body).then((searchResult){
        searchRestraunts = searchResult;
      });
      print(".............................................................................................");
      print("Search Count: "+ searchRestraunts.results_shown.toString());
      print(".............................................................................................");
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
