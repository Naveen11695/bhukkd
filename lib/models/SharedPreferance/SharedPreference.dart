import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

class StoreUserLocation{
  static Position location;
  static setLocation() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList("location", [location.latitude.toString(), 
                                           location.longitude.toString(),
                                           location.timestamp.toString()]
                             );
  }
  static getLocation() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getStringList("location");
  }
}