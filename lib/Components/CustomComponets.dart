import 'package:flutter/material.dart';

final opacity = Container(
  color: Color(0xAAAF2222),
);

final logo = Image.asset(
  'assets/images/icon.png',
  width: 120.0,
  height: 120.0,
);

const TextStyle textStyle = TextStyle(
  color: Color(0xFFFFFFFF),
  fontFamily: 'Raleway',
);

final login_description = Text(
  "Spot the right place to find your favorite food.",
  textAlign: TextAlign.center,
  style: textStyle.copyWith(
    fontSize: 20.0,
  ),
);

Widget semi_circlar_button(String label, Function onTap) {
  return Material(
    color: Color.fromARGB(200, 255, 138, 128),
    borderRadius: BorderRadius.circular(30.0),
    child: InkWell(
      onTap: onTap,
      splashColor: Colors.white24,
      highlightColor: Colors.white10,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Center(
          child: Text(
            label,
            style: textStyle.copyWith(fontSize: 20.0),
          ),
        ),
      ),
    ),
  );
}

final splash_description = new RichText(
  text: TextSpan(
    text: 'Loading Assests',
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

final login_background = Image.asset('assets/images/2.png', fit: BoxFit.fill);

final explore_background = Container(
  decoration: BoxDecoration(color: Colors.black),
);
final background = new Container(
  decoration: BoxDecoration(
      image: DecorationImage(
    image: AssetImage('assets/images/11.jpeg'),
    fit: BoxFit.fill,
  )),
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
