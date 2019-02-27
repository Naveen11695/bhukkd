/*
import 'package:flutter/material.dart';
import '../Components/CustomComponets.dart';

class Details extends StatefulWidget {
  _DetailsState createState() => new _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Form(child: Details()),
      ),
    );
  }

  Widget Details() {
    return new Stack(
      children: <Widget>[
        background,
        Container(
          color: Color.fromRGBO(255, 255, 255, 150),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
          child: new Text(
            "Enter Your Details",
            style: TextStyle(
              fontFamily: 'Raleway-Italic',
              fontWeight: FontWeight.normal,
              fontSize: 40.0,
              color: Colors.deepOrangeAccent,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 140, 20, 0),
          child: new TextFormField(
            decoration: new InputDecoration(
              hintText: 'Enter your Full Name',
              border: new OutlineInputBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(30.0))),
              filled: true,
              hintStyle: new TextStyle(color: Colors.grey[800]),
              fillColor: Colors.white70,
            ),
            keyboardType: TextInputType.text,
            maxLength: 40,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 220, 20, 0),
          child: new TextFormField(
            decoration: new InputDecoration(
              hintText: 'Email Address',
              border: new OutlineInputBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(30.0))),
              filled: true,
              hintStyle: new TextStyle(color: Colors.grey[800]),
              fillColor: Colors.white70,
            ),
            keyboardType: TextInputType.emailAddress,
            maxLength: 40,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 300, 20, 0),
          child: new TextFormField(
            decoration: new InputDecoration(
              hintText: 'Enter Password',
              border: new OutlineInputBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(30.0))),
              filled: true,
              hintStyle: new TextStyle(color: Colors.grey[800]),
              fillColor: Colors.white70,
            ),
            keyboardType: TextInputType.text,
            maxLength: 40,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 380, 20, 0),
          child: new TextFormField(
            decoration: new InputDecoration(
              hintText: 'Confirm Password',
              border: new OutlineInputBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(30.0))),
              filled: true,
              hintStyle: new TextStyle(color: Colors.grey[800]),
              fillColor: Colors.white70,
            ),
            keyboardType: TextInputType.text,
            maxLength: 40,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 460, 20, 0),
          child: new TextFormField(
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
              filled: true,
              hintStyle: new TextStyle(color: Colors.grey[800]),
              hintText: 'Address',
              fillColor: Colors.white70,
            ),
            keyboardType: TextInputType.text,
            maxLength: 60,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(180, 600, 0, 0),
          child: new InkWell(
            child: new Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrange),
                  shape: BoxShape.circle,
                  color: Colors.deepOrangeAccent),
              child: new Icon(
                Icons.arrow_forward,
                size: 20.0,
                color: Colors.white,
              ),
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
*/
