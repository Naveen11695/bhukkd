import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  var result1;

  CustomCard(this.result1);

  @override
  CustomCardState createState() {
    return new CustomCardState();
  }
}

class CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Card(
      //shape: StadiumBorder(),
      elevation: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: new Image.asset(
                    "assets/images/food.png",
                    fit: BoxFit.fitWidth,
                    height: 150,
                    width: 50,
                  ),
                ),
              ],
            ),
          ),
          new Text(widget.result1),
          new Text(
            "Description",
            style: new TextStyle(
                fontSize: 10.0,
                color: Theme.of(context).textTheme.subtitle.color),
          )
        ],
      ),
    );
  }
}