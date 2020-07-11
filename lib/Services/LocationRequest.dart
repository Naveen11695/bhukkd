import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

Position position;

Future getCurrentPosition() async {
  var status = await Permission.location.status;
  if (status.isDenied) {
    return null;
  }
  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setStringList("Current_location", [
    position.latitude.toString(),
    position.longitude.toString(),
    position.timestamp.toString(),
  ]);
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
