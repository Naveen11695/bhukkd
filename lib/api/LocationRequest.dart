import 'package:geolocator/geolocator.dart';

Position position;

Future getCurrentPosition() async {
  position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  return position;
}

Future getLastKnownPosition() async {
  position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
  return position;
}

Future onPositionChanged() async {
  var geolocator = Geolocator();
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  geolocator.getPositionStream(locationOptions).listen(
          (Position position) {
        if(position == null){
          return "Unknown";
        }
        else{
          return position.latitude + position.longitude;
        }
      });
}

//void printPostion() {
//  print("Postion:$position");
//}