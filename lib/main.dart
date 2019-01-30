import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import './Pages/TrendingPage.dart';

void main() {
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
      navigateAfterSeconds: new HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            subtitle: new TextStyle(
              color: Colors.grey,
              wordSpacing: 0.8,
              fontWeight: FontWeight.w300,
              fontFamily: "roboto",
            )),
      ),
      drawer: Drawer(),
      body: new TrendingPage(),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Color.fromRGBO(255, 111, 0, 0),
        // currentIndex: _selectedIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.trending_up,
                color: Color(0xFFD35400),
              ),
              title: new Text("Trending")),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Color(0xFFD35400)),
              title: new Text("Explore")),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, color: Color(0xFFD35400)),
              title: new Text("Wagon")),
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Color(0xFFD35400)),
              title: new Text(
                "Account",
                style: new TextStyle(color: Color(0xFFD35400)),
              ),
              ),
              BottomNavigationBarItem(
              icon: Icon(
                Icons.trending_up,
                color: Color(0xFFD35400),
              ),
              title: new Text("Hello"))
        ],
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }
// //this

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//       child: new FlareActor("assets/animations/sushi/Sushi.flr",
//         alignment: Alignment.center,
//         fit: BoxFit.contain,
//         animation: "Sushi Bounce"),
//     ),
//       //
//       backgroundColor: Colors.indigo,
//     );
//   }

// }
