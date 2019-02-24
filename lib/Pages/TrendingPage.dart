// flutter
import 'package:flutter/material.dart';

// custom
import '../Components/HorizontalScroll.dart';
import '../api/HttpRequest.dart';
import 'package:http/http.dart';
import '../models/SharedPreferance/SharedPreference.dart';
import '../api/LocationRequest.dart';
import '../models/Restruant/Restruant.dart';
import 'package:html/parser.dart';
import '../models/GeoCodeInfo/GeoCode.dart';

class TrendingPage extends StatefulWidget {
  _TrendingPageState createState() => new _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Column(
            children: <Widget>[
              new Text("Now",
                  style: new TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      height: 1.9,
                      fontWeight: FontWeight.bold)
              ),
              SizedBox(height: 0.5),
              Text(
                "-------",
                style: TextStyle(color: Colors.black, fontSize: 15.0),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Icon(
              Icons.arrow_forward,
              color: Colors.black,
              size: 12.0,
            ),
          ),
          SizedBox(
            width: 70,
          ),
          Column(
            children: <Widget>[
              Container(
                height: 20.0,
                width: 100.0,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                "                                                                     ",
                style: TextStyle(color: Colors.black, fontSize: 15.0),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                child: Text(
                  "Latest Offers",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 1),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
            child: Column(
              children: <Widget>[
                new Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.40,
                  child: new ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return HorizontalScroll();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
