import 'dart:async';

import 'package:bhukkd/Auth/Onboarding/Pages/onboarding_page.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Pages/Explore/ExplorePage.dart';
import 'package:bhukkd/Pages/TrendingPage/TrendingPage.dart';
import 'package:bhukkd/Pages/WagonPage/WagonPage.dart';
import 'package:bhukkd/Services/SharedPreference.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  static final String path = "lib/src/pages/misc/navybar.dart";

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  void dispose() {
    indexcontroller.close();
    super.dispose();
  }

  PageController pageController = PageController(initialPage: 0);
  StreamController<int> indexcontroller = StreamController<int>.broadcast();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getLocationName(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == "error") {
                return Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topCenter,
                          height: 600,
                          width: 400,
                          child: Center(
                            child: FlareActor(
                              "assets/animations/no_connection.flr",
                              animation: "Untitled",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text("No Connection",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: FONT_TEXT_EXTRA,
                                  letterSpacing: 2,
                                  wordSpacing: 2
                              )),
                        ),
                        RaisedButton.icon(
                          onPressed: () {
                            setState(() {});
                          },
                          color: SECONDARY_COLOR_1,
                          label: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text('Retry', style: TextStyle(
                                fontSize: 15.0, color: Colors.white)),
                          ),
                          icon: Icon(Icons.refresh, color: Colors.white,),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.data != null) {
                String address;
                if (snapshot.data.locality != null) {
                  address = snapshot.data.name +
                      " " +
                      snapshot.data.subLocality +
                      " " +
                      snapshot.data.subAdministrativeArea +
                      ", " +
                      snapshot.data.locality +
                      " " +
                      snapshot.data.postalCode;
                }
                return PageView(
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    indexcontroller.add(index);
                  },
                  controller: pageController,
                  children: <Widget>[
                    new TrendingPage(PageStorageKey("TrendingPage"), address),
                    new ExplorePage(key: PageStorageKey("ExplorePage")),
                    new WagonPage(key: PageStorageKey("WagonPage")),
                    new OnBoardingPage("LoginPage"),
                  ],
                );
              } else {
                return Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topCenter,
                          height: 600,
                          width: 400,
                          child: Center(
                            child: FlareActor(
                              "assets/animations/no_connection.flr",
                              animation: "Untitled",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text("No Connection",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: FONT_TEXT_EXTRA,
                                  letterSpacing: 2,
                                  wordSpacing: 2
                              )),
                        ),
                        RaisedButton.icon(
                          onPressed: () {
                            setState(() {});
                          },
                          color: SECONDARY_COLOR_1,
                          label: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text('Retry', style: TextStyle(
                                fontSize: 15.0, color: Colors.white)),
                          ),
                          icon: Icon(Icons.refresh, color: Colors.white,),
                        ),
                      ],
                    ),
                  ),
                );
              }
            } else {
              return Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topCenter,
                        height: 600,
                        width: 400,
                        child: Center(
                          child: FlareActor(
                            "assets/animations/no_connection.flr",
                            animation: "Untitled",
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text("No Connection",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: FONT_TEXT_EXTRA,
                                letterSpacing: 2,
                                wordSpacing: 2
                            )),
                      ),
                      RaisedButton.icon(
                        onPressed: () {
                          setState(() {});
                        },
                        color: SECONDARY_COLOR_1,
                        label: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text('Retry', style: TextStyle(
                              fontSize: 15.0, color: Colors.white)),
                        ),
                        icon: Icon(Icons.refresh, color: Colors.white,),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
      bottomNavigationBar: StreamBuilder<Object>(
          initialData: 0,
          stream: indexcontroller.stream,
          builder: (context, snapshot) {
            int cIndex = snapshot.data;
            return FancyBottomNavigation(
              currentIndex: cIndex,
              items: <FancyBottomNavigationItem>[
                FancyBottomNavigationItem(
                  icon: Icon(
                    Icons.trending_up,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Trending",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white, fontFamily: FONT_TEXT_PRIMARY),
                  ),
                ),
                FancyBottomNavigationItem(
                  icon: Icon(
                    FontAwesomeIcons.periscope,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Explore",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white, fontFamily: FONT_TEXT_PRIMARY),
                  ),
                ),
                FancyBottomNavigationItem(
                  icon: Icon(
                    FontAwesomeIcons.chair,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Bookings",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white, fontFamily: FONT_TEXT_PRIMARY),
                  ),
                ),
                FancyBottomNavigationItem(
                  icon: Icon(
                    FontAwesomeIcons.userCircle,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Account",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white, fontFamily: FONT_TEXT_PRIMARY),
                  ),
                ),
              ],
              onItemSelected: (int value) {
                indexcontroller.add(value);
                pageController.jumpToPage(value);
              },
            );
          }),
    );
  }
}

// ignore: missing_return
Future getLocationName() async {
  try {
    await StoreUserLocation.get_CurrentLocation().then((loc) {
      latitude = double.parse(loc[0]);
      longitude = double.parse(loc[1]);
    });

    Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager = true;
    GeolocationStatus geolocationStatus =
    await geolocator.checkGeolocationPermissionStatus();
    if (geolocationStatus == GeolocationStatus.granted) {
      List<Placemark> placemark =
      await Geolocator().placemarkFromCoordinates(latitude, longitude);
      return placemark[0];
    } else {
      print("Location denied ");
      return null;
    }
  } catch (e) {
    print("error <Trending Page>: " + e.toString());
    if (e.toString().compareTo("grpc failed") == 0) {
      return null;
    }
  }
}

class FancyBottomNavigation extends StatefulWidget {
  final int currentIndex;
  final double iconSize;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;
  final List<FancyBottomNavigationItem> items;
  final ValueChanged<int> onItemSelected;

  FancyBottomNavigation({Key key,
    this.currentIndex = 0,
    this.iconSize = 24,
    this.activeColor,
    this.inactiveColor,
    this.backgroundColor,
    @required this.items,
    @required this.onItemSelected}) {
    assert(items != null);
    assert(onItemSelected != null);
  }

  @override
  _FancyBottomNavigationState createState() {
    return _FancyBottomNavigationState(
        items: items,
        backgroundColor: backgroundColor,
        currentIndex: currentIndex,
        iconSize: iconSize,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        onItemSelected: onItemSelected);
  }
}

class _FancyBottomNavigationState extends State<FancyBottomNavigation> {
  final int currentIndex;
  final double iconSize;
  Color activeColor;
  Color inactiveColor;
  Color backgroundColor;
  List<FancyBottomNavigationItem> items;
  int _selectedIndex;
  ValueChanged<int> onItemSelected;

  _FancyBottomNavigationState({@required this.items,
    this.currentIndex,
    this.activeColor,
    this.inactiveColor = Colors.black,
    this.backgroundColor,
    this.iconSize,
    @required this.onItemSelected}) {
    _selectedIndex = currentIndex;
  }

  Widget _buildItem(FancyBottomNavigationItem item, bool isSelected) {
    return AnimatedContainer(
      width: isSelected ? 124 : 50,
      height: double.maxFinite,
      duration: Duration(milliseconds: 250),
      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        color: activeColor,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconTheme(
                  data: IconThemeData(
                      size: iconSize,
                      color: isSelected ? backgroundColor : inactiveColor),
                  child: item.icon,
                ),
              ),
              isSelected
                  ? DefaultTextStyle.merge(
                style: TextStyle(color: backgroundColor),
                child: item.title,
              )
                  : SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    activeColor =
    (activeColor == null) ? Theme
        .of(context)
        .accentColor : activeColor;

    backgroundColor = (backgroundColor == null)
        ? Theme
        .of(context)
        .bottomAppBarColor
        : backgroundColor;

    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 56,
      padding: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          var index = items.indexOf(item);
          return GestureDetector(
            onTap: () {
              onItemSelected(index);

              setState(() {
                _selectedIndex = index;
              });
            },
            child: _buildItem(item, _selectedIndex == index),
          );
        }).toList(),
      ),
    );
  }
}

class FancyBottomNavigationItem {
  final Icon icon;
  final Text title;

  FancyBottomNavigationItem({
    @required this.icon,
    @required this.title,
  }) {
    assert(icon != null);
    assert(title != null);
  }
}
