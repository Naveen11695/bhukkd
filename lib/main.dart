import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';
import './Pages/LocationServicePage.dart';
import 'models/SharedPreferance/SharedPreference.dart';
import './Pages/HomePage.dart';
import 'package:progress_indicators/progress_indicators.dart';

void main() {
  runApp(new Bhukkd());
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


const TextStyle textStyle = TextStyle(
  color: Colors.deepOrangeAccent,
  fontFamily: 'Raleway',
);

class Bhukkd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SplashScreen',
      home: SplashScreen(),
    );
  }
}


class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  final background = Container(
    decoration : BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/images/3.jpeg'),
          fit: BoxFit.cover,
      )
    )
  );

  final orangeOpacity = Container(
    color: Color(0xAAAA1222),
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);


    final logo = new ScaleTransition(
      scale: animation,
      child: Image.asset(
        'assets/images/icon.png',
        width: 180.0,
        height: 180.0,
      ),
    );

    final description = Text(
          'Loading Assets',
          textAlign: TextAlign.center,
          style: textStyle.copyWith(fontSize: 24.0,),
    );


    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          background,
          orangeOpacity,
          new SafeArea(child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(100.0),
                child: logo,
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(100,300,100,30),
                child: description,
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CollectionScaleTransition(
                  children: <Widget>[
                    Icon(Icons.face),
                    Icon(Icons.fastfood),
                    Icon(Icons.favorite),
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
















/*
class Bhukkd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        "assets/images/icon.png",
      ),
      photoSize: 100,

      navigateAfterSeconds:(StoreUserLocation.getLocation() ==null) ? new LocationServicePage() : new HomePage(),
    );
  }
}

*/
