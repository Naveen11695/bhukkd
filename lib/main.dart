import 'dart:async';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/api/HttpRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './Pages/LocationServicePage.dart';
import 'models/SharedPreferance/SharedPreference.dart';
import './Pages/HomePage.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'Components/CustomTransition.dart';

void main() {
  runApp(new Bhukkd());
}

class Bhukkd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
//      showSemanticsDebugger: true,
      title: 'SplashScreen',
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/LocationService': (BuildContext context) => new LocationServicePage(),
        '/HomePage': (BuildContext context) => new HomePage(),
      },
      theme: new ThemeData(bottomAppBarColor: Color.fromRGBO(249, 129, 42, 1)),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  Future delayTimer() async {
    Duration duration = new Duration(seconds: 7);
    return new Timer(duration, navigateTo);
  }

  //....................................version 2.0.1 (Updated shared preference check not working).................................//
  // void onClose() async{
  //   Navigator.of(context).pushReplacement(new PageRouteBuilder(
  //       maintainState: true,
  //       opaque: true,
  //       pageBuilder: (context, _, __) => StoreUserLocation.getLocation() ==null ? new LocationServicePage() : new HomePage(),
  //       transitionDuration: const Duration(seconds: 2),
  //       transitionsBuilder: (context, anim1, anim2, child) {
  //         return new FadeTransition(
  //           child: child,
  //           opacity: anim1,
  //         );
  //       }));
  // }

  void navigateTo() async {
    if (await StoreUserLocation.get_CurrentLocation() == null) {
      Route route = HorizontalTransition(
          builder: (BuildContext context) => new LocationServicePage());
      Navigator.of(context).pushReplacement(route);
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) {
                return new HomePage();
              },
              transitionDuration: const Duration(milliseconds: 1500),
              transitionsBuilder:
                  (___, Animation<double> animation, ____, Widget child) {
                return SlideTransition(
                  position: Tween<Offset>(
                          begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                      .animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Interval(
                        0.00,
                        1.00,
                        curve: Curves.ease,
                      ),
                    ),
                  ),
                  transformHitTests: false,
                  child: child,
                );
              }));
    }
  }



  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 20),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
    delayTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          splash_background,
          opacity,
          new SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(130.0),
                  child: logo,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 200.0, 0.0, 0.0),
                    child: splash_description,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CollectionScaleTransition(
                    children: <Widget>[
                      Icon(
                        Icons.face,
                        color: Color(0xFFFFFFFF),
                      ),
                      Icon(
                        Icons.fastfood,
                        color: Color(0xFFFFFFFF),
                      ),
                      Icon(
                        Icons.favorite,
                        color: Color(0xFFFFFFFF),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
