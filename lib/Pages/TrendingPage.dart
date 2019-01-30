// flutter
import 'package:flutter/material.dart';

// custom
import '../Components/HorizontalScroll.dart';
import '../api/HttpRequest.dart';

class TrendingPage extends StatefulWidget {
  _TrendingPageState createState() => new _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          HorizontalScroll(),
          HorizontalScroll(),
          new FlatButton(
            onPressed: (){
              getjsonResponse();
            },
            child: new Text("Click"),
          )
        ],
      ),
    );
  }
}
