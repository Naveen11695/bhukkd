import 'package:flutter/material.dart';
import 'Profile_Notification.dart';

class ImageBackground extends StatelessWidget {
  final DecorationImage backgroundImage;
  final DecorationImage profileImage;
  final Animation<double> containerGrowAnimation;
  final String email;
  ImageBackground(
      {this.backgroundImage,
      this.containerGrowAnimation,
      this.profileImage,
      this.email,});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return (new Container(
        width: screenSize.width,
        height: screenSize.height / 3.5,
        decoration: new BoxDecoration(image: backgroundImage),
        child: new Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
            colors: <Color>[
              const Color.fromRGBO(110, 101, 103, 0.6),
              const Color.fromRGBO(51, 51, 63, 0.9),
            ],
            stops: [0.2, 1.0],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
          )),
          child:new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new ProfileNotification(
                      containerGrowAnimation: containerGrowAnimation,
                      profileImage: profileImage,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:15.0),
                      child: Row(
                        children: <Widget>[
                          new Text(
                            "Good Morning! ",
                            style: new TextStyle(
                                fontSize: 30.0,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w100,
                                color: Colors.white),
                          ),
                          new Text(
                            email.split('@')[0].toUpperCase(),
                            style: new TextStyle(
                                fontSize: 30.0,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        )));
  }
}
