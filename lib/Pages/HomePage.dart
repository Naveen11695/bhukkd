import 'package:bhukkd/Pages/ExplorePage.dart';
import 'package:flutter/material.dart';
import './TrendingPage.dart';
import 'package:bhukkd/Auth/LoginPage.dart';
import './WagonPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Components/HorizontalScroll.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => new _HomePage();
}


AsyncSnapshot saveGeoCodeRest=AsyncSnapshot.nothing();

class _HomePage extends State<HomePage> {

  int selectedIndex = 0;


  List<Widget> bottomNavigation = [
    new TrendingPage(key:PageStorageKey("TrendingPage")),
    new ExplorePage(key:PageStorageKey("ExplorePage")),
    new WagonPage(key:PageStorageKey("WagonPage")),
    new LoginPage(key:PageStorageKey("LoginPage")),
  ];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final bottomNavColor = Theme.of(context).bottomAppBarColor;
    return new Scaffold(
      body: bottomNavigation[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            saveGeoCodeRest = fetchRestByGeoCodeData;
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
              icon: Icon(FontAwesomeIcons.periscope, color:bottomNavColor),
              title: new Text("Explore",textAlign: TextAlign.center,style: new TextStyle(
                color: bottomNavColor
              ),),),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.chair, color:bottomNavColor),
              title: new Text("Bookings",textAlign: TextAlign.center,style: new TextStyle(
                color: bottomNavColor
              ),),),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userCircle, color: bottomNavColor),
            title: new Text("Account", textAlign: TextAlign.center,style: new TextStyle(
                color: bottomNavColor
              ),),
          ),
        ],
      ),
    );
  }
}
