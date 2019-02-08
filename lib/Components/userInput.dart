import 'package:flutter/material.dart';

class UserInput extends StatefulWidget {
  _UserInput createState() => new _UserInput();
}

class _UserInput extends State<UserInput> {
  String username = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(left:20, right:20, top:60),
      child:new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new TextFormField(
              onSaved: (String value) {
                value.toLowerCase();
                setState(() {
                  username = value;
                });
              },
              autofocus: true,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(10),
                labelText: "Username",
                icon: Icon(Icons.person),
                labelStyle: TextStyle(
                  fontFamily: "roboto",
                  fontWeight: FontWeight.w400,
                  wordSpacing: 1,
                ),
              ),
            ),
            new TextFormField(
              obscureText: true,
              onSaved: (String value) {
                value.toLowerCase();
                setState(() {
                  password = value;
                });
              },
              autofocus: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                contentPadding: EdgeInsets.all(10),
                labelText: "Password",
                labelStyle: TextStyle(
                  fontFamily: "roboto",
                  fontWeight: FontWeight.w400,
                  wordSpacing: 1,
                ),
              ),
            ),
            new MaterialButton(onPressed: (){}, color:Colors.deepOrange,
              child:new Text("Login", style:new TextStyle()),
              shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(25))
              ,)
          ],
        ),
      ),
    );
  }
}
