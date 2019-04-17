import 'package:flutter/material.dart';
import '../models/GeoCodeInfo/GeoCode.dart';
import '../models/Restruant/Restruant.dart';
import '../Pages/RestaurantDetailPage.dart';
import '../Components/CustomTransition.dart';
import '../api/HttpRequest.dart';

class HorizontalScroll extends StatelessWidget {
  // int index;
  // // final List nearby_restaurants;
  // // final List cuisines;
  // // final List thumb;
  // // final List restaurant_menu;
  // // final List photo_Links;
  // HorizontalScroll(this.index);

  // HorizontalScroll();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchRestByGeoCode(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            print("name of the rest: " +
                snapshot.data.nearby_restaurants[0].name +
                " Cuisines: " +
                snapshot.data.nearby_restaurants[0].cuisines);
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.nearby_restaurants.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: new Container(
                      constraints: BoxConstraints.expand(
                        width: 180.0,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              HorizontalTransition(
                                  builder: (BuildContext context) =>
                                      RestaurantDetailPage(
                                        productid: snapshot
                                            .data.nearby_restaurants[index].id,
                                      )
                                  /*RestaurantDetailPage(productid:index, nearByrestaurants:nearby_restaurants, cuisines:cuisines, thumb:thumb, restaurant_menu: restaurant_menu,restaurant_photos: photo_Links,)*/));
                        },
                        child: new Container(
                          child: Card(
                            margin: EdgeInsets.only(left: 5, top: 2, bottom: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: (snapshot
                                                    .data
                                                    .nearby_restaurants[index]
                                                    .thumb ==
                                                "")
                                            ? new Image.asset(
                                                "assets/images/5.jpg",
                                                fit: BoxFit.cover,
                                                width: 150,
                                                height: 115,
                                              )
                                            : new Image.network(
                                                snapshot
                                                    .data
                                                    .nearby_restaurants[index]
                                                    .thumb,
                                                fit: BoxFit.cover,
                                                width: 150,
                                                height: 115,
                                              ),
                                      ),
                                    ],
                                  ),
                                  new Text(
                                    snapshot
                                        .data.nearby_restaurants[index].name,
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(shadows: [
                                      Shadow(
                                          offset: Offset(0.3, 0.1),
                                          color: Colors.grey),
                                    ]),
                                    softWrap: true,
                                  ),
                                  new Text(
                                    snapshot.data.nearby_restaurants[index]
                                        .cuisines,
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                        fontSize: 10.0,
                                        color: Theme.of(context)
                                            .textTheme
                                            .subtitle
                                            .color),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return new CircularProgressIndicator();
        }
        else{
          return Container(height: 0, width: 0,);
        }
      },
    );
  }
}
