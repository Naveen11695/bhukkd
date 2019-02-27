import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatelessWidget {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print("back button pressed");
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: 
      Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 256,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: new Text(
                "Restraunt name",
                textAlign: TextAlign.end,
                style: new TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    wordSpacing: 1),
              ),
              centerTitle: false,
              background: Hero(
                tag: i++, // unique id
                child: FadeInImage(
                  image: AssetImage("assets/images/5.jpg"),
                  height: 300,
                  fadeInDuration: const Duration(seconds: 1),
                  placeholder: AssetImage("assets/images/pizza.jpg"),
                  fit: BoxFit.cover,
                  fadeOutDuration: const Duration(seconds: 1),
                  fadeInCurve: Curves.fastOutSlowIn,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([]),
          )
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.restaurant),
        tooltip: "Reserve a seat",
        mini: true,
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(249, 129, 42, 1),
      ),
    ));
  }
}
