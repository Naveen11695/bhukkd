import 'package:bhukkd/flarecode/flare_actor.dart';
import 'package:flutter/material.dart';

class WagonPage extends StatefulWidget{
  @override
  _WagonPageState createState() => new _WagonPageState();
}
class _WagonPageState extends State<WagonPage>{
  @override
  Widget build(BuildContext context){
    return Center(
      child: Container(
        child: FlareActor("assets/animations/Add to cart icon.flr", fit:BoxFit.scaleDown,animation: "Untitled",),
      ),
    );
  }
}