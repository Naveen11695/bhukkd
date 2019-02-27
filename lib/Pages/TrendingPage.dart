// flutter
import 'package:bhukkd/Components/DataSearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

class TrendingPage extends StatefulWidget {
  _TrendingPageState createState() => new _TrendingPageState();
}

//.......................................important........................................//

void showSuggestion(var q) async {
  fetchSearchRestraunts(q);
}

//.......................................important........................................//

class _TrendingPageState extends State<TrendingPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onVerticalDragDown: (DragDownDetails scrolldetails) {
        double currentPosition = MediaQuery.of(context).size.height -
            scrolldetails.globalPosition.dy;
      },
      child: Stack(
        children: <Widget>[
          new CustomScrollView(
            physics: ScrollPhysics(),
            slivers: <Widget>[
              new SliverAppBar(
                title: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.017,
                    ),
                    new Text("Your Location",
                        style: new TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Montserrat",
                          fontSize: 12,
                        )),
                    new Text(
                      "Delhi, NCR",
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: "Montserrat-Bold",
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Color.fromRGBO(249, 129, 42, 1),
                leading: new Icon(
                  Icons.location_on,
                  semanticLabel: "Your Location",
                  textDirection: TextDirection.ltr,
                  color: Colors.white,
                  size: 30,
                ),
                titleSpacing: 0.4,
                expandedHeight: MediaQuery.of(context).size.height * 0.13,
                pinned: false,
                primary: true,
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    height: 30,
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.92,
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: nearByrestaurants.length,
                      itemBuilder: (BuildContext context, index) {
                        return HorizontalScroll(
                            index, nearByrestaurants, cuisines, thumb);
                      },
                    ),
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
            padding: EdgeInsets.fromLTRB(15.0, 85.0, 15.0, 520.0),
            child: Material(
              type: MaterialType.canvas,
              elevation: 10.0,
              borderRadius: BorderRadius.circular(25.0),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  child: InkWell(
                    onTap: () {
                      print("Search");
                      showSearch(context: context, delegate: DataSearch());
                    },
                    splashColor: Colors.white24,
                    highlightColor: Colors.white10,
                    child: Container(
                      child: new Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.search, color: Colors.deepOrange),
                          ),
                          Center(
                            child: Text(
                              "Search for trending restraunts nearby",
                              style: new TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16.0,
                                  color: Colors.deepOrange,
                                  shadows: [
                                    Shadow(
                                        offset: Offset(0.3, 0.1),
                                        color: Colors.grey),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}