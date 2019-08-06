import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreUserLocation{
  static Position location;
  static String avataaar;
  static setLocation() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList("Current_location", [location.latitude.toString(),
                                           location.longitude.toString(),
                                           location.timestamp.toString()]
                             );
  }

  static get_CurrentLocation() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList("Current_location");
  }

  static setAvataaar() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList("Avataaar", [avataaar.toString()]
    );
  }
  static getAvataaar() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList("Avataaar");
  }
}