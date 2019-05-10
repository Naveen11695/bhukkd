import 'dart:async';

import 'package:bhukkd/Auth/Home/OtpComponets/otpcomponets.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Auth/otpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Components/CustomComponets.dart';

class otp extends StatefulWidget {
  _otpState createState() => new _otpState();
}

FocusNode focus1 = FocusNode();
FocusNode focus2 = FocusNode();
FocusNode focus3 = FocusNode();
FocusNode focus4 = FocusNode();
FocusNode focus5 = FocusNode();
FocusNode focus6 = FocusNode();

final TextEditingController otp1 = TextEditingController();
final TextEditingController otp2 = TextEditingController();
final TextEditingController otp3 = TextEditingController();
final TextEditingController otp4 = TextEditingController();
final TextEditingController otp5 = TextEditingController();
final TextEditingController otp6 = TextEditingController();

class _otpState extends State<otp> {
  double c_width;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    c_width = MediaQuery.of(context).size.width * 0.5;
    return WillPopScope(
      onWillPop: () async{
        print("back");
        await _auth.signOut();
        print("signOut Successfull");
        Navigator.pop(context);
      },
      child: new Scaffold(
        key: scaffoldKey,
        body: Stack(children: [
          Positioned(
            top: 0,
            child: login_background,
          ),
          opacity,
          Container(
            height: MediaQuery.of(context).size.height,
            color: Color.fromRGBO(0, 0, 0, 245),
          ),
          ListView(children: [
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: new Text(
                "Verify Your Number",
                style: TextStyle(
                  shadows: [
                    Shadow(
                      // bottomLeft
                        offset: Offset(-1.5, -1.5),
                        color: Colors.grey),
                    Shadow(
                      // bottomRight
                        offset: Offset(1.5, -1.5),
                        color: Colors.grey),
                    Shadow(
                      // topRight
                        offset: Offset(1.5, 1.5),
                        color: Colors.grey),
                    Shadow(
                      // topLeft
                        offset: Offset(-1.5, 1.5),
                        color: Colors.grey),
                  ],
                  fontFamily: "Montserrat-bold",
                  fontWeight: FontWeight.bold,
                  fontSize: 60.0,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: c_width,
                child: Column(
                  children: <Widget>[
                    new Text(
                      "OTP is sent to your registered Phone number: ",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        color: Colors.white,
                        decorationColor: Colors.white30,
                      ),
                ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: new Text(
                      phoneController.text,
                      style: TextStyle(
                        shadows: [Shadow(color: Colors.black,offset: Offset(3,6),blurRadius: 5.0)],
                        fontFamily: "Montserrat-bold",
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0,
                        color: Colors.white,
                        decorationColor: Colors.white30,
                      ),
                      ),
                  ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:20.0,right: 20.0, bottom: 50.0),
              child: Container(
                width: c_width*2,
                child: new Text(
                  "Please check your phone for the verification code.",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                    color: Colors.black,
                    decorationColor: Colors.white30,
                  ),
                ),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  otpField(context),
                ]),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: new OutlineButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      'Resend OTP Code',
                      style:
                      textStyle.copyWith(fontSize: 20.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  borderSide:
                  BorderSide(color: Colors.white),
                  onPressed: () async{
                    //verifyPhoneNumber(context);
                    print("Resend");
                  },
                ),
              ),
            ),

            SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                new InkWell(
                  child: new Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black,
                          blurRadius: 20.0,
                        ),
                      ]),
                    child: new Icon(
                      Icons.clear,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    otp1.clear();
                    otp2.clear();
                    otp3.clear();
                    otp4.clear();
                    otp5.clear();
                    otp6.clear();
                  },
                ),

                new InkWell(
                  child: new Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.black,
                            blurRadius: 20.0,
                          ),
                        ]),
                    child: new Icon(
                      Icons.check,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () async{
                    print(otp1.text);
                    if(otp1.text!=""&&otp2.text!=""&&otp3.text!=""&&otp4.text!=""&&otp5.text!=""&&otp6.text!="")
                    _signInWithPhoneNumber();
                    else{
                      var snackBar = SnackBar(content: Text("Invalid OTP. Please enter the valid OTP."));
                      scaffoldKey.currentState.showSnackBar(snackBar);
                    }
                  },
                ),

              ],
            ),
          ]),
        ]),
      ),
    );
  }

  void _signInWithPhoneNumber() async {
    try {
      print(otp1.text + otp2.text + otp3.text + otp4.text + otp5.text +
          otp6.text);
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: otp1.text + otp2.text + otp3.text + otp4.text + otp5.text +
            otp6.text,
      );
      final FirebaseUser user = await _auth.signInWithCredential(credential);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      setState(() {
        if (user != null) {
          print('Successfully signed in, uid: ' + user.uid);
        } else {
          print('Sign in failed');
        }
      });
    }catch (e) {
      print("........... " +e.message);
    }
  }
}


