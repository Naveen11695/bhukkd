import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/flarecode/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/GeoCodeInfo/GeoCode.dart';
import '../api/HttpRequest.dart';
import '../models/Restruant/Restruant.dart';
import 'package:bhukkd/flarecode/flare_actor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/Reviews/Reviews.dart';

/**
 * Errors due to design fault
 * fix it, dont pass lists in constructor
 */

class RestaurantDetailPage extends StatefulWidget {
  final productid;

  RestaurantDetailPage({this.productid});

  RestaurantDetailPageState createState() => new RestaurantDetailPageState();
}

// if we use scoped model it would be better as we can access all the data with the dot operator
// but scopedmodel is giving null error as we have passed data into lists.
class RestaurantDetailPageState extends State<RestaurantDetailPage> {
  void initState() {
    super.initState();
  }

  int i = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          print("back button pressed");
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
          body: new FutureBuilder(
            future: fetchRestaurant(widget.productid.toString()),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        backgroundColor: Colors.deepOrange,
                        expandedHeight: 175,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          centerTitle: false,
                          background: Hero(
                            tag: i++, // unique id
                            child: FadeInImage(
                              image: NetworkImage(
                                  snapshot.data.restruant_Feature_image),
                              height: 300,
                              fadeInDuration: const Duration(seconds: 1),
                              placeholder:
                                  AssetImage("assets/images/default.jpg"),
                              fit: BoxFit.cover,
                              fadeOutDuration: const Duration(seconds: 1),
                              fadeInCurve: Curves.fastOutSlowIn,
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: new Text(
                              snapshot.data.restruant_Name,
                              textDirection: TextDirection.ltr,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: new TextStyle(
                                  fontFamily: "Montserrat-Bold",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                  wordSpacing: 1),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10, bottom: 5),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    snapshot.data.restruant_Location
                                        .locality_verbose,
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width
                                        .remainder(20),
                                  ),
                                  DecoratedBox(
                                    child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                            snapshot.data.restruant_User_rating
                                                .aggregate_rating,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ))),
                                    decoration: BoxDecoration(
                                      color: Colors.deepOrange,
                                      borderRadius: BorderRadius.circular(25),
                                      shape: BoxShape.rectangle,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width
                                        .remainder(20),
                                  ),
                                  snapshot.data.restruant_Is_delivery_now == 0
                                      ? Text(
                                          "Closed",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: "Montserrat-Bold",
                                            fontSize: 18,
                                            fontStyle: FontStyle.normal,
                                            letterSpacing: 1.1,
                                          ),
                                        )
                                      : Text(
                                          "Open",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontFamily: "Montserrat-Bold",
                                            fontSize: 18,
                                            fontStyle: FontStyle.normal,
                                            letterSpacing: 1.1,
                                          ),
                                        ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(children: [
                                Text(
                                  snapshot.data.restruant_Cuisines,
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ])),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(children: [
                              Text(
                                "Average Cost for Two",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  snapshot.data.currency +
                                      ((snapshot.data
                                                  .restruant_Avg_cost_for_two <
                                              999)
                                          ? snapshot
                                              .data.restruant_Avg_cost_for_two
                                              .toString()
                                          : formatter.format(snapshot.data
                                              .restruant_Avg_cost_for_two)),
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontFamily: "Roboto",
                                      fontSize: 15.0),
                                ),
                              )
                            ]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Photos",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  letterSpacing: 1),
                            ),
                          ),
                          Container(
                            height: 200.0,
                            width: MediaQuery.of(context).size.width * 0.92,
                            padding: EdgeInsets.only(top: 20),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: FutureBuilder(
                                  future: fetchPhotos(
                                      snapshot.data.restruant_Photo_url),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapShot) {
                                    if (snapShot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapShot.data != null) {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapShot.data.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                              child: new Material(
                                                elevation: 10.0,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 5,
                                                      bottom: 5),
                                                  child: new Image.network(
                                                    snapShot.data[index],
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    } else if (snapShot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    }
                                  }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Menu",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  letterSpacing: 1),
                            ),
                          ),
                          Container(
                            height: 200.0,
                            width: MediaQuery.of(context).size.width * 0.92,
                            padding: EdgeInsets.only(top: 20),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: FutureBuilder(
                                  future:
                                      fetchMenu(snapshot.data.restruant_Menu),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapShot) {
                                    if (snapShot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapShot.data != null) {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapShot.data.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            Scaffold(
                                                                body: PageView(
                                                              controller:
                                                                  PageController(
                                                                      initialPage:
                                                                          index,
                                                                      keepPage:
                                                                          true,
                                                                      viewportFraction:
                                                                          1),
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              children: <
                                                                  Widget>[
                                                                new Image
                                                                        .network(
                                                                    snapShot.data[
                                                                        index],
                                                                    fit: BoxFit
                                                                        .fitWidth)
                                                              ],
                                                            ))));
                                              },
                                              child: new Material(
                                                elevation: 10.0,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 5,
                                                      bottom: 5),
                                                  child: new Image.network(
                                                    snapShot.data[index],
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    } else if (snapShot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    }
                                  }),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Details",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  letterSpacing: 1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10),
                            child: Row(
                              children: <Widget>[
                                Text("Address",
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        color: Colors.black87)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 6),
                            child: Row(children: [
                              Text(
                                snapshot.data.restruant_Location.address,
                                overflow: TextOverflow.clip,
                              ),
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:10, left: 10),
                            child: Text(
                              "Reviews",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  letterSpacing: 1),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FutureBuilder(
                                  future: fetchReviews(widget.productid),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapShot) {
                                    if (snapShot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapShot.data != null) {
                                        return Container(
                                            height: 500,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.92,
                                            child: ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: 5,
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Divider(
                                                  color: Colors.black54,
                                                );
                                              },
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return ListTile(
                                                  leading: CircleAvatar(
                                                    maxRadius: 28,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      snapShot
                                                          .data
                                                          .user_reviews[index]
                                                          .review
                                                          .user
                                                          .profile_image,
                                                    ),
                                                  ),
                                                  title: Column(crossAxisAlignment: CrossAxisAlignment.start,children:[
                                                    Text(snapShot.data.user_reviews[index]
                                            .review.user.name, textAlign: TextAlign.justify,style: TextStyle(
                                              color: Colors.black, fontFamily: "Roboto",
                                              fontWeight: FontWeight.w600, fontSize: 18,
                                            ),),
                                                    Text(snapShot
                                                      .data
                                                      .user_reviews[index]
                                                      .review
                                                      .review_text, style: TextStyle(
                                                        color: Colors.black54, fontFamily: "Roboto",
                                              fontWeight: FontWeight.w400, fontSize: 14
                                                      ),)]),
                                                  trailing: Text(
                                                    snapShot
                                                        .data
                                                        .user_reviews[index]
                                                        .review
                                                        .rating
                                                        .toString(),
                                                  ),
                                                );
                                              },
                                            ));
                                      }
                                    } else if (snapShot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    }
                                  })),
                        ]),
                      )
                    ],
                  );
                }
              } else {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return FlareActor(
                    "assets/animations/restaurant_details.flr",
                    animation: "image_loading",
                    fit: BoxFit.fill,
                  );
                }
              }
            },
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
  }
}

Future fetchReviews(String rest_id) async {
  getKey();
  http.Response response = await http.get(
      Uri.encodeFull(
          "https://developers.zomato.com/api/v2.1/reviews?res_id=${rest_id.toString()}"),
      headers: {"Accept": 'json/application', "user_key": api_key});
  Reviews r = Reviews.fromJson(json.decode(response.body));
  print(r.user_reviews[0].review.comments_count);
  print(r.user_reviews[0].review.user);
  print(r.user_reviews[0].review.user.name);
  return r;
}
