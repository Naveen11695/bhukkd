import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:flutter/material.dart';
import '../Pages/Details.dart';
import '../Components/CustomComponets.dart';
class otp extends StatefulWidget {
  _otpState createState() => new _otpState();
}

class _otpState extends State<otp> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: getOtp(),
    );
  }

  Widget getOtp() {
    return new Stack(
      children: <Widget>[
        background,
        Container(
          color: Color.fromRGBO(255, 255, 255, 150),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
          child: new Text(
            "Verify Your Number",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 60.0,
              color: Colors.deepOrangeAccent,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 300, 20, 0),
          child: new Text(
            "Enter the otp sent to your number",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.normal,
              fontSize: 30.0,
              decorationColor: Colors.white30,
            ),
          ),
        ),
        /*new TextFormField(
          decoration: new InputDecoration(
              hintText: 'Enter otp',
              border: new OutlineInputBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(10.0))
              ),
          ),
          keyboardType: TextInputType.number,
          maxLength: 6,
        ),*/
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 400, 20, 0),
          child :new TextField(
            keyboardType: TextInputType.phone,
            textAlign: TextAlign.center,
            decoration: new InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(30.0),
                  ),
                ),
                filled: true,
                hintStyle: new TextStyle(color: Colors.grey[800]),
                hintText: "Enter OTP",
                fillColor: Colors.white70,
              labelText: 'OTP',
              prefixIcon: const Icon(
                Icons.format_list_numbered,
                color: Colors.deepOrangeAccent,
              ),
            ),
            maxLength: 6,
          ),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(180, 600, 20, 0),
          child: new InkWell(
            child: new Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
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
                MaterialPageRoute(builder: (context) => Details()),
              );
            },
          ),
        ),
        /*new RaisedButton(
            padding: new EdgeInsets.fromLTRB(80.0, 10.0, 80.0, 10.0),
            color: Colors.deepOrangeAccent,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0)),
            child: new Text(
              "Resend",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 30.0,
              ),
            ),
            onPressed: () {}),*/
      ],
    );
  }
}
