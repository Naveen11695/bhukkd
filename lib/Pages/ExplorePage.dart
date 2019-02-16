import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExplorePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.deepOrange),
    textTheme: TextTheme(
    title: TextStyle(
    color: Colors.black,
    wordSpacing: 1.0,
    fontWeight: FontWeight.bold,
    fontFamily: "roboto",
    ),
    ),
    ),
    );
  }

}