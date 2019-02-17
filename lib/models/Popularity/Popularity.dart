// format given by the api
// popularity": {
//     "popularity": "4.78",
//     "nightlife_index": "4.28",
//     "nearby_res": [
//       "312603",
//       "18246991",
//       "301605",
//       "18418277",
//       "312601",
//       "18423151",
//       "18729557",
//       "900",
//       "18337893"
//     ],
//     "top_cuisines": [
//       "North Indian",
//       "Chinese",
//       "Fast Food",
//       "Continental",
//       "Mughlai"
//     ],
//     "popularity_res": "100",
//     "nightlife_res": "10",
//     "subzone": "Paharganj",
//     "subzone_id": 119,
//     "city": "Delhi NCR"
//   },

//import 'package:scoped_model/scoped_model.dart';

class Popularity{
  String popularity;
  String nightlife_index;
  List<String> nearby_res;
  List<String> top_cuisines;
  String poplarity_res;
  String nightlife_res;
  String subzone;
  String subzone_id;
  String city;

  Popularity({this.popularity,
  this.nightlife_index,
  this.city,
  this.nightlife_res,
  this.poplarity_res,
  this.subzone,
  this.subzone_id,
  this.nearby_res,
  this.top_cuisines
  });

  factory Popularity.fromJson(Map<String,dynamic> jsonParsed){
    var json_nearby_rest =jsonParsed['nearby_res'];
    List<String> near_by_res = json_nearby_rest..cast<String>();

    var json_top_cuisines =jsonParsed['top_cuisines'];
    List<String> top_cuisines_info = json_top_cuisines.cast<String>();

    return Popularity(
      popularity: jsonParsed['popularity'],
      nightlife_index: jsonParsed['nightlife_index'],
      poplarity_res:jsonParsed['poplarity_res'],
      nightlife_res:jsonParsed['nightlife_res'],
      subzone:jsonParsed['subzone'],
      subzone_id:jsonParsed['subzone_id'],
      city:jsonParsed['city'],
      nearby_res: near_by_res,
      top_cuisines: top_cuisines_info
    );
  }
}