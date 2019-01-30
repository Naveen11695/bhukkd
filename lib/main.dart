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
        primarySwatch: Colors.teal,
      ),
      home: new SlashPage(),
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

  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.deepOrange
        ),
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.black,
            wordSpacing: 1.0,
            fontWeight: FontWeight.bold,
            fontFamily: "roboto",
          ),
          subtitle: new TextStyle(
            color: Colors.grey,
            wordSpacing: 0.8,
            fontWeight: FontWeight.w300,
            fontFamily: "roboto",
          )
        ),
      ),
      drawer: Drawer(),
      body: new TrendingPage(),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.deepOrange,
        currentIndex: _selectedIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), title: new Text("Trending")),
          BottomNavigationBarItem(icon: Icon(Icons.search), title: new Text("Explore")),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), title: new Text("Wagon")),          
          BottomNavigationBarItem(icon: Icon(Icons.home), title: new Text("Account")),
        ],
      ),
    );
  }
}

