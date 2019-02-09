// flutter
import 'package:flutter/material.dart';

// custom
import '../Components/HorizontalScroll.dart';
import '../api/HttpRequest.dart';
import '../api/LocationRequest.dart';
import '../models/Restruant/Restruant.dart';
class TrendingPage extends StatefulWidget {
  _TrendingPageState createState() => new _TrendingPageState();
}

//Restaurant restaurant; 
// first time this function is giving a null error, second time it is executing fine
void _fetchRestaurant(){
  requestRestaurant("https://developers.zomato.com/api/v2.1/restaurant?res_id=1806", "1806").then((rest){
    print(rest.restruant_Name);
    print(rest.restruant_Id);// id is comming null
    print(rest.restruant_Menu);
    //rest=restaurant;
  });
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
              _fetchRestaurant();
              //getCurrentPosition();
               //requestCategories("https://developers.zomato.com/api/v2.1/categories");
               // requestGeoCode("https://developers.zomato.com/api/v2.1/geocode?lat=28.7041&lon=77.1025", "28.7041", "77.1025");
            },
            child: new Text("Click"),
          )
        ],
      ),
    );
  }
}
