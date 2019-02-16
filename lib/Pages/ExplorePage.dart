import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExplorePage extends StatelessWidget{

  final Opacity = Container(
    color: Color(0xAAAF1222),
  );

  TextStyle Raleway = TextStyle(
    color: Color(0xAAAF1222),
    fontFamily: 'Raleway',
  );

  final background = Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/9.jpeg'),
            fit: BoxFit.cover,
          )
      )
  );

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        title: Text("Search"),
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(color: Colors.deepOrange),
        textTheme: TextTheme(
            title: TextStyle(
              color: Colors.black,
              wordSpacing: 1.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Raleway",
            ),
            subtitle: new TextStyle(
              color: Colors.grey,
              wordSpacing: 0.8,
              fontWeight: FontWeight.w300,
              fontFamily: "roboto",
            )),

        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed:() {print("search");},)
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          background,
          Opacity,
        ],
      ),
    );
  }

}