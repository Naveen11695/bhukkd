import 'package:bhukkd/Pages/ExplorePage.dart';
import 'package:flutter/material.dart';
import './TrendingPage.dart';
import './LoginPage.dart';
import './WagonPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => new _HomePage();
}

class _HomePage extends State<HomePage> {
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
      body: bottomNavigation[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            this.selectedIndex = index;
          });
        },
        fixedColor: Colors.deepOrange,
        currentIndex: selectedIndex,
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
            icon: Icon(Icons.person, color: Color(0xFFD35400)),
            title: new Text("Account"),
          ),
        ],
      ),
    );
  }
}
