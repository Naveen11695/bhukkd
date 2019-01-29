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
      home: SlashPage(),
    );
  }
}


class SlashPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new SplashScreen(
      seconds: 5,
      backgroundColor: Colors.indigo,
      image: Image.asset("assets/images/logo.png",),
      photoSize: 100,
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
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.white24,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), title: new Text("Trending")),

        ],
      ),
    );
  }
}