import 'package:flutter/material.dart';
import '../models/GeoCodeInfo/GeoCode.dart';
import '../models/Restruant/Restruant.dart';
import '../Pages/RestaurantDetailPage.dart';
import '../Components/CustomTransition.dart';

class HorizontalScroll extends StatelessWidget {
  final index;
  final List nearby_restaurants;
  final List cuisines;
  final List thumb;
  final List restaurant_menu;
  final List photo_Links;
  HorizontalScroll(
      this.index, this.nearby_restaurants, this.cuisines, this.thumb, this.restaurant_menu, this.photo_Links);

  // HorizontalScroll();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Container(
            constraints: BoxConstraints.expand(
              width: 180.0,
            ),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(0.6),
            // ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    HorizontalTransition(
                        builder: (BuildContext context) =>
                            RestaurantDetailPage(productid:index, nearByrestaurants:nearby_restaurants, cuisines:cuisines, thumb:thumb, restaurant_menu: restaurant_menu,restaurant_photos: photo_Links,)));
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
                              child: (thumb[index] == "")
                                  ? new Image.asset(
                                      "assets/images/5.jpg",
                                      fit: BoxFit.cover,
                                      width: 150,
                                      height: 115,
                                    )
                                  : new Image.network(
                                      thumb[index],
                                      fit: BoxFit.cover,
                                      width: 150,
                                      height: 115,
                                    ),
                            ),
                          ],
                        ),
                        new Text(
                          nearby_restaurants[index],
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          style: new TextStyle(shadows: [
                            Shadow(
                                offset: Offset(0.3, 0.1), color: Colors.grey),
                          ]),
                          softWrap: true,
                        ),
                        new Text(
                          cuisines[index],
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              fontSize: 10.0,
                              color:
                                  Theme.of(context).textTheme.subtitle.color),
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
    );
  }
}
