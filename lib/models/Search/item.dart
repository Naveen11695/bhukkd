import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Components/CustomHorizontalScroll.dart';
import 'package:bhukkd/Components/CustomTransition.dart';
import 'package:bhukkd/Pages/RestaurantDetailPage.dart';
import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/NearByRestaurants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantData extends StatelessWidget {
  final NearByRestaurants repo;

  RestaurantData(this.repo);

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.5;
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              HorizontalTransition(
                  builder: (BuildContext context) => RestaurantDetailPage(
                        productid: repo.id,
                      )));
        },
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Card(
              elevation: 10,
              child: Row(
                children: <Widget>[
                  new Column(
                    children: <Widget>[
                      new Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top:8.0,left: 15.0, right: 8.0),
                          child: ClipOval(child:CachedNetworkImage(
                            imageUrl: repo.thumb,
                            fit: BoxFit.cover,
                            width: 110,
                            height: 100,
                            placeholder: new Image.asset(
                              "assets/images/default.jpg",
                              fit: BoxFit.cover,
                              width: 110,
                              height: 100,
                            ),
                          ),
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 5.0),
                        child: getStarWidgets(
                          repo.user_rating.aggregate_rating,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          width: c_width * 1.1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: new Text(
                                    repo.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                new Text(
                                  repo.near_by_restaurants_location[
                                      "locality_verbose"],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: new Text(
                                    repo.cuisines,
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: new Text(
                                    " ₹ " +
                                        ((repo.average_cost_for_two < 999)
                                            ? repo.average_cost_for_two.toString()
                                            : formatter
                                            .format(repo.average_cost_for_two)) +
                                        " for two person (approx.)",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        new SizedBox(
                          height: 20,
                        ),
                        new Container(
                          height: 1,
                          width: 50,
                          color: Colors.deepOrange,
                        ),
                        new SizedBox(height: 8),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
