import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:flutter/material.dart';
import '../Pages/otp.dart';

class otpPage extends StatefulWidget {
  _otpPageState createState() => new _otpPageState();
}

class _otpPageState extends State<otpPage> {

  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          background,
          Container(
            height: MediaQuery.of(context).size.height,
            color: Color.fromRGBO(0, 0, 0, 245),
          ),
          ListView(children: <Widget>[new Form(child: Otp()),],),
        ],
      ),
    );
  }

  Widget Otp() {
    return new Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
          child: new Text(
            "Find Resturaunts!",
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              fontSize: 50.0,
              color: Color.fromRGBO(249, 129, 42, 1),
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
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
              color: Color.fromRGBO(249, 129, 42, 1),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 400, 20, 0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                
              ),
              child: new TextField(
                keyboardType: TextInputType.phone,

                style: new TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w500, color: Color.fromRGBO(249, 129, 42, 1)),
                decoration: new InputDecoration(
                  fillColor: Color.fromRGBO(249, 129, 42, 1),
                    focusedBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Color.fromRGBO(249, 129, 42, 1)),
                        borderRadius: BorderRadius.circular(30.0)),
                    hintText: 'Enter your mobile number',
                    helperText: 'Should be 10 digit number',
                    labelText: 'Phone no.',
                    labelStyle: new TextStyle(
                      color: Color.fromRGBO(249, 129, 42, 1),
                    ),
                    prefixIcon: const Icon(
                      Icons.phone_android,
                      color: Color.fromRGBO(249, 129, 42, 1),
                    ),
                    prefixText: ' +91 '),
                maxLength: 10,
              ),
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
                  color: Color.fromRGBO(249, 129, 42, 1)),
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

  smsCodeDialog(BuildContext context) {
    Text("Your Varification code is");
  }
}
