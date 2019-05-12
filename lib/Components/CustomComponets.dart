import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final opacity = Container(
  color: Color.fromRGBO(249, 129, 42, 150),
);

final logo = Container(
  child: Image.asset(
    'assets/images/icon.png',
    width: 120.0,
    height: 120.0,
  ),
);

const TextStyle textStyle = TextStyle(
  color: Color(0xFFFFFFFF),
  fontFamily: 'Raleway',
);

final login_description = Container(
  child: new Text(
    "Spot the right place to find your favorite food.",
    textAlign: TextAlign.center,
    style: new TextStyle(
        shadows: [
          Shadow(
              // bottomLeft
              offset: Offset(-1.5, -1.5),
              color: Colors.black54),
          Shadow(
              // bottomRight
              offset: Offset(1.5, -1.5),
              color: Colors.black54),
          Shadow(
              // topRight
              offset: Offset(1.5, 1.5),
              color: Colors.black54),
          Shadow(
              // topLeft
              offset: Offset(-1.5, 1.5),
              color: Colors.black54),
        ],
        fontSize: 35.0,
        fontFamily: "Pacifico",
        letterSpacing: 2.5,
        wordSpacing: 2.0,
        fontWeight: FontWeight.bold,
        textBaseline: TextBaseline.ideographic,
        color: Colors.white),
  ),
  margin: const EdgeInsets.all(15.0),
  padding: const EdgeInsets.all(3.0),
);

Widget semi_circlar_button(String label, Function onTap) {
  return Material(
    color: Color.fromRGBO(0, 0, 0, 50),
    child: InkWell(
      onTap: onTap,
      splashColor: Colors.white24,
      highlightColor: Colors.white10,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Center(
          child: Text(
            label,
            style: new TextStyle(
                fontSize: 20.0,
                fontFamily: "Montserrat",
                // fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                wordSpacing: 0.0,
                textBaseline: TextBaseline.ideographic,
                color: Colors.white),
          ),
        ),
        decoration: BoxDecoration(boxShadow: [
          new BoxShadow(
            color: Colors.black,
            blurRadius: 5.0,
          ),
        ]),
      ),
    ),
  );
}

final splash_description = new RichText(
  text: TextSpan(
    text: 'Loading Assets',
    style: TextStyle(
      color: Colors.white,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
  ),
);

TextStyle Raleway = TextStyle(
  color: Color(0xAAAF2222),
  fontFamily: 'Raleway',
);

final login_background = Image.asset(
  'assets/images/2.png',
  fit: BoxFit.fill,
);

final otp_background = Positioned(
  child: Image.asset('assets/images/food1.png', fit: BoxFit.fill),
  left: 80,
  top: 470,
);
final explore_background = Container(
  decoration: BoxDecoration(color: Colors.black),
);

final splash_background = Container(
    decoration: BoxDecoration(
        image: DecorationImage(
  image: AssetImage('assets/images/2.png'),
  fit: BoxFit.fill,
)));

final separator = Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Container(
      width: 20.0,
      height: 2.0,
      color: Colors.white,
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        'OR',
        style: textStyle,
      ),
    ),
    Container(
      width: 20.0,
      height: 2.0,
      color: Colors.white,
    ),
  ],
);

final formatter = new NumberFormat("#,###");
var randomPhotoList = [
  '2.png',
  '3.jpeg',
  '4.jpeg',
  '5.jpg',
  '6.jpg',
  '7.jpeg',
  '8.jpeg',
  '9.jpeg',
  '10.jpeg',
  'food.png'
];

var catagoriesPhotoList = [
  'delivery.png',
  'dine_out.png',
  'night_life.png',
  'catching_up.png',
  'takeaway.png',
  'cafe.png',
  'daily_menu.png',
  'breakfast.png',
  'lunch.png',
  'dinner.png',
  'pubs_bars.png',
  'friendly_delivery.png',
  'club_lounges.png',
];
final random = new Random();

Widget buttonLoading2 = Container(
  child: Center(
      child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrange))),
);

Widget buttonSignin = Container(
  child: Text(
    "Sign In",
    style: new TextStyle(
        fontSize: 20.0,
        fontFamily: "Montserrat",
// fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
        wordSpacing: 0.0,
        textBaseline: TextBaseline.ideographic,
        color: Colors.white),
  ),
);

Widget titleBar(String text, double sizeWidth) {
  return Row(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top:5.0, bottom: 5.0, left: 10.0, right: 10.0),
        child: Container(
          color: Colors.deepOrange,
          height: 25,
          width: 100,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                letterSpacing: 1,
                shadows: [
                  Shadow(
                      // bottomLeft
                      offset: Offset(1.5, 1.5),
                      color: Colors.black54),
                  Shadow(
                      // bottomRight
                      offset: Offset(1.5, 1.5),
                      color: Colors.black54),
                  Shadow(
                      // topRight
                      offset: Offset(1.5, 1.5),
                      color: Colors.black54),
                  Shadow(
                      // topLeft
                      offset: Offset(1.5, 1.5),
                      color: Colors.black54),
                ],
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top:10.0, bottom: 5.0, right: 10.0),
        child: Container(
          height: 2,
          width: sizeWidth*1.2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                // Colors are easy thanks to Flutter's Colors class.
                Colors.deepOrange[600],
                Colors.deepOrange[400],
                Colors.deepOrange[200],
                Colors.deepOrange[100],
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      )
    ],
  );
}
