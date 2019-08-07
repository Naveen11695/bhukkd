import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bhukkd/Components/CustomTransition.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Pages/RestaurantDetailPage.dart';
import 'package:bhukkd/Pages/Search/SearchRestaurant.dart';
import 'package:bhukkd/Pages/TrendingPage/Componets/HorizontalScroll.dart';
import 'package:bhukkd/Services/HttpRequest.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class CategoriesPage extends StatefulWidget {
  final int id;
  final String name;
  final String photo;

  CategoriesPage({this.id, this.name, this.photo});

  CategoriesPageState createState() => CategoriesPageState();
}

String getSortingValue() {}

List<dynamic> copydata = [];

class CategoriesPageState extends State<CategoriesPage> {
  ScrollController _controller = new ScrollController();
  bool isInitializingRequest = false;
  List<dynamic> rests = [];

  var _status = "Active";

  @override
  void initState() {
    super.initState();
    callit();
    _controller.addListener(() async {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (_status.compareTo("Active") == 0) {
          Toast.show(
              "loading! more results", context, duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM);
          await fetchRestByCategoryID(widget.id, widget.name.toLowerCase());
        }
        else {
          Toast.show(
              "Sorry! no more results", context, duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM);
        }
      }
    });
  }

  Future callit() async {
    await Future.delayed(Duration(seconds: 15), () =>
        fetchRestByCategoryID(widget.id, widget.name.toLowerCase(),
            sorting: null));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  int start = 0;

  @override
  Widget build(BuildContext context) {
    if (rests.toString().compareTo("[]") != 0) {
      return Scaffold(
          body: CustomScrollView(controller: _controller, slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              backgroundColor: SECONDARY_COLOR_1,
              floating: true,
              expandedHeight: 200,
              centerTitle: true,
              title: Text(
                widget.name,
                style: TextStyle(
                    fontSize: 35, fontFamily: "Pacifico", color: Colors.white),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/images/icons/" + widget.photo,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.medium,
                ),
              ),
            ),
            SliverGrid(
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          HorizontalTransition(
                              builder: (BuildContext context) =>
                                  RestaurantDetailPage(
                                    productid: rests[index].id,
                                  )));
                    },
                    child: Card(
                      elevation: 2,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: rests[index].featured_image == null ||
                                rests[index].featured_image == ""
                                ? Image.asset(
                              "assets/images/default.jpg",
                              fit: BoxFit.cover,
                              height:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.15,
                            )
                                : CachedNetworkImage(
                              imageUrl: rests[index].featured_image,
                              fit: BoxFit.fill,
                              height:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.15,
                              placeholder: (context, url) =>
                                  Container(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.15,
                                    child: FlareActor(
                                      "assets/animations/loading_Untitled.flr",
                                      animation: "Untitled",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          Text(
                            rests[index].name,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: FONT_TEXT_PRIMARY,
                                color: TEXT_PRIMARY_COLOR),
                          ),
                          Text(
                            rests[index].cuisines,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                fontFamily: FONT_TEXT_SECONDARY,
                                color: TEXT_SECONDARY_COLOR),
                          )
                        ],
                      ),
                    ),
                  );
                }, childCount: rests.length, addRepaintBoundaries: true))
          ]));
    } else {
      return Scaffold(
          body: CustomScrollView(controller: _controller, slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              backgroundColor: SECONDARY_COLOR_1,
              floating: true,
              expandedHeight: 200,
              centerTitle: true,
              title: Text(
                widget.name,
                style: TextStyle(
                    fontSize: 35, fontFamily: "Pacifico", color: Colors.white),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/images/icons/" + widget.photo,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.medium,
                ),
              ),
            ),
            SliverGrid(
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
                  return Card(
                    elevation: 2,
                    child: Center(
                      child: new FlareActor(
                        "assets/animations/loading_Untitled.flr",
                        animation: "Untitled",
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                }, childCount: 6, addRepaintBoundaries: true))
          ]));
    }
  }

  fetchRestByCategoryID(int id, String q, {String sorting}) async {
    try {
      String city_id;
      await getNearByRestaurants().then((res) {
        city_id = res[0].near_by_restaurants_location["city_id"].toString();
      });
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("<fetchRestByCollectionID>");
        print('connected');
        Iterable<dynamic> key =
            (await parseJsonFromAssets('assets/api/config.json')).values;
        var apiKey = key.elementAt(0);

        if (!isInitializingRequest) {
          setState(() {
            isInitializingRequest = true;
          });
          if (sorting == null && id != null) {
            http.Response response = await http.get(
                "https://developers.zomato.com/api/v2.1/search?entity_id=$city_id&entity_type=city&q=$q&order=$sorting&start=$start",
                headers: {"Accept": "application/json", "user-key": apiKey});
            start += 20;
            SearchRestraunts searchByCategory =
            SearchRestraunts.fromJson(json.decode(response.body));
            copydata = List.from(searchByCategory.restaurants);
            List<dynamic> addRest = [];
            if (copydata.length == 20)
              addRest = new List.generate(20, (index) => copydata[index]);
            else {
              _status = "finished";
              Toast.show("Sorry! no more results", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            }
            try {
              setState(() {
                rests.addAll(addRest);
                isInitializingRequest = false;
              });
            }
            catch (e) {
              print("exception <categories>: " + e.toString());
            }
          }
        }
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }
}
