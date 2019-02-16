import 'package:bhukkd/Pages/ExplorePage.dart';
import 'package:flutter/material.dart';
import './TrendingPage.dart';
import './LoginPage.dart';
import './WagonPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => new _HomePage(); 
}

class _HomePage extends State<HomePage>{
  int selectedIndex = 0;

  List<Widget> bottomNavigation = [
    new TrendingPage(),
    new ExplorePage(),
    new WagonPage(),
    new LoginPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("${bottomNavigation[selectedIndex]}"),
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
      drawer: new Drawer(),
      body: bottomNavigation[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int index){
          setState((){this.selectedIndex = index;});
        },
        fixedColor: Colors.deepOrange,
        currentIndex: selectedIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.trending_up, color: Color(0xFFD35400),),
              title: new Text("Trending")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Color(0xFFD35400)),
              title: new Text("Explore")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, color: Color(0xFFD35400)),
              title: new Text("Wagon")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color(0xFFD35400)),
            title: new Text("Account"),
          ),
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
