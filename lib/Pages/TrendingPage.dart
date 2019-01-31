// flutter
import 'package:flutter/material.dart';

// custom
import '../Components/HorizontalScroll.dart';
import '../api/HttpRequest.dart';
import '../api/LocationRequest.dart';

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
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          HorizontalScroll(),
          HorizontalScroll(),
          new FlatButton(
            onPressed: (){
              getCurrentPosition();
              //requestCategories("https://developers.zomato.com/api/v2.1/categories");
               // requestGeoCode("https://developers.zomato.com/api/v2.1/geocode?lat=28.7041&lon=77.1025", "28.7041", "77.1025");
                    requestRestaurant("https://developers.zomato.com/api/v2.1/restaurant?res_id=1806", "1806");
            },
            child: new Text("Click"),
          )
        ],
      ),
    );
  }
}
