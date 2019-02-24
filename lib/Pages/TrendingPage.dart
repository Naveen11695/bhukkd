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
    fetchRestByGeoCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              new Container(
                height: MediaQuery.of(context).size.height * 0.13,
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
                      margin: EdgeInsets.only(top: 30),
                      child: new Column(
                        children: <Widget>[
                          new Text(
                            "Your Location",
                            style: new TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontFamily: "",
                              fontSize: 12,
                            ),
                          ),
                          new Text(
                            "Delhi, ncr",
                            style: new TextStyle(
                              color: Colors.white,
                              fontFamily: "",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              
              new Container(
                padding: EdgeInsets.fromLTRB(15.0, 65.0, 15.0, 10.0),
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
                        hintStyle:
                            new TextStyle(color: Colors.deepOrange, shadows: [
                          Shadow(offset: Offset(0.3, 0.1), color: Colors.grey),
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
          child:new Text("Near By Restaurants", textAlign: TextAlign.start,style:new TextStyle(
                            fontSize: 20.0,
                            fontFamily: "",
                            fontWeight: FontWeight.w700,
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
                          itemCount: 5,
                          itemBuilder: (BuildContext context, index) {
                            return HorizontalScroll();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     elevation: 2.0,
    //     backgroundColor: Colors.white,
    //     actions: <Widget>[
    //       Column(
    //         children: <Widget>[
    //           new Text("Now",
    //               style: new TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 16.0,
    //                   height: 1.9,
    //                   fontWeight: FontWeight.bold)
    //           ),
    //           SizedBox(height: 0.5),
    //           Text(
    //             "-------",
    //             style: TextStyle(color: Colors.black, fontSize: 15.0),
    //           )
    //         ],
    //       ),
    //       Padding(
    //         padding: EdgeInsets.only(bottom: 15.0),
    //         child: Icon(
    //           Icons.arrow_forward,
    //           color: Colors.black,
    //           size: 12.0,
    //         ),
    //       ),
    //       SizedBox(
    //         width: 70,
    //       ),
    //       Column(
    //         children: <Widget>[
    //           Container(
    //             height: 20.0,
    //             width: 100.0,
    //             child: TextField(
    //               decoration: InputDecoration(
    //                   border: OutlineInputBorder(borderSide: BorderSide.none)),
    //             ),
    //           ),
    //           SizedBox(height: 5.0),
    //           Text(
    //             "                                                                     ",
    //             style: TextStyle(color: Colors.black, fontSize: 15.0),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    //   backgroundColor: Colors.white,
    //   body: ListView(
    //     shrinkWrap: true,
    //     children: <Widget>[
    //       Row(
    //         children: <Widget>[
    //           Padding(
    //             padding: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
    //             child: Text(
    //               "Latest Offers",
    //               style: TextStyle(
    //                 color: Colors.deepOrange,
    //                 fontSize: 20.0,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //       SizedBox(height: 1),
    //       Padding(
    //         padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
    //         child: Column(
    //           children: <Widget>[
    //             new Container(
    //               width: double.infinity,
    //               height: MediaQuery.of(context).size.height * 0.40,
    //               child: new ListView.builder(
    //                 scrollDirection: Axis.horizontal,
    //                 itemCount: 5,
    //                 itemBuilder: (context, index) {
    //                   return HorizontalScroll();
    //                 },
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
