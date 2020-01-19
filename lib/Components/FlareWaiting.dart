import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

Widget buildSplashScreenWaiting(Size size, double c_height) {
  return Scaffold(
    body: Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        login_background(size),

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

Widget buildSplashScreenNoConnection() {
  return Column(
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
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Text("Please check your internet connection.",
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
    ],
  );
}

Widget buildSplashScreenLocationError() {
  return Column(
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
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
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
    ],
  );
}
