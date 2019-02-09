import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import './Pages/LocationServicePage.dart';

void main() {
  runApp(new Bhukkd());
}

class Bhukkd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bhukkd',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: new SlashPage(),
    );
  }
}

class SlashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      backgroundColor: Colors.indigo,
      image: Image.asset(
        "assets/images/logo.png",
      ),
      photoSize: 100,
      navigateAfterSeconds: new LocationServicePage(),
    );
  }
}

