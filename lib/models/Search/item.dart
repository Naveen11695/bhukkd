import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/NearByRestaurants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantData extends StatelessWidget {
  final NearByRestaurants repo;
  RestaurantData(this.repo);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          onTap: () {
           // _launchURL(repo.htmlUrl);
          },
          highlightColor: Colors.lightBlueAccent,
          splashColor: Colors.red,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(left: 3),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              image: NetworkImage(repo.thumb) !=null ? NetworkImage(repo.thumb) : AssetImage("assets/images/food.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        new SizedBox(
                          width: 10,
                        ),
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              repo.name,
                              style:
                              TextStyle(fontFamily: "", fontSize: 17),
                            ),
                            new Text(
                              repo.near_by_restaurants_location["address"],
                              style:
                              TextStyle(fontFamily: "", fontSize: 9),
                            ),
                            new Row (children: <Widget>[
                              Icon(Icons.star, color:Colors.deepOrange),
                              Icon(Icons.star, color:Colors.deepOrange),
                              Icon(Icons.star, color:Colors.deepOrange),
                              Icon(Icons.star, color:Colors.deepOrange),
                              Icon(Icons.star, color:Colors.deepOrange),
                            ],),


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
                        )
                      ],
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
