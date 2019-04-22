import 'package:bhukkd/Components/CustomTransition.dart';
import 'package:bhukkd/flarecode/flare_actor.dart';
import 'package:flutter/material.dart';
import '../Pages/TrendingPage.dart';
import '../Pages/RestaurantDetailPage.dart';

class CustomHorizontalScroll extends StatelessWidget {
TrendingPage trendingPage;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        height: 150,
        child: FutureBuilder(
          future: getEntityFromLocations(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: new Material(
                        elevation: 10.0,
                        child: Container(
                          margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                          height: 100,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: <Widget>[
                                new Container(
                                  margin: EdgeInsets.only(left: 3),
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                      image: snapshot.data[index].thumb ==
                                                  null ||
                                              snapshot.data[index].thumb == ""
                                          ? AssetImage(
                                              "assets/images/default.jpg")
                                          : NetworkImage(
                                              snapshot.data[index].thumb),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                new SizedBox(
                                  width: 20,
                                ),
                                new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(
                                      snapshot.data[index].name,
                                      softWrap: true,
                                      style: TextStyle(
                                          fontFamily: "Raleway", fontSize: 14),
                                    ),
                                    new Text(
                                      snapshot.data[index]
                                              .near_by_restaurants_location[
                                          "locality"],
                                      style: TextStyle(
                                          fontFamily: "", fontSize: 10),
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        Icon(Icons.star,
                                            color: Colors.deepOrange),
                                        Icon(Icons.star,
                                            color: Colors.deepOrange),
                                        Icon(Icons.star, color: Colors.orange),
                                        Icon(Icons.star, color: Colors.orange),
                                        Icon(Icons.star, color: Colors.black12),
                                      ],
                                    ),
                                    new SizedBox(
                                      height: 8,
                                    ),
                                    new Container(
                                      height: 1,
                                      width: 60,
                                      color: Colors.deepOrange,
                                    ),
                                    new SizedBox(height: 8),
                                    new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            HorizontalTransition(
                                builder: (BuildContext context) =>
                                    RestaurantDetailPage(
                                      productid: snapshot.data[index].id,
                                    )));
                      },
                    );
                  },
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        color: Colors.grey.shade100,
                        height: 100,
                        width: 300,
                        child: new Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: new FlareActor(
                            "assets/animations/top_restaurant_loading.flr",
                            animation: "circular_loading",
                            fit: BoxFit.cover,
                          ),
                        ));
                  });
            } else {
              return Container(
                height: 10,
                width: 10,
              );
            }
          },
        ));
  }
}
