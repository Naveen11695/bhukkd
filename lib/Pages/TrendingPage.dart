import 'package:flutter/material.dart';
import '../Components/HorizontalScroll.dart';


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
        children: <Widget>[
          HorizontalScroll(),
        ],
      ),
    );
  }
}
