import 'dart:async';
import 'dart:convert';

import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Pages/TrendingPage.dart';
import 'package:bhukkd/api/HttpRequest.dart';
import 'package:bhukkd/models/Catagories/Catagories.dart';
import 'package:bhukkd/models/GeoCodeInfo/GeoCode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//.................................data to be render..........................//

//.................................data to be render..........................//

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePage createState() => _ExplorePage();
}

class _ExplorePage extends State<ExplorePage> {
  GeoCode geoCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        color: Colors.white,
        child: FutureBuilder(
            future: fetchCategories(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  /*print(snapshot.data.categoriesId);*/
                  return CustomScrollView(
                    slivers: <Widget>[
                      new SliverAppBar(
                        backgroundColor: Color.fromRGBO(255, 120, 0, 30),
                        expandedHeight: 100.0,
                        pinned: true,
                        title: Padding(
                          padding: const EdgeInsets.only(top:25.0),
                          child: new Text(
                            "Explorer",
                            textAlign: TextAlign.center,
                            style: Raleway.copyWith(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SliverGrid(
                        gridDelegate:
                            SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          childAspectRatio: 1.0,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 0, 240),
                                      borderRadius: BorderRadius.circular(100.0),
                                      border: Border.all(
                                        color: Colors.black,
                                      )
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              child: Center(
                                                child: new Image.asset(
                                                  "assets/images/icons/"+catagoriesPhotoList[index],
                                                  fit: BoxFit.scaleDown,
                                                  height: 130,
                                                  width: 50,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: new Text(
                                            snapshot.data.categoriesName[index],
                                            textAlign: TextAlign.center,
                                            style: Raleway.copyWith(
                                                fontFamily: "Montserrat",
                                                fontSize: 20.0,
                                                color: Colors.deepOrange,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
                  return Center(child: CircularProgressIndicator());
                }
              } else {
                print("no connection");
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}



Future fetchCategories() async{
  Future categories=requestCatagories(
      "https://developers.zomato.com/api/v2.1/categories");
  if(categories !=null){
    return categories;
  }
  else{
    print("error in fetchRestByGeoCode");
  }
}

Future<Categories> requestCatagories(requestUrl) async {
  getKey();
  final response = await http.get(Uri.encodeFull(requestUrl), headers: {
    "user-key": api_key,
  });
  if (response.statusCode == 200) {
     /* print(response.body);*/
      Categories categories = parseCategories(response.body);

    return categories;
  } else if (response.statusCode == 403) {
    fetchCategories();
  } else {
    print("Error: ${response.statusCode}");
    print("Error: ${response.body}");
  }
}

Categories parseCategories(String responseBody) {
  final parsed = json.decode(responseBody);
  Categories categories = Categories.fromJson(parsed);
  return categories;
}