import 'package:flutter/material.dart';
import '../Pages/TrendingPage.dart';

class CustomHorizontalScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        //padding: EdgeInsets.only(top: 2, left: 2, bottom: 2, right: 2),
        height: 150,
        child: FutureBuilder(
          future: getEntityFromLocations(loc_address),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Material(
                      elevation: 10.0,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        height: 100,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.only(left: 3),
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(snapshot.data[index].thumb) !=null ? NetworkImage(snapshot.data[index].thumb) : AssetImage("assets/images/pizza.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              new SizedBox(
                                width: 10,
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    snapshot.data[index].name,
                                    style:
                                        TextStyle(fontFamily: "", fontSize: 17),
                                  ),
                                  new Text(
                                    "description about food",
                                    style:
                                        TextStyle(fontFamily: "", fontSize: 10),
                                  ),
                                  new SizedBox(
                                    height: 8,
                                  ),
                                  new Container(
                                    height: 1,
                                    width: 60,
                                    color: Colors.deepOrange,
                                  ),
                                  new SizedBox(height: 8),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }
            else{
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
