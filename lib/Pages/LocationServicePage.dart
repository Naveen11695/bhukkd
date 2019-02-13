import 'package:flutter/material.dart';
import '../api/LocationRequest.dart';
import '../models/SharedPreferance/SharedPreference.dart';
import '../Pages/HomePage.dart';

class LocationServicePage extends StatefulWidget{
  @override
  _LocationServicePage createState()=> new _LocationServicePage();
}

class _LocationServicePage extends State<LocationServicePage>{

  void _saveLocation(){
    getCurrentPosition().then((position){
        StoreUserLocation.location=position;
        StoreUserLocation.setLocation();
    });

    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context)=>new HomePage()));
  }

  @override
  Widget build(BuildContext context){
      return Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: new Center(child:
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("Please Enable Your Location", style: new TextStyle(
                fontSize: 30,
              ),),
              new SizedBox(height: 50,),
              new MaterialButton(
                onPressed: _saveLocation,
                elevation: 3,
                color: Colors.deepOrange,
                shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                child: new Text("Enable", style: new TextStyle(
                  fontSize: 20,
                  fontWeight:FontWeight.normal,
                  color: Colors.white
                ),
                ),),
            ],
        ),
      ),);
  }
}