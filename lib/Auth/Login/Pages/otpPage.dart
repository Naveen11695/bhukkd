import 'dart:async';

import 'package:bhukkd/Auth/Login/Pages/otp.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Constants/color_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class otpPage extends StatefulWidget {
  _otpPageState createState() => new _otpPageState();
}

final scaffoldKey = GlobalKey<ScaffoldState>();

final FirebaseAuth _auth = FirebaseAuth.instance;
enum ConfirmAction { CANCEL, ACCEPT }

String verificationId;
final TextEditingController phoneController = TextEditingController();

class _otpPageState extends State<otpPage> {


  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return new Scaffold(
        key: scaffoldKey,
        body: Stack(fit: StackFit.expand, children: <Widget>[
          Positioned(
            top: 0,
            child: login_background(size),
          ),
          Container(
            color: Colors.black45,
          ),
          new ListView(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(100, 20, 100, 10),
                child: logo,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
                child: login_description,
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextField(
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[0-9]"))],
                  enableInteractiveSelection: false,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  style: new TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  decoration: new InputDecoration(
                    border: null,
                    fillColor: Color.fromRGBO(249, 129, 42, 1),
                    focusedBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Colors.white, width: 5.0),
                        borderRadius: BorderRadius.circular(30.0)),
                    hintText: OTP_HINT,
                    helperText: OTP_HELP_TEXT,
                    labelText: OTP_TEXT,
                    labelStyle: new TextStyle(
                        letterSpacing: 2.0, color: Colors.white, fontSize: 30),
                    helperStyle: new TextStyle(
                        letterSpacing: 2.0, color: Colors.white, fontSize: 15),
                    hintStyle: new TextStyle(
                        letterSpacing: 2.0, color: Colors.white, fontSize: 20),
                    prefixIcon: const Icon(
                      Icons.phone_android,
                      color: Colors.white,
                    ),
                    prefixText: ' +91 ',
                    prefixStyle: new TextStyle(
                        letterSpacing: 2.0,
                        color: Colors.white70,
                        fontSize: 30),
                  ),
                  maxLength: 10,
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new InkWell(
                    child: new Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(getColorHexFromStr('#667898')),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black,
                              blurRadius: 20.0,
                            ),
                          ]),
                      child: new Icon(
                        Icons.arrow_back,
                        size: 40.0,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  new InkWell(
                    child: new Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(getColorHexFromStr('#667898')),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black,
                              blurRadius: 20.0,
                            ),
                          ]),
                      child: new Icon(
                        Icons.arrow_forward,
                        size: 40.0,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      if (phoneController.text.length == 10) {
                        _asyncConfirmDialog(context);
                      }
                      else {
                        var snackBar = SnackBar(content: Text(
                            "Invaild Phone number. Please enter a valid Phone number."));
                        scaffoldKey.currentState.showSnackBar(snackBar);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ]));
  }

  smsCodeDialog(BuildContext context) {
    Text("Your Varification code is");
  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign in With Phone'),
          content: Text(
              'Do you want to send OTP on ' + phoneController.text + " ?"),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('ACCEPT'),
              onPressed: () async {
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
                verifyPhoneNumber();
              },
            )
          ],
        );
      },
    );
  }

  void verifyPhoneNumber() async {
    try {
      final Function(FirebaseUser user) verificationCompleted =
          (FirebaseUser user) {
        print('signInWithPhoneNumber auto succeeded: $user');
        return Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => otp()),
        );
      };

      final PhoneVerificationFailed verificationFailed =
          (AuthException authException) {
        print(
            'Phone number verification failed. Code: ${authException
                .code}. Message: ${authException.message}');
        var snackBar = SnackBar(content: Text(
            "Phone number verification failed. Please enter your Phone number."));
        scaffoldKey.currentState.showSnackBar(snackBar);
      };

      final PhoneCodeSent codeSent =
          (String verificationId, [int forceResendingToken]) async {
        print('Please check your phone for the verification code.');
        verificationId = verificationId;
      };

      final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
          (String verificationId) {
        verificationId = verificationId;
      };

      var user = FirebaseAuth.instance.currentUser();

      user.then((val) async =>
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91" + phoneController.text,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted(val),
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
      );
    } catch (e) {
      print(e.message);
    }
  }
}

