import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/GeoCodeInfo/GeoCode.dart';
import '../models/Restruant/Restruant.dart';
import '../Pages/RestaurantDetailPage.dart';
import '../Components/CustomTransition.dart';
import '../api/HttpRequest.dart';
import 'package:bhukkd/flarecode/flare_actor.dart';

class HorizontalScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchRestByGeoCode(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == "error") {
            return Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        color: Colors.grey.shade100,
                        // height: 100,
                        width: 180,
                        child: new Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: new FlareActor(
                            "assets/animations/near_by_rest_loading.flr",
                            animation: "loading",
                            fit: BoxFit.cover,
                          ),
                        ));
                  }),
            );
          } else if (snapshot.data != null) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.nearby_restaurants.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(7),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(7)),
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
                                            productid: snapshot.data
                                                .nearby_restaurants[index].id,
                                          )));
                            },
                            child: new Container(
                              child: Card(
                                margin:
                                    EdgeInsets.only(left: 5, top: 2, bottom: 2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: (snapshot
                                                          .data
                                                          .nearby_restaurants[
                                                              index]
                                                          .thumb ==
                                                      "")
                                                  ? new Image.asset(
                                                      "assets/images/5.jpg",
                                                      fit: BoxFit.cover,
                                                      width: 150,
                                                      height: 110,
                                                    )
                                                  : CachedNetworkImage(
                                                      imageUrl: snapshot
                                                          .data
                                                          .nearby_restaurants[
                                                              index]
                                                          .thumb,
                                                      fit: BoxFit.cover,
                                                      width: 150,
                                                      height: 110,
                                                      placeholder: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(40.0),
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                      errorWidget:
                                                          Icon(Icons.error),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: new Text(
                                          snapshot.data
                                              .nearby_restaurants[index].name,
                                          textDirection: TextDirection.ltr,
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(
                                              fontFamily: "Raleway",
                                              shadows: [
                                                Shadow(
                                                    offset: Offset(0.3, 0.1),
                                                    color: Colors.grey),
                                              ]),
                                          softWrap: true,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: new Text(
                                          snapshot
                                              .data
                                              .nearby_restaurants[index]
                                              .cuisines,
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(
                                              fontSize: 10.0,
                                              color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ));
                });
          }
        } else {
          return Container(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      color: Colors.grey.shade100,
                      // height: 100,
                      width: 180,
                      child: new Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: new FlareActor(
                          "assets/animations/near_by_rest_loading.flr",
                          animation: "loading",
                          fit: BoxFit.cover,
                        ),
                      ));
                }),
          );
        }
      },
    );
  }
}
