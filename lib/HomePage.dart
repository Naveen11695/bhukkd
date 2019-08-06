import 'package:bhukkd/Auth/Onboarding/Pages/onboarding_page.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Pages/Explore/ExplorePage.dart';
import 'package:bhukkd/Pages/TrendingPage/Componets/HorizontalScroll.dart';
import 'package:bhukkd/Pages/TrendingPage/TrendingPage.dart';
import 'package:bhukkd/Pages/WagonPage/WagonPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    new OnBoardingPage("LoginPage"),
  ];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final bottomNavColor = SECONDARY_COLOR_1;
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
                  color: bottomNavColor, fontFamily: FONT_TEXT_PRIMARY
              ),),),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.periscope, color:bottomNavColor),
              title: new Text("Explore",textAlign: TextAlign.center,style: new TextStyle(
                  color: bottomNavColor, fontFamily: FONT_TEXT_PRIMARY
              ),),),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.chair, color:bottomNavColor),
              title: new Text("Bookings",textAlign: TextAlign.center,style: new TextStyle(
                  color: bottomNavColor, fontFamily: FONT_TEXT_PRIMARY
              ),),),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userCircle, color: bottomNavColor),
            title: new Text("Account", textAlign: TextAlign.center,style: new TextStyle(
                color: bottomNavColor, fontFamily: FONT_TEXT_PRIMARY
              ),),
          ),
        ],
      ),
    );
  }
}
