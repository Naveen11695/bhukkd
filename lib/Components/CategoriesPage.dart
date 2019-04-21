import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import '../api/HttpRequest.dart';
import '../models/Search/SearchRestaurant.dart';

import 'package:http/http.dart' as http;

class CategoriesPage extends StatefulWidget {
  final int id;
  final String name;
  final String photo;
  CategoriesPage({this.id, this.name, this.photo});

  CategoriesPageState createState() => CategoriesPageState();
}

String getSortingValue() {}

class CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: fetchRestByCategoryID(widget.id, sorting: null),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return CustomScrollView(slivers: <Widget>[
                    SliverAppBar(
                      backgroundColor: Colors.deepOrange,
                      floating: true,
                      expandedHeight: 200,
                      centerTitle: true,
                      title: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            widget.name,
                            style: TextStyle(
                                fontSize: 40,
                                fontFamily: "Montserrat",
                                color: Colors.white),
                          )),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.asset(
                          "assets/images/icons/" + widget.photo,
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.medium,
                        ),
                      ),
                    ),
                    SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return Card(
                            child: Column(
                              verticalDirection: VerticalDirection.down,
                              children: <Widget>[
                                snapshot.data.restaurants[index]
                                                .featured_image ==
                                            null ||
                                        snapshot.data.restaurants[index]
                                                .featured_image ==
                                            ""
                                    ? Image.asset("assets/images/default.jpg", fit: BoxFit.cover, height: 125,)
                                    : Image.network(snapshot.data
                                        .restaurants[index].featured_image, fit: BoxFit.fill, height: 125),
                                Text(
                                  snapshot.data.restaurants[index].name,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Roboto"),
                                ),
                                Text(
                                  snapshot.data.restaurants[index].cuisines,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: "Roboto",
                                      color: Colors.deepOrange),
                                )
                              ],
                            ),
                          );
                        }, childCount: snapshot.data.results_found,addRepaintBoundaries: true))
                  ]);
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child:CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrange),));
              }
            }));
  }
}

Future fetchRestByCategoryID(int id, {String sorting}) async {
  getKey();
  if (sorting == null && id != null) {
    http.Response response = await http.get(
        "https://developers.zomato.com/api/v2.1/search?category=${id.toString()}",
        headers: {"Accept": "application/json", "user-key": api_key});

    print(response.body);
    SearchRestraunts searchByCategory =
        SearchRestraunts.fromJson(json.decode(response.body));
    return searchByCategory;
  } else if (sorting != null && id != null) {
    http.Response response = await http.get(
        "https://developers.zomato.com/api/v2.1/search?category=${id.toString()}&sorting=$sorting",
        headers: {"Accept": "application/json", "user-key": api_key});

    print(response.body);
    SearchRestraunts searchByCategory =
        SearchRestraunts.fromJson(json.decode(response.body));
    return searchByCategory;
  }
}
