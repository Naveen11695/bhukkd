import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

Position position;

Future<Position> getCurrentPosition() async {

  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setStringList("Current_location", [
    position.latitude.toString(),
    position.longitude.toString(),
    position.timestamp.toString(),
  ]);
  print("pos"+position.toString());
  return position;
}

Future getLastKnownPosition() async {
  position = await Geolocator()
      .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
  return position;
}

Future onPositionChanged() async {
  var geolocator = Geolocator();
  var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  geolocator.getPositionStream(locationOptions).listen((Position position) {
    if (position == null) {
      return "Unknown";
    } else {
      return position.latitude + position.longitude;
    }
  });
}