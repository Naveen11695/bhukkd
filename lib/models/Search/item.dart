import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/NearByRestaurants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class RestaurantData extends StatelessWidget {
  final NearByRestaurants repo;
  final formatter = new NumberFormat("#,###");

  RestaurantData(this.repo);

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.5;
    return Card(
      child: InkWell(
        onTap: () {
          // _launchURL(repo.htmlUrl);
        },
        highlightColor: Colors.lightBlueAccent,
        splashColor: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color.fromRGBO(255, 200, 170, 50),
            ),

            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(left: 3),
                      height: 80,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: repo.thumb != ""
                              ? NetworkImage(repo.thumb)
                              : AssetImage("assets/images/food.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: new Row(
                        children: <Widget>[
                          Icon(Icons.star, color: Colors.deepOrange),
                          Icon(Icons.star, color: Colors.deepOrange),
                          Icon(Icons.star, color: Colors.orange),
                          Icon(Icons.star, color: Colors.orange),
                          Icon(Icons.star, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(3, 10, 3, 10),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        width: c_width,
                        child: new Column(
                          children: <Widget>[
                            new Text(
                              repo.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            new Text(
                              repo.near_by_restaurants_location["locality_verbose"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: new Text(
                                repo.cuisines,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            new Text(
                              " ₹ " + ((repo.average_cost_for_two <999)? repo.average_cost_for_two.toString():formatter.format(repo.average_cost_for_two))+ " for two person (approx.)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  (repo.thumb == "")
                      ? new Image.asset(
                    "assets/images/5.jpg",
                    fit: BoxFit.fill,
                    width: 150,
                    height: 115,
                  )
                      : new Image.network(
                    repo.thumb,
                    fit: BoxFit.fill,
                    width: 150,
                    height: 115,
                  ),
                  Text((repo.name != null) ? repo.name : '-',
                      style: Theme.of(context).textTheme.subhead),
                  Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text(
                        repo.near_by_restaurants_location.toString() != null
                            ? repo.near_by_restaurants_location["address"]
                            : 'No desription',
                        style: Theme.of(context).textTheme.body1),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Text((repo.is_delivery_now != null) ? repo.is_delivery_now : '',
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.caption)),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Colors.deepOrange,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4.0),
                                child: Text(
                                    (repo.average_cost_for_two != null)
                                        ? '${repo.average_cost_for_two} '
                                        : '0 ',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.caption),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Text(
                                (repo.price_range.toString() != null) ? repo.price_range.toString() : '',
                                textAlign: TextAlign.end,
                                style: Theme.of(context).textTheme.caption)),
                      ],
                    ),
                  ),
                ]),
      */

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
