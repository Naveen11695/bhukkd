import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import '../api/HttpRequest.dart';

import 'package:http/http.dart' as http;

class CategoriesPage extends StatelessWidget{

  final int id;
  CategoriesPage({this.id});

  String getSortingValue(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FutureBuilder(
      future: fetchRestByCategoryID(id, sorting: null),
      builder: (BuildContext context, AsyncSnapshot snapshot){
          return Center(
            child: new Text("category"),
          );
      },
    ));
  }
}


Future fetchRestByCategoryID(int id, {String sorting}) async{
  getKey();
  if(sorting==null && id!=null){
    http.Response response = await http.get("https://developers.zomato.com/api/v2.1/search?category=${id.toString()}", headers: {
    "Accept": "application/json",
    "user-key": api_key
  });

  print(response.body);
  json.decode(response.body);

  }
}