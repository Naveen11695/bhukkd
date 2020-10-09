import 'package:bhukkd/Constants/app_constant.dart';
import 'package:flutter/material.dart';

class ListData extends StatelessWidget {
  final EdgeInsets margin;
  final double width;
  final String title;
  final String subtitle;
  final DecorationImage image;

  ListData({this.margin, this.subtitle, this.title, this.width, this.image});

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.5;
    return (new Container(
      alignment: Alignment.center,
      margin: margin,
      width: width,
      decoration: new BoxDecoration(
        color: Colors.white,
        border: new Border(
          top: new BorderSide(
              width: 1.0, color: const Color.fromRGBO(204, 204, 204, 0.3)),
          bottom: new BorderSide(
              width: 5.0, color: const Color.fromRGBO(204, 204, 204, 0.3)),
        ),
      ),
      child: new Row(
        children: <Widget>[
          new Container(
              margin: new EdgeInsets.only(
                  left: 20.0, top: 5.0, bottom: 5.0, right: 20.0),
              width: 60.0,
              height: 60.0,
              decoration:
              new BoxDecoration(shape: BoxShape.rectangle, image: image)),
          new Container(
            width: c_width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  title,
                  style:
                  new TextStyle(fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: TEXT_PRIMARY_COLOR,
                      fontFamily: FONT_TEXT_EXTRA),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 5.0, bottom: 10.0),
                  child: new Text(
                    subtitle,
                    style: new TextStyle(
                      color: TEXT_SECONDARY_COLOR,
                      fontSize: 12.0,
                      wordSpacing: 0.5,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                      fontFamily: FONT_TEXT_SECONDARY,),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
