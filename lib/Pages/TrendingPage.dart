// flutter
import 'package:bhukkd/Components/DataSearch.dart';
import 'package:flutter/material.dart';

// custom
import '../Components/HorizontalScroll.dart';
import '../api/HttpRequest.dart';
import '../Components/CustomHorizontalScroll.dart';
import '../Components/CategoriesComponent.dart';
import 'package:http/http.dart';
import '../models/SharedPreferance/SharedPreference.dart';
import '../api/LocationRequest.dart';
import '../models/Restruant/Restruant.dart';
import 'package:html/parser.dart';
import '../models/GeoCodeInfo/GeoCode.dart';

/*------------------------------DISCLAIMER----------------------------------- */
// font used is OpenSans and Montserrat, please dont use any other font.


 int count=0;

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
      body: GestureDetector(
      onVerticalDragDown: (DragDownDetails scrolldetails) {
        double currentPosition = MediaQuery.of(context).size.height -
            scrolldetails.globalPosition.dy;
      },
      child: Stack(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Stack(
                children: <Widget>[
                  new Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    color: Color.fromRGBO(249, 129, 42, 1), //249 129 42
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(left: 20),
                          child: new Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        new Container(
                          margin: EdgeInsets.only(top: 50),
                          child: new Column(
                            children: <Widget>[
                              new Text(
                                "Your Location",
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Montserrat",
                                  fontSize: 12,
                                ),
                              ),
                              new Text(
                                "Delhi, ncr",
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Montserrat-Bold",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.fromLTRB(15.0, 100.0, 15.0, 10.0),
                    child: Material(
                      type: MaterialType.canvas,
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(25.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon:
                                Icon(Icons.search, color: Colors.deepOrange),
                            contentPadding: EdgeInsets.all(15),
                            hasFloatingPlaceholder: false,
                            hintText: "Search for trending restraunts nearby",
                            hintStyle: new TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w300,
                                color: Colors.deepOrange,
                                shadows: [
                                  Shadow(
                                      offset: Offset(0.3, 0.1),
                                      color: Colors.grey),
                                ])),
                        keyboardType: TextInputType.text,
                        keyboardAppearance: Brightness.light,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.height * 0.92,
                alignment: AlignmentDirectional.topStart,
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: new Text(
                  "Near By Restaurants",
                  textAlign: TextAlign.start,
                  style: new TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Raleway",
                    // fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    wordSpacing: 0.0,
                  ),
                ),
              ),
              new Padding(
                padding: EdgeInsets.only(left: 15),
                child: Container(
                  child: new Row(
                    children: <Widget>[
                      new Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.92,
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: nearByrestaurants.length,
                              itemBuilder: (BuildContext context, index) {
                                return HorizontalScroll(index,nearByrestaurants,cuisines,thumb);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.height * 0.92,
                    alignment: AlignmentDirectional.topStart,
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    child: new Text(
                      "Top Restraunts",
                      textAlign: TextAlign.start,
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Raleway",
                        // fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        wordSpacing: 0.0,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey.shade100,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                      child: CustomHorizontalScroll(),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.height * 0.92,
                    alignment: AlignmentDirectional.topStart,
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    child: new Text(
                      "Categories",
                      textAlign: TextAlign.start,
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Raleway",
                        // fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        wordSpacing: 0.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: CategoriesComponent(),
                  )
                ]),
              ),
            ],
          ),
          new Container(
            padding: EdgeInsets.fromLTRB(15.0, 85.0, 15.0, 10.0),
            child: Material(
              clipBehavior: Clip.hardEdge,
              type: MaterialType.canvas,
              elevation: 10.0,
              borderRadius: BorderRadius.circular(25.0),
              child: TextFormField(
                scrollPadding: EdgeInsets.all(1),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.deepOrange),
                    contentPadding: EdgeInsets.all(15),
                    hasFloatingPlaceholder: true,
                    hintText: "Search for trending restraunts nearby",
                    hintStyle: new TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w300,
                        color: Colors.deepOrange,
                        shadows: [
                          Shadow(offset: Offset(0.3, 0.1), color: Colors.grey),
                        ])),
                keyboardType: TextInputType.text,
                maxLines: 1,
                keyboardAppearance: Brightness.light,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
