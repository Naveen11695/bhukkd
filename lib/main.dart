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
      seconds: 5,
      backgroundColor: Colors.indigo,
      image: Image.asset("assets/images/logo.png",),
      photoSize: 100,

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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
              constraints: BoxConstraints.expand(
                height: Theme.of(context).textTheme.display1.fontSize * 1.1 + 200.0,
              ),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child:new FlareActor("assets/animations/loading/sushi.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        animation: "Sushi Bounce"),
            ),
        ),
            backgroundColor: Colors.indigo,
            bottomNavigationBar: BottomAppBar(
            child: Container(child: Text("Loading"),
            ),

      )
    );
  }
}

