import 'package:flutter/material.dart';

class CustomHorizontalScroll extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.only(top:2, left:2, bottom: 2),
      height: 110,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (BuildContext context, int index){
          return new Container(
            margin: EdgeInsets.only(left: 3),
            height: 100,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:Colors.white,
            ),
            child: Row(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(left: 3),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: AssetImage("assets/images/pizza.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                new SizedBox(width: 10,),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text("Food Name", style: TextStyle(
                      fontFamily: "",
                      fontSize: 20
                    ),),
                    new Text("description about food", style: TextStyle(
                      fontFamily: "",
                      fontSize: 10
                    ),),
                    new SizedBox(height: 8,),
                    new Container(
                      height: 1,
                      width: 60,
                      color: Colors.deepOrange,
                    ),
                    new SizedBox(height:8),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}