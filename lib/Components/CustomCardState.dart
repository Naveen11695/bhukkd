import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  var name;
  var address;

  CustomCard(this.name, this.address);

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
                    "assets/images/default.jpg",
                    fit: BoxFit.fitWidth,
                    height: 140,
                    width: 50,
                  ),
                ),
              ],
            ),
          ),
          new Text(widget.name, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),),
          new Text(
            widget.address,
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontSize: 10.0,
                color: Theme.of(context).textTheme.subtitle.color),
          )
        ],
      ),
    );
  }
}