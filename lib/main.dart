import 'dart:async';

import 'package:bhukkd/Auth/Home/GetterSetter/GetterSetterUserDetails.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/HomePage.dart';
import 'package:bhukkd/Services/LocationRequest.dart';
import 'package:bhukkd/Services/SharedPreference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:scoped_model/scoped_model.dart';

import './models/GeoCodeInfo/GeoCode.dart';

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
          theme:
          new ThemeData(bottomAppBarColor: Color.fromRGBO(249, 129, 42, 1)),
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
    Duration duration = new Duration(seconds: 3);
    return new Timer(duration, navigateTo);
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

  final FirebaseAuth _auth = FirebaseAuth.instance;

  _getDataFromFireStore() async {
    try {
      if (_auth.currentUser() != null) {
        _auth.currentUser().then((val) {
          if (val != null) {
            var fireStore = Firestore.instance;
            DocumentReference snapshot =
            fireStore.collection('UsersData').document(val.email);
            snapshot.get().then((dataSnapshot) {
              if (dataSnapshot.exists) {
                _setData(dataSnapshot);
              }
            });
          }
        });
      }
    } catch (e) {
      print("Error <Main>: " + e.toString());
    }
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

  void _saveLocation() async {
    await getCurrentPosition().then((position) {
      StoreUserLocation.location = position;
      StoreUserLocation.setLocation();
    });
  }

  @override
  void initState() {
    super.initState();
    _getDataFromFireStore();
    _saveLocation();

    controller = AnimationController(
      duration: Duration(milliseconds: 20),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
    delayTimer();
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
}
