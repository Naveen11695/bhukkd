import 'dart:async';
import 'dart:convert' show json, utf8;

import 'package:bhukkd/Pages/Search/SearchRestaurant.dart';
import 'package:bhukkd/Services/HttpRequest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;


//  static Future<List<NearByRestaurants>> getRepositoriesWithSearchQuery(String query) async {
//
//    String _url = "https://developers.zomato.com/api/v2.1/search?q=$query";
//    Iterable<dynamic> key =
//        (await parseJsonFromAssets('assets/api/config.json')).values;
//    final jsonResponse = await http
//        .get(Uri.encodeFull(_url), headers: {"user-key": key.elementAt(0)});
//
//    if (jsonResponse.statusCode == 200) {
//      parseSearchRestraunts(jsonResponse.body).then((searchResult){
//        searchRestraunts = searchResult;
//      });
//      return searchRestraunts.restaurants;
//    }
//   else{
//     return null;
//    }
//  }

getRepositoriesWithSearchQuery(String query) async {
  try {
    SearchRestraunts searchRestraunts;
    var fireStore = Firestore.instance;
    DocumentReference snapshot =
    fireStore.collection('SearchRestaurants').document(
        query);
    await snapshot.get().then((dataSnapshot) async {
      if (dataSnapshot.exists && DateTime
          .now()
          .day != 1) {
        final response = dataSnapshot.data["source"];
        await parseSearchRestraunts(response).then((searchResult) async {
          searchRestraunts = searchResult;
        });
      }
      else {
        searchRestraunts = await requestApi(query, searchRestraunts);
      }
      });
      return searchRestraunts.restaurants;
  } catch (e) {
    print("<SearchRestaurants> Problem " + e.toString());
  }
}

requestApi(String query, var searchRestraunts) async {
  print("<SearchRestaurants>");
  String url =
      "https://developers.zomato.com/api/v2.1/search?q=$query";
  final response = await http.get(Uri.encodeFull(url),
      headers: {"Accept": "application/json", "user-key": api_key});

  if (response.statusCode == 200) {
    saveSearchRestaurants(query, response.body);
    await parseSearchRestraunts(response.body).then((searchResult) {
      searchRestraunts = searchResult;
    });
    return searchRestraunts;
  }
  else {
    return "error";
  }
}


saveSearchRestaurants(String query, String data) {
  Firestore.instance
      .collection("SearchRestaurants")
      .document(query)
      .setData({
    "key": query,
    "source": data
  });
}

Future<SearchRestraunts> parseSearchRestraunts(String responseBody) async {
    final parsed = json.decode(responseBody);
    SearchRestraunts Result = SearchRestraunts.fromJson(parsed);
    return Result;
  }



