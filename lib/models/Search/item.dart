import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Components/CustomTransition.dart';
import 'package:bhukkd/Pages/RestaurantDetailPage.dart';
import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/NearByRestaurants.dart';
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
                  builder: (BuildContext context) =>
                      RestaurantDetailPage(
                        productid: repo.id,
                      )));
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
                              : AssetImage("assets/images/"+randomPhotoList[random.nextInt(randomPhotoList.length)]),
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
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        width: c_width,
                        child: Padding(
                          padding: const EdgeInsets.only(left:20.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                repo.name,
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              new Text(
                                repo.near_by_restaurants_location["locality_verbose"],
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:8.0),
                                child: new Text(
                                  repo.cuisines,
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:5.0),
                                child: new Text(
                                  " ₹ " + ((repo.average_cost_for_two <999)? repo.average_cost_for_two.toString():formatter.format(repo.average_cost_for_two))+ " for two person (approx.)",
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
}
