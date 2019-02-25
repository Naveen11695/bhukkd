import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:flutter/material.dart';
import '../Pages/otp.dart';

class otpPage extends StatefulWidget {
  _otpPageState createState() => new _otpPageState();
}

class _otpPageState extends State<otpPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new Container(
        child: new Form(child: Otp()),
      ),
    );
  }

  Widget Otp() {
    return new Stack(
      children: <Widget>[
        background,
        Container(
          color: Color.fromRGBO(255, 255, 255, 150),
        ),



        Padding(
          padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
          child: new Text(
            "Find Resturaunts!",
            style: TextStyle(
              fontFamily: 'Raleway-Italic',
              fontWeight: FontWeight.bold,
              fontSize: 50.0,
              color: Colors.deepOrangeAccent,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 170, 20, 0),
          child: new Text(
            "Welcome...",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 40.0,
              decorationColor: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 210, 20, 0),
          child: new Text(
            "Be a bhukkd",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              fontSize: 20.0,
              color: Colors.deepOrangeAccent,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(20, 400, 20, 0),
          child: new TextField(
            keyboardType: TextInputType.phone,
            style: new TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
            decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.deepOrangeAccent)),
                hintText: 'Enter your mobile number',
                helperText: 'Should be 10 digit number',
                labelText: 'Phone no.',
                prefixIcon: const Icon(
                  Icons.phone_android,
                  color: Colors.deepOrangeAccent,
                ),
                prefixText: ' +91 '
            ),
            maxLength: 10,
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(180, 600, 0, 0),
          child: new InkWell(
            child: new Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepOrange),
                  shape: BoxShape.circle, color: Colors.deepOrangeAccent),
              child: new Icon(
                Icons.arrow_forward,
                size: 20.0,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => otp()),
              );
            },
          ),
        ),
      ],
    );
  }
}
