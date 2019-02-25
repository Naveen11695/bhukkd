import 'package:bhukkd/Components/CustomCardState.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Components/DataSearch.dart';
import 'package:bhukkd/models/GeoCodeInfo/GeoCode.dart';
import 'package:flutter/material.dart';

//.................................data to be render..........................//

final resturaunt = [
  "Barcos",
  "foodHub",
];
final resturaunt_thumb = [];

final recentResturaunt = [
  "Barcos",
  "foodHub",
];

final result = [];

//.................................data to be render..........................//

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePage createState() => _ExplorePage();
}

class _ExplorePage extends State<ExplorePage> {
  List cards =
      new List.generate(result.length, (i) => new CustomCard(result[i]))
          .toList();
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
      body: Stack(
        children: <Widget>[
          explore_background,
          opacity,
          new CustomScrollView(
            slivers: <Widget>[
              new SliverAppBar(
                backgroundColor: Color.fromRGBO(255, 255, 255, 50),
                expandedHeight: 200.0,
                pinned: true,
                floating: true,
                title: new Text(
                  "Explorer",
                  textAlign: TextAlign.center,
                  style: Raleway.copyWith(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                flexibleSpace: new FlexibleSpaceBar(
                  title: new Text(
                    "                     Local cuisine, Indian, Asian,\nVegetarian Friendly",
                    textAlign: TextAlign.end,
                    style: Raleway.copyWith(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: new Image.asset(
                                      "assets/images/9.jpeg",
                                      fit: BoxFit.fill,
                                      height: 150,
                                      width: 50,
                                    ),
                                  ),
                                ],
                              ),
                              new Text(
                                "Resturaunt $index",
                                style: Raleway.copyWith(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              new Text(
                                "Description",
                                style: new TextStyle(
                                    fontSize: 10.0,
                                    color: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .color),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: 25,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 20.0,
        backgroundColor: Color.fromRGBO(255, 255, 255, 50),
        label: Text(
          "Search",
          style: Raleway.copyWith(fontSize: 20.0),
        ),
        icon: Icon(
          Icons.search,
          color: Color(0xAAAF2222),
        ),
        onPressed: () {
          showSearch(context: context, delegate: DataSearch());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
