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
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Container(
            constraints: BoxConstraints.expand(
              width: 160.0,
            ),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(0.6),
            // ),
            child: new Container(
              child: Card(
                margin: EdgeInsets.only(left:5, top:2, bottom: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: new Image.asset(
                            "assets/images/pizza.jpg",
                            fit: BoxFit.cover,
                            width: 150,
                          ),
                        ),
                      ],
                    ),
                    new Text("Food Name"),
                    new Text(
                      "Description",
                      style: new TextStyle(
                          fontSize: 10.0,
                          color: Theme.of(context).textTheme.subtitle.color),
                    )
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
