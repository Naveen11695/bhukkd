import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Components/CustomTransition.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Pages/RestaurantDetailPage/RestaurantDetailPage.dart';
import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/NearByRestaurants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RestaurantData extends StatelessWidget {
  final NearByRestaurants repo;

  const RestaurantData(this.repo);

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
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 15.0, right: 8.0, bottom: 8.0),
                          child: Stack(
                            children: <Widget>[
                              ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: repo.thumb,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                  placeholder: (context, url) =>
                                  new Image.asset(
                                    "assets/images/default.jpg",
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                              ),
                              Container(
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * .105,
                                alignment: Alignment.bottomRight,
                                child: ClipOval(
                                  child: getRating(
                                      repo.user_rating.aggregate_rating
                                          .toString()),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  new SizedBox(
                    width: 10,
                  ),
                  new Container(
                    height: 50,
                    width: 1,
                    color: SECONDARY_COLOR_1,
                  ),
                  new SizedBox(width: 5),
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
                                new Text(
                                  repo.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: FONT_TEXT_EXTRA,
                                    fontSize: 25,
                                    color: TEXT_PRIMARY_COLOR,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                new Text(
                                  repo.cuisines,
                                  style: TextStyle(
                                      fontFamily: FONT_TEXT_PRIMARY,
                                      color: TEXT_SECONDARY_COLOR,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: new Text(
                                    repo.near_by_restaurants_location[
                                    "locality_verbose"],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: FONT_TEXT_SECONDARY,
                                        color: TEXT_SECONDARY_COLOR),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: new Text(
                                    " ₹ " +
                                        ((repo.average_cost_for_two < 999)
                                            ? repo.average_cost_for_two
                                            .toString()
                                            : formatter.format(
                                            repo.average_cost_for_two)) +
                                        " for two person (approx.)",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: FONT_TEXT_SECONDARY,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
