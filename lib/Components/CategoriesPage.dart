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

List<dynamic> copydata = [];

class CategoriesPageState extends State<CategoriesPage> {
  ScrollController _controller= new ScrollController();
  bool isInitializingRequest = false;
  List<dynamic> rests=[];

  @override
  void initState() {
    super.initState();
    callit();
    _controller.addListener(() async{
      if(_controller.position.pixels == _controller.position.maxScrollExtent){
        await fetchRestByCategoryID(widget.id, sorting: null);
      }
    });
  }

  Future callit() async{
    await fetchRestByCategoryID(widget.id, sorting: null);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  int start=0;
  Future fetchRestByCategoryID(int id, {String sorting}) async {
  getKey();
  if(!isInitializingRequest){
    setState(() {
      isInitializingRequest = true; 
    });
  if (sorting == null && id != null) {
    http.Response response = await http.get(
        "https://developers.zomato.com/api/v2.1/search?start=$start&category=${id.toString()}",
        headers: {"Accept": "application/json", "user-key": api_key});
    start += 20;
    SearchRestraunts searchByCategory =
        SearchRestraunts.fromJson(json.decode(response.body));
    copydata = List.from(searchByCategory.restaurants);
    List<dynamic> addRest = new List.generate(20, (index)=>copydata[index]);
    setState(() {
      rests.addAll(addRest);
      isInitializingRequest = false;
    });
  }
  // else if (sorting != null && id != null) {
  //   http.Response response = await http.get(
  //       "https://developers.zomato.com/api/v2.1/search?category=${id.toString()}&sorting=$sorting",
  //       headers: {"Accept": "application/json", "user-key": api_key});

  //   print(response.body);
  //   SearchRestraunts searchByCategory =
  //       SearchRestraunts.fromJson(json.decode(response.body));
  //   return searchByCategory;
  // }}
}
  }


  @override
  Widget build(BuildContext context) {
    if(rests!=null){
    return Scaffold(
        body:CustomScrollView(controller: _controller,slivers: <Widget>[
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
                                rests[index].featured_image ==
                                            null ||
                                        rests[index].featured_image == ""
                                    ? Image.asset("assets/images/default.jpg", fit: BoxFit.cover, height: 125,)
                                    : Image.network(rests[index].featured_image, fit: BoxFit.fill, height: 125),
                                Text(
                                  rests[index].name,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Roboto"),
                                ),
                                Text(
                                  rests[index].cuisines,
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
                        }, childCount: rests.length,addRepaintBoundaries: true))
                  ])
              
            );
    }
    else{
      return Scaffold(body:Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrange),),));
    }
  }
}