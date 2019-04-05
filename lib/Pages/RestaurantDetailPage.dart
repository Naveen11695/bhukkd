import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/GeoCodeInfo/GeoCode.dart';

class RestaurantDetailPage extends StatelessWidget {
  int i = 0;
  final productid;
  var nearByrestaurants = [];
  var cuisines = [];
  var thumb = [];
  var restaurant_photos=[];
  var restaurant_menu=[];

  RestaurantDetailPage({this.productid, this.nearByrestaurants,this.cuisines,this.thumb, this.restaurant_photos, this.restaurant_menu});
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (BuildContext context, Widget child, GeoCode model){
      return WillPopScope(
      onWillPop: () {
        print("back button pressed");
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: 
      Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 256,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: new Text(
                nearByrestaurants[productid],
                textAlign: TextAlign.end,
                style: new TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    wordSpacing: 1),
              ),
              centerTitle: false,
              background: Hero(
                tag: i++, // unique id
                child: FadeInImage(
                  image: NetworkImage(thumb[productid]),
                  height: 300,
                  fadeInDuration: const Duration(seconds: 1),
                  placeholder: AssetImage("assets/images/pizza.jpg"),
                  fit: BoxFit.cover,
                  fadeOutDuration: const Duration(seconds: 1),
                  fadeInCurve: Curves.fastOutSlowIn,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 20,),
              Padding(padding:EdgeInsets.only(left:10, bottom: 5),child:Text("Details", style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                letterSpacing: 1
              ),),),
              Padding(padding:EdgeInsets.only(left:10, bottom: 5),child:Text("Cuisines", style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.normal,
                fontSize: 18.0,
              ),),),
              Padding(
                padding: const EdgeInsets.only(left:10),
                child: Text(cuisines[productid], style: TextStyle(
                  color: Colors.grey
                ),),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: Text("Photos", style: TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  letterSpacing: 1
                ),),
              ),
              Container(
                height: 150.0,
                width: MediaQuery.of(context).size.width * 0.92,
                padding: EdgeInsets.only(top:20),
                child:ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    new Image.network(restaurant_photos[productid], fit: BoxFit.cover,),
                  ],
                ))
              
            ]),
          )
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.restaurant),
        tooltip: "Reserve a seat",
        mini: true,
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(249, 129, 42, 1),
      ),
    ));
    },); 
  }
}
