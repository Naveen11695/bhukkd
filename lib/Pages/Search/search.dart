import 'dart:async';

import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Pages/Search/api.dart';
import 'package:bhukkd/Pages/Search/item.dart';
import 'package:bhukkd/models/GeoCodeInfo/NearByRestaurants/NearByRestaurants.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchList extends StatefulWidget {
  SearchList({Key key}) : super(key: key);

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

  _SearchState() {
    _searchQuery.addListener(() {
      if (debounceTimer != null) {
        debounceTimer.cancel();
      }
      debounceTimer = Timer(Duration(milliseconds: 100), () {
        if (this.mounted) {
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

    setState(() {
      _isSearching = true;
      _error = null;
      _results = List();
    });

    final repos = await Api.getRepositoriesWithSearchQuery(query);
    if (this._searchQuery.text == query && this.mounted) {
      setState(() {
        _isSearching = false;
        if (repos != null) {
          _results = repos;
        }
      });
    }
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
    if (_isSearching) {
      return Padding(
        padding: const EdgeInsets.all(50.0),
        child: FlareActor(
          "assets/animations/Search Loading.flr",
          fit: BoxFit.scaleDown,
          animation: "default",
        ),
      );
    } else if (_error != null) {
      return CenterTitle(_error);
    } else if (_searchQuery.text.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(50.0),
        child: FlareActor(
          "assets/animations/Search Loading.flr",
          fit: BoxFit.scaleDown,
          animation: "default",
        ),
      );
    } else {
      return ListView.builder(
          itemCount: _results.length,
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
