import 'package:bhukkd/Auth/Onboarding/Pages/onboarding_page.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Pages/Explore/ExplorePage.dart';
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

  int _selectedIndex = 0;


  List<Widget> bottomNavigation = [
    new TrendingPage(key:PageStorageKey("TrendingPage")),
    new ExplorePage(key:PageStorageKey("ExplorePage")),
    new WagonPage(key:PageStorageKey("WagonPage")),
    new OnBoardingPage("LoginPage"),
  ];


  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
  }

  final bottomNavColor = SECONDARY_COLOR_1;

  Widget _bottomNavigationBar(int selectedIndex) =>
      BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int index) => setState(() => _selectedIndex = index),
        currentIndex: selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.trending_up,
              color: SECONDARY_COLOR_1,
            ),
            title: const Text(
              "Trending", textAlign: TextAlign.center, style: const TextStyle(
                color: SECONDARY_COLOR_1, fontFamily: FONT_TEXT_PRIMARY
            ),),),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.periscope, color: SECONDARY_COLOR_1),
            title: const Text(
              "Explore", textAlign: TextAlign.center, style: const TextStyle(
                color: SECONDARY_COLOR_1, fontFamily: FONT_TEXT_PRIMARY
            ),),),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.chair, color: SECONDARY_COLOR_1),
            title: const Text(
              "Bookings", textAlign: TextAlign.center, style: const TextStyle(
                color: SECONDARY_COLOR_1, fontFamily: FONT_TEXT_PRIMARY
            ),),),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userCircle, color: SECONDARY_COLOR_1),
            title: const Text(
              "Account", textAlign: TextAlign.center, style: const TextStyle(
                color: SECONDARY_COLOR_1, fontFamily: FONT_TEXT_PRIMARY
            ),),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: bottomNavigation[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}