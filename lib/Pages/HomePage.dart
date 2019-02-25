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
    final bottomNavColor = Theme.of(context).bottomAppBarColor;
    return new Scaffold(
      body: bottomNavigation[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            this.selectedIndex = index;
          });
        },
        fixedColor: Colors.grey,
        currentIndex: selectedIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.trending_up,
                color: bottomNavColor,
              ),
              title: new Text("Trending", textAlign: TextAlign.center,style: new TextStyle(
                color: bottomNavColor
              ),),),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color:bottomNavColor),
              title: new Text("Explore",textAlign: TextAlign.center,style: new TextStyle(
                color: bottomNavColor
              ),),),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, color:bottomNavColor),
              title: new Text("Wagon",textAlign: TextAlign.center,style: new TextStyle(
                color: bottomNavColor
              ),),),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: bottomNavColor),
            title: new Text("Account", textAlign: TextAlign.center,style: new TextStyle(
                color: bottomNavColor
              ),),
          ),
        ],
      ),
    );
  }
}
