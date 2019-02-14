import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:splashscreen/splashscreen.dart';
import './Pages/LocationServicePage.dart';
import 'models/SharedPreferance/SharedPreference.dart';
import './Pages/HomePage.dart';
import 'package:progress_indicators/progress_indicators.dart';

void main() {
  runApp(new Bhukkd());
}

const TextStyle textStyle = TextStyle(
  color: Color(0xFFFFFFFF),
  fontFamily: 'Raleway',
);



var description;

class Bhukkd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SplashScreen',
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/LocationService':(BuildContext context) => new LocationServicePage(),
        '/HomePage':(BuildContext context) => new HomePage(),

      },
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
    Duration duration = new Duration(seconds: 8);
    return new Timer(duration, navigateTo);
  }

  void navigateTo() async{
    if(await StoreUserLocation.getLocation()==null){
      Navigator.of(context).pushReplacementNamed('/LocationService');
    }
    else{
      Navigator.of(context).pushReplacementNamed('/HomePage');
    }
  }

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
    delayTimer();
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
    color: Color(0xAAAF1222),
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



    return Scaffold(
      body: Stack(
        fit: StackFit.passthrough,
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
                padding: const EdgeInsets.fromLTRB(100,150,100,30),
                child: description,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CollectionScaleTransition(
                  children: <Widget>[
                    Icon(Icons.face, color: Color(0xFFFFFFFF),),
                    Icon(Icons.fastfood, color: Color(0xFFFFFFFF),),
                    Icon(Icons.favorite, color: Color(0xFFFFFFFF),),
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


  //....................................version 2.0.1 (Updated shared preference check not working).................................//
  void onClose() {
    Navigator.of(context).pushReplacement(new PageRouteBuilder(
        maintainState: true,
        opaque: true,
        pageBuilder: (context, _, __) => ((StoreUserLocation.getLocation() ==null) ? new LocationServicePage() : new HomePage()),
        transitionDuration: const Duration(seconds: 2),
        transitionsBuilder: (context, anim1, anim2, child) {
          return new FadeTransition(
            child: child,
            opacity: anim1,
          );
        }));
  }


  //....................................version 2.0.1 (Updated shared preference check not working).................................//

  static Widget descriptionMethod(var text) {
    description = Text(
    text,
    textAlign: TextAlign.center,
    style: textStyle.copyWith(fontSize: 24.0,),
    );
  }
}









