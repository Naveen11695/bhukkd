import 'package:geolocator/geolocator.dart';

Position position;

void getCurrentPosition() async {
  position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  printPostion();
}

void getLastKnownPosition() async {
  position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
}

void onPositionChanged() async {
  var geolocator = Geolocator();
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  geolocator.getPositionStream(locationOptions).listen(
          (Position position) {
        print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
      });
}

void printPostion() {
  print("Postion:$position");
}