import 'package:flutter/material.dart';
import '../models/GeoCodeInfo/GeoCode.dart';
import '../models/Restruant/Restruant.dart';

class HorizontalScroll extends StatelessWidget {
  
  // HorizontalScroll();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
          child: new Container(
            width: 160.0,
            child: new Container(
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                     child: new Image.asset("assets/images/food.png", fit: BoxFit.cover, width: 150,
                      ),
                        ),
                      ],
                    ),
                      new Text("Food Name"),
                      new Text("Description", style: new TextStyle(
                      fontSize: 10.0,
                      color: Theme.of(context).textTheme.subtitle.color
                    ),)

                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
