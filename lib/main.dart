import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import './Pages/TrendingPage.dart';

void main(){
  runApp(new Bhukkd());
}

class Bhukkd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bhukkd',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}


class SlashPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new SplashScreen(
      seconds: 15,
      backgroundColor: Colors.indigo,
      image: Image.asset("assets/images/logo.png"),
      navigateAfterSeconds: new HomePage(),
    );
  }
}

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: Drawer(),
      body: new TrendingPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}
//this

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new FlareActor("assets/animations/sushi/Sushi.flr",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "rotate_scale_color");
  }
}