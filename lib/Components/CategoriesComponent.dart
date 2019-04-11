import 'package:flutter/material.dart';

class CategoriesComponent extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new InkWell(
            onTap: (){},
            child:new Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.4,
              child: new Image.asset("assets/images/Breakfast.png")
            ),),
            new InkWell(
              onTap: (){},
              child:new Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.4,
                child: new Image.asset("assets/images/Breakfast.png")
            )),
          ],
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
        new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new InkWell(
            onTap: (){},
            child:new Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.4,
              child: new Image.asset("assets/images/Breakfast.png")
            ),),
            new InkWell(
              onTap: (){},
              child:new Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.4,
                child: new Image.asset("assets/images/Breakfast.png")
            )),
          ],
        ),
      ],
    );
  }
}