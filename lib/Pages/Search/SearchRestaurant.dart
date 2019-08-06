import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/NearByRestaurants.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchRestraunts extends Model {
  int results_found;
  int results_start;
  int results_shown;
  List<NearByRestaurants> restaurants;

  SearchRestraunts(
      {this.results_found,
      this.results_start,
      this.results_shown,
      this.restaurants});

  factory SearchRestraunts.fromJson(Map<String, dynamic> json) {
    var restraunt = json['restaurants'] as List;

    List<NearByRestaurants> restrauntList;

    if (restraunt != null) {
      restrauntList =
          restraunt.map((i) => NearByRestaurants.fromJson(i)).toList();
    } else {
      print("Error in Geocode in nearbyrestaurants");
    }

//    print("results_found:"+json['results_found'].toString());
//    print("results_start:"+json['results_start'].toString());
//    print("results_shown:"+json['results_shown'].toString());
    //print("restaurant:"+restrauntList[0].name);

    return SearchRestraunts(
      results_found: json['results_found'],
      results_start: json['results_start'],
      results_shown: json['results_shown'],
      restaurants: restrauntList,
    );
  }
}
