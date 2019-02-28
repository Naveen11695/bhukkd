
import 'package:bhukkd/Components/CustomCardState.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Pages/ExplorePage.dart';
import 'package:bhukkd/Pages/TrendingPage.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    /*var nearList =
    Search_resturaunt_name.where((p) => p.toLowerCase().startsWith(query)).toList();*/
    List cards = new List.generate(
        result.isEmpty ? Search_resturaunt_name.length : result.length,
            (i) => new CustomCard((result.isEmpty ? Search_resturaunt_name[i] : result[i]),Search_resturant_location[i]))
        .toList();
    return Stack(
      children: <Widget>[
        splash_background,
        opacity,
        new GridView(
          children: cards,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300.0,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            childAspectRatio: 1.0,
          ),
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    update();
    final suggestionList = query.isEmpty
        ? Search_recentResturaunt
        : Search_resturaunt_name.where((p) => p.toLowerCase().contains(query)).toList();
    result.clear();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          print("here");
          print("query:" + suggestionList[index]);
          result.add(suggestionList[index]);
          showResults(context);
        },
        leading: Icon(Icons.fastfood),
        title: RichText(
            text: TextSpan(
                text: suggestionList[index],
                style: TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16),
                children: [
                  TextSpan(
                      text: "\n"+((query.length)>3?Search_resturant_location[index]:""),
                      style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 11)),
                ])),

      ),
      itemCount: suggestionList.length,
    );
  }

  void update() {
      print("query" + query);
      showSuggestion(query);
    }
}