import 'package:flutter/material.dart';

class HorizontalScroll extends StatefulWidget {
  @override
  _HorizontalScrollState createState() => new _HorizontalScrollState();
}

class _HorizontalScrollState extends State<HorizontalScroll> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        new Container(
          width: 200.0,
          child: new Container(
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    new Image.asset("assets/images/food.png", fit: BoxFit.cover, width: 150,),
                    ],
                  ),
                    new Text("Food Name"),
                    new Text("Description", style: new TextStyle(
                    fontSize: 12.0,
                    color: Theme.of(context).textTheme.subtitle.color
                  ),)
                ],
              ),
            ), 
          ),
        ),
      ],
    );
  }
}