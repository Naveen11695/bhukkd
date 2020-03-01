import 'dart:async';

import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Pages/Explore/CategoriesPage.dart';
import 'package:bhukkd/Pages/Explore/ExplorePage.dart';
import 'package:bhukkd/Pages/Search/api.dart';
import 'package:bhukkd/Pages/Search/item.dart';
import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/NearByRestaurants.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchList extends StatefulWidget {
  const SearchList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<SearchList> {
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  bool _isSearching = false;
  String _error;
  List<NearByRestaurants> _results;

  Timer debounceTimer;

  Widget waitingWidget = Stack(
    children: <Widget>[
//      FlutterMap(
//        options: new MapOptions(
//          center: new LatLng(latitude, longitude),
//          zoom: 14.0,
//        ),
//        layers: [
//          new TileLayerOptions(
//            urlTemplate: "https://api.tiles.mapbox.com/v4/"
//                "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
//            additionalOptions: {
//              'accessToken': map_api_key,
//              'id': 'mapbox.streets',
//            },
//          ),
//        ],
//      ),
      Scaffold(
        body: Container(
          color: Colors.white,
          child: FutureBuilder(
              future: asyncfetchCategories(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Stack(
                      children: <Widget>[
                        CustomScrollView(
                          physics: BouncingScrollPhysics(),
                          slivers: <Widget>[
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 0.0),
                              ),
                            ),
                            SliverGrid(
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 1),
                              delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                  return Container(
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Material(
                                                elevation: 10,
                                                type: MaterialType.canvas,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                child: InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  BuildContext
                                                                  context) =>
                                                                  CategoriesPage(
                                                                      id: snapshot
                                                                          .data
                                                                          .categoriesId[
                                                                      index],
                                                                      name: snapshot
                                                                          .data
                                                                          .categoriesName[
                                                                      index],
                                                                      photo: catagoriesPhotoList[
                                                                      index])));
                                                    },
                                                    child: Stack(
                                                      fit: StackFit.expand,
                                                      children: <Widget>[
                                                        Hero(
                                                          transitionOnUserGestures:
                                                          true,
                                                          tag: snapshot.data
                                                              .categoriesId[
                                                          index],
                                                          child: ClipRRect(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                  .circular(
                                                                  20)),
                                                              child:
                                                              Image.asset(
                                                                "assets/images/icons/" +
                                                                    catagoriesPhotoList[
                                                                    index],
                                                                fit: BoxFit
                                                                    .cover,
                                                              )),
                                                        ),
                                                        Center(
                                                          child: new Text(
                                                            snapshot.data
                                                                .categoriesName[
                                                            index],
                                                            textAlign: TextAlign
                                                                .center,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 40,
                                                                fontFamily:
                                                                "Pacifico"),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ])),
                                  );
                                },
                                childCount: snapshot.data.categoriesId.length,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
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
      ),
//      Container(
//        height: double.infinity,
//        width: double.infinity,
//        color: Color.fromRGBO(44, 57, 73, 50),
//      ),
//      Padding(
//        padding: const EdgeInsets.all(50.0),
//        child: FlareActor(
//          "assets/animations/searching.flr",
//          fit: BoxFit.scaleDown,
//          animation: "Untitled",
//        ),
//      ),
    ],
  );

  _SearchState() {
    _searchQuery.addListener(() {
      if (debounceTimer != null) {
        debounceTimer.cancel();
      }
      debounceTimer = Timer(Duration(milliseconds: 10), () {
        if (_searchQuery.text.length == 0) {
          setState(() {

          });
        } else if (this.mounted &&
            _searchQuery.text.length > 0 &&
            _searchQuery.text[_searchQuery.text.length - 1].compareTo(" ") !=
                0) {
          performSearch(_searchQuery.text);
        }
      });
    });
  }

  void performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _error = null;
        _results = List();
      });
      return;
    }

    _isSearching = true;
    _error = null;
    _results = List();

    await getRepositoriesWithSearchQuery(query.trim()).then((repos) async {
      if (this._searchQuery.text == query && this.mounted) {
        setState(() {
          _isSearching = false;
          if (repos != null) {
            _results = repos;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: key,
        appBar: AppBar(
          elevation: 10.0,
          backgroundColor: SECONDARY_COLOR_1,
          centerTitle: true,
          title: TextField(
            autofocus: true,
            controller: _searchQuery,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: FONT_TEXT_PRIMARY,
                letterSpacing: 0.5,
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Padding(
                    padding: EdgeInsetsDirectional.only(end: 25.0),
                    child: Icon(
                      FontAwesomeIcons.search,
                      color: Colors.white,
                    )),
                hintText: "Search for restaurants, dishes..",
                hintStyle: TextStyle(color: Colors.white70)),
          ),
        ),
        body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    if (_searchQuery.text.isEmpty) {
      return waitingWidget;
    }
    else if (_isSearching) {
      return waitingWidget;
    } else if (_error != null) {
      return Container(
        child: Center(
          child: Image.asset(
            "assets/images/not_found.gif",
            fit: BoxFit.fill,
          ),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: _results.length,
          // ignore: missing_return
          itemBuilder: (BuildContext context, int index) {
            return RestaurantData(_results[index]);
          });
    }
  }
}

class CenterTitle extends StatelessWidget {
  final String title;

  CenterTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        alignment: Alignment.center,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline,
          textAlign: TextAlign.center,
        ));
  }
}
