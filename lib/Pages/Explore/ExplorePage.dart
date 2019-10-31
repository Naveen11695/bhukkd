import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Pages/Explore/CategoriesPage.dart';
import 'package:bhukkd/Services/HttpRequest.dart';
import 'package:bhukkd/models/Catagories/Catagories.dart';
import 'package:bhukkd/models/GeoCodeInfo/GeoCode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key key}) : super(key: key);

  @override
  _ExplorePage createState() => _ExplorePage();
}


final _fetchCategories = new AsyncMemoizer();

Future asyncfetchCategories() =>
    _fetchCategories.runOnce(() {
      return fetchCategories();
    });

class _ExplorePage extends State<ExplorePage> {
  GeoCode geoCode;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: FutureBuilder(
            future: asyncfetchCategories(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        elevation: 10,
                        floating: false,
                        pinned: true,
                        expandedHeight: 160,
                        backgroundColor: SECONDARY_COLOR_1,
                        title: Text(
                          "Categories",
                          style: TextStyle(
                              fontFamily: FONT_TEXT_PRIMARY,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              wordSpacing: 2.0,
                              letterSpacing: 1.0,
                              color: Colors.white),
                        ),
                      ),
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(10, 0),
                                      blurRadius: 50.0)
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child:
                                    Stack(fit: StackFit.expand, children: [
                                      Material(
                                        elevation: 10,
                                        type: MaterialType.canvas,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (BuildContext
                                                  context) =>
                                                      CategoriesPage(
                                                          id: snapshot.data
                                                                  .categoriesId[
                                                              index],
                                                          name: snapshot.data
                                                                  .categoriesName[
                                                              index],
                                                          photo:
                                                              catagoriesPhotoList[
                                                                  index])));
                                            },
                                            child: Stack(
                                              fit: StackFit.expand,
                                              children: <Widget>[
                                                Hero(
                                                  transitionOnUserGestures:
                                                  true,
                                                  tag: snapshot
                                                      .data.categoriesId[index],
                                                  child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20)),
                                                      child: Image.asset(
                                                        "assets/images/icons/" +
                                                            catagoriesPhotoList[
                                                            index],
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                                Center(
                                                  child: new Text(
                                                    snapshot.data
                                                        .categoriesName[index],
                                                    textAlign: TextAlign.center,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 40,
                                                        fontFamily: "Pacifico"),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ])),
                              ),
                            );
                          },
                          childCount: snapshot.data.categoriesId.length,
                        ),
                      ),
                    ],
                  );
                } else {
                  print("nope");
                  return Container(
                    child: Center(
                      child: new FlareActor(
                        "assets/animations/loading_Untitled.flr",
                        animation: "Untitled",
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                }
              } else {
                print("no connection");
                return Container(
                  child: Center(
                    child: new FlareActor(
                      "assets/animations/loading_Untitled.flr",
                      animation: "Untitled",
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}

Future fetchCategories() async {
  Future categories =
      requestCategories("https://developers.zomato.com/api/v2.1/categories");
  if (categories != null) {
    return categories;
  } else {
    print("error in fetchRestByGeoCode");
  }
}

Future requestCategories(requestUrl) async {
  try {
    getKey();
    var fireStore = Firestore.instance;
    Categories categories;
    bool flag = false;
    DocumentReference snapshot =
        fireStore.collection('categories').document('categories');
    await snapshot.get().then((dataSnapshot) {
      if (dataSnapshot.exists) {
        final response = dataSnapshot.data['categories'];
        categories = parseCategories(response);
      } else {
        flag = true;
      }
    });

    if (flag) {
      print("<requestCatagories>");
      final response = await http.get(Uri.encodeFull(requestUrl), headers: {
        "user-key": api_key,
      });
      if (response.statusCode == 200) {
        saveCategories(response.body);
        categories = parseCategories(response.body);
      } else if (response.statusCode == 403) {
        fetchCategories();
      } else {
        print("Error: ${response.statusCode}");
        print("Error: ${response.body}");
      }
    }
    return categories;
  } catch (e) {
    print("<requestCatagories>" + e.toString());
  }
}

void saveCategories(String data) {
  Firestore.instance
      .collection("categories")
      .document("categories")
      .setData({"categories": data});
}

Categories parseCategories(String responseBody) {
  final parsed = json.decode(responseBody);
  Categories categories = Categories.fromJson(parsed);
  return categories;
}
