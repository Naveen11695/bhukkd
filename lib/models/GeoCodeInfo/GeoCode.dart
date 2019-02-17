import 'package:scoped_model/scoped_model.dart';

class GeoCode extends Model{
  List<dynamic> locality;
  List<dynamic> popularity;
  List<Map<String,dynamic>> nearby_restaurants;

}