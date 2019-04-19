import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:flutter/material.dart';
import '../Components/CustomComponets.dart';
import '../Pages/LocationServicePage.dart';
class otp extends StatefulWidget {
  _otpState createState() => new _otpState();
}

class _otpState extends State<otp> {
  FocusNode focus1 = FocusNode();
  FocusNode focus2 = FocusNode();
  FocusNode focus3 = FocusNode();
  FocusNode focus4 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(children:[
        otp_background,
        Container(
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(0, 0, 0, 245),
        ),
        ListView(children: [
        new Form(child: getOtp()),
        new Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 20, 0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(249, 129, 42, 1),),
                      shape: BoxShape.circle, color: Colors.white),
                  child: Center(
                    child: TextField(
                      autofocus: true,
                      focusNode: focus1,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: new TextStyle(color:Color.fromRGBO(249, 129, 42, 1), fontSize: 28),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "0",
                      ),
                      onChanged: (String newVal) {
                        if (newVal.length == 1) {
                          focus1.unfocus();
                          FocusScope.of(context).requestFocus(focus2);
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(249, 129, 42, 1),),
                      shape: BoxShape.circle, color: Colors.white),
                  child: Center(
                    child: TextField(
                      textAlign: TextAlign.center,
                      focusNode: focus2,
                      keyboardType: TextInputType.number,
                      style: new TextStyle(color: Color.fromRGBO(249, 129, 42, 1), fontSize: 28),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "0",
                      ),
                      onChanged: (String newVal) {
                        if (newVal.length == 1) {
                          focus2.unfocus();
                          FocusScope.of(context).requestFocus(focus3);
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(249, 129, 42, 1),),
                      shape: BoxShape.circle, color: Colors.white),
                  child: Center(
                    child: TextField(
                      textAlign: TextAlign.center,
                      focusNode: focus3,
                      keyboardType: TextInputType.number,
                      style: new TextStyle(color: Color.fromRGBO(249, 129, 42, 1), fontSize: 28),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "0",
                      ),
                      onChanged: (String newVal) {
                        if (newVal.length == 1) {
                          focus3.unfocus();
                          FocusScope.of(context).requestFocus(focus4);
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(249, 129, 42, 1),),
                      shape: BoxShape.circle, color: Colors.white),
                  child: Center(
                    child: TextField(
                      textAlign: TextAlign.center,
                      focusNode: focus4,
                      keyboardType: TextInputType.number,
                      style: new TextStyle(color: Color.fromRGBO(249, 129, 42, 1), fontSize: 28),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "0",
                      ),
                    ),
                  ),
                )
              ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
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
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocationServicePage() ),
              );*/
            },
          ),
        ),
      ]),]),
    );
  }

  Widget getOtp() {
    return new Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
          child: new Text(
            "Verify Your Number",
            style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
              fontSize: 60.0,
              color: Colors.deepOrangeAccent,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 280, 20, 40),
          child: new Text(
            "Enter the otp sent to your number",
            style: TextStyle(
              fontFamily: "OpenSans",
              fontWeight: FontWeight.normal,
              fontSize: 20.0,
              decorationColor: Colors.white30,
            ),
          ),
        ),
      ],
    );
  }
}
