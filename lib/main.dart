import 'dart:async';

import 'package:bhukkd/Auth/Home/GetterSetter/GetterSetterAppConstant.dart';
import 'package:bhukkd/Auth/Home/GetterSetter/GetterSetterUserDetails.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/HomePage.dart';
import 'package:bhukkd/Pages/TrendingPage/TrendingPage.dart';
import 'package:bhukkd/Services/LocationRequest.dart';
import 'package:bhukkd/Services/SharedPreference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:scoped_model/scoped_model.dart';

import './models/GeoCodeInfo/GeoCode.dart';
import 'Constants/app_constant.dart';

void main() {
  runApp(new Bhukkd());
}

class Bhukkd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<GeoCode>(
        model: GeoCode(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SplashScreen',
          home: SplashScreen(),
          routes: <String, WidgetBuilder>{
            '/HomePage': (BuildContext context) => new HomePage(),
          },
          theme: new ThemeData(
            bottomAppBarColor: SECONDARY_COLOR_1,
            primaryColor: SECONDARY_COLOR_1,
            accentColor: Color.fromRGBO(249, 129, 42, 1),
          ),
        ));
  }
}

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  Future delayTimer() async {
    Duration duration = new Duration(seconds: 1);
    return new Timer(duration, navigateTo);
  }


  void navigateTo() async {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) {
              return new HomePage();
            },
            transitionDuration: const Duration(milliseconds: 1500),
            transitionsBuilder:
                (___, Animation<double> animation, ____, Widget child) {
              return SlideTransition(
                position: Tween<Offset>(
                    begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                    .animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Interval(
                      0.00,
                      1.00,
                      curve: Curves.ease,
                    ),
                  ),
                ),
                transformHitTests: false,
                child: child,
              );
            }));
  }



  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 20),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var c_height = MediaQuery.of(context).size.height * 0.5;
    Size size = MediaQuery
        .of(context)
        .size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      body: FutureBuilder(
          future: getLocationName(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == "<Error: Connection Not Found>") {
                return Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topCenter,
                          height: 400,
                          width: 400,
                          child: Center(
                            child: FlareActor(
                              "assets/animations/no_connection.flr",
                              animation: "init",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50.0),
                          child: Column(
                            children: <Widget>[
                              Text("Connection error!",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: FONT_TEXT_PRIMARY,
                                      letterSpacing: 2,
                                      wordSpacing: 2)),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                                child: Text(
                                    "Please check your internet connection.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black45,
                                        fontFamily: FONT_TEXT_SECONDARY,
                                        letterSpacing: 2,
                                        wordSpacing: 2)),
                              ),
                            ],
                          ),
                        ),

                        InkWell(
                            onTap: () {
                              setState(() {});
                            },
                            splashColor: Colors.white24,
                            highlightColor: Colors.white10,
                            child: Icon(
                              FontAwesomeIcons.redo, color: SECONDARY_COLOR_1,
                              size: 40,)
                        ),
                      ],
                    ),
                  ),
                );
              }
              else if (snapshot.data == "<Error: Location Not Found>") {
                return Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topCenter,
                          height: 300,
                          width: 300,
                          child: Center(
                            child: FlareActor(
                              "assets/animations/search_location.flr",
                              animation: "searching",
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50.0),
                          child: Column(
                            children: <Widget>[
                              Text("Location error!",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: FONT_TEXT_PRIMARY,
                                      letterSpacing: 2,
                                      wordSpacing: 2)),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                                child: Text(
                                    "Please make sure you enable your gps or check for the pemission.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black45,
                                        fontFamily: FONT_TEXT_SECONDARY,
                                        letterSpacing: 2,
                                        wordSpacing: 2)),
                              ),
                            ],
                          ),
                        ),

                        InkWell(
                            onTap: () {
                              setState(() {});
                            },
                            splashColor: Colors.white24,
                            highlightColor: Colors.white10,
                            child: Icon(
                              FontAwesomeIcons.redo, color: SECONDARY_COLOR_1,
                              size: 40,)
                        ),
                      ],
                    ),
                  ),
                );
              }
              else if (snapshot.data != null) {
                if (snapshot.data.locality != null ||
                    snapshot.data.subLocality != null ||
                    snapshot.data.subAdministrativeArea != null ||
                    snapshot.data.locality != null ||
                    snapshot.data.postalCode != null) {
                  GetterSetterAppConstant.locality = snapshot.data.locality;

                  GetterSetterAppConstant.address = snapshot.data.name +
                      " " +
                      snapshot.data.subLocality +
                      " " +
                      snapshot.data.subAdministrativeArea +
                      ", " +
                      snapshot.data.locality +
                      " " +
                      snapshot.data.postalCode;
                }
                delayTimer();
                return Scaffold(
                  body: Stack(
                    fit: StackFit.passthrough,
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        child: login_background(size),
                      ),
                      Container(
                        color: Colors.black45,
                      ),
                      new SafeArea(
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(100.0),
                              child: logo,
                            ),
                            SizedBox(
                              height: c_height * 0.5,
                            ),
                            Center(
                              child: splash_description,
                            ),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: CollectionScaleTransition(
                                  children: <Widget>[
                                    Icon(
                                      Icons.face,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                    Icon(
                                      Icons.fastfood,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                    Icon(
                                      Icons.favorite,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topCenter,
                          height: 600,
                          width: 400,
                          child: Center(
                            child: FlareActor(
                              "assets/animations/no_connection.flr",
                              animation: "Untitled",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text("No Connection",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: FONT_TEXT_EXTRA,
                                  letterSpacing: 2,
                                  wordSpacing: 2)),
                        ),
                        RaisedButton.icon(
                          onPressed: () {
                            setState(() {});
                          },
                          color: SECONDARY_COLOR_1,
                          label: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text('Retry',
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white)),
                          ),
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            } else {
              return Scaffold(
                body: Stack(
                  fit: StackFit.passthrough,
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      child: login_background(size),
                    ),
                    Container(
                      color: Colors.black45,
                    ),
                    new SafeArea(
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(100.0),
                            child: logo,
                          ),
                          SizedBox(
                            height: c_height * 0.5,
                          ),
                          Center(
                            child: splash_description,
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CollectionScaleTransition(
                                children: <Widget>[
                                  Icon(
                                    Icons.face,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                  Icon(
                                    Icons.fastfood,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                  Icon(
                                    Icons.favorite,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }


}


Future _saveLocation() async {
  var _position;
  await getCurrentPosition().then((position) {
    if (position != null) {
      StoreUserLocation.location = position;
      StoreUserLocation.setLocation();
      _position = position;
    }
    else {
      _position = "<Error: Location Not Found>";
    }
  });
  return _position;
}

final FirebaseAuth _auth = FirebaseAuth.instance;

_getDataFromFireStore() async {
  try {
    if (_auth.currentUser() != null) {
      _auth.currentUser().then((val) {
        if (val != null) {
          var fireStore = Firestore.instance;
          DocumentReference snapshot =
          fireStore.collection('UsersData').document(val.email);
          try {
            snapshot.get().then((dataSnapshot) {
              if (dataSnapshot.exists) {
                _setData(dataSnapshot);
              }
            });
          } catch (e) {
            print("Error <Main>: " + e.toString());
          }
        }
      });
    }
  } catch (e) {
    print("Error <Main>: " + e.toString());
  }
}

_setData(DocumentSnapshot snapshot) async {
  GetterSetterUserDetails.firstName = snapshot.data['FirstName'];
  GetterSetterUserDetails.middleName = snapshot.data['MiddleName'];
  GetterSetterUserDetails.lastName = snapshot.data['LastName'];
  GetterSetterUserDetails.dob = snapshot.data['Dob'];
  GetterSetterUserDetails.gender = snapshot.data['Gender'];
  GetterSetterUserDetails.phoneNumber = snapshot.data['PhoneNumber'];
  GetterSetterUserDetails.emailId = snapshot.data['EmailId'];
  GetterSetterUserDetails.address = snapshot.data['Address'];
  GetterSetterUserDetails.description = snapshot.data['Description'];
}


Future getLocationName() async {
  bool _flag = false;
  try {
    // ignore: missing_return
    await _saveLocation().then((pos) {
      if (pos == "<Error: Location Not Found>") {
        _flag = true;
      }
      else {
        _flag = false;
      }
    });

    if (_flag) {
      return "<Error: Location Not Found>";
    }

    await _getDataFromFireStore();
    await StoreUserLocation.get_CurrentLocation().then((loc) {
      latitude = double.parse(loc[0]);
      longitude = double.parse(loc[1]);
    });

    Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager = true;
    GeolocationStatus geolocationStatus =
    await geolocator.checkGeolocationPermissionStatus();
    if (geolocationStatus == GeolocationStatus.granted) {
      List<Placemark> placemark =
      await Geolocator().placemarkFromCoordinates(latitude, longitude);
      return placemark[0];
    } else {
      return "<Error: Location Not Found>";
    }
  } catch (e) {
    return "<Error: Connection Not Found>";
  }
}
