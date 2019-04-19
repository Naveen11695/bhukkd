import 'package:flutter/material.dart';

class ProfileNotification extends StatelessWidget {
  final Animation<double> containerGrowAnimation;
  final DecorationImage profileImage;
  ProfileNotification({this.containerGrowAnimation, this.profileImage});
  @override
  Widget build(BuildContext context) {
    return (new Container(
        child: new Column(
          children: [
            new Container(
                width: containerGrowAnimation.value * 35,
                height: containerGrowAnimation.value * 35,
                margin: new EdgeInsets.only(left: 80.0),
                child: new Center(
                  child: new Text("2",
                      style: new TextStyle(
                          fontSize: containerGrowAnimation.value * 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.deepOrange)),
                ),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                )),
          ],
        ),
        width: containerGrowAnimation.value * 120,
        height: containerGrowAnimation.value * 120,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: profileImage,
        )));
  }
}
