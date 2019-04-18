import 'dart:async';

import 'package:bhukkd/Auth/GoogleSignIn.dart';
import 'package:bhukkd/Auth/register_page.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Components/CustomTransition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Pages/otpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var handleError = "";

  bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;
  var snackBar;

  Future _signInWithEmailAndPassword() async {
    formKey.currentState.save();
    try {
      final FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (user != null) {
        setState(() {
          _success = true;
          _userEmail = user.email;
          print("SignIn Successful");
          handleError = "";
          snackBar = SnackBar(content: Text("SignIn Successful"));
          Scaffold.of(context).showSnackBar(snackBar);
        });
      } else {
        _success = false;
        print("SignIn Failed");
        snackBar = SnackBar(content: Text("SignIn Failed"));
        Scaffold.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      setState(() {
        var _handleError = e.code;
        print(e.toString());
        switch (e.code) {
          case "ERROR_USER_NOT_FOUND":
            handleError =
                "Email Id doesn't exist. Please check the email address.";
            break;
          case "ERROR_WRONG_PASSWORD":
            handleError =
                "Password incorrect. Please check the password again.";
            break;
          case "ERROR_INVALID_EMAIL":
            handleError = "The E-mail Address must be a valid email address.";
            break;
          case "ERROR_INVALID_PASSWORD":
            handleError =
                "Password incorrect. Please check the password again.";
            break;
        }
        snackBar = SnackBar(content: Text(handleError));
        Scaffold.of(context).showSnackBar(snackBar);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            top: 0,
            child: login_background,
          ),
          opacity,
          new SafeArea(
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(100, 20, 100, 30),
                  child: logo,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 25),
                  child: login_description,
                ),
                Column(
                  children: <Widget>[
                    Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                               new Container(
                                margin: const EdgeInsets.all(5.0),
                                padding: const EdgeInsets.all(5.0),
                                decoration: new BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 20),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: new TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color: Color.fromRGBO(249, 129, 42, 20),
                                      ),
                                      border: InputBorder.none,
                                      hasFloatingPlaceholder: true,
                                      hintText: 'you@example.com',
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0),
                                      labelStyle: TextStyle(color:Colors.deepOrange),
                                      labelText: "Email Id",
                                    ),
                                    validator: (val) => (!val.contains('@') ||
                                            !(val.length > 6))
                                        ? 'Not a valid email.'
                                        : null,
                                  ),
                              ),
                              new Container(
                                margin: const EdgeInsets.all(5.0),
                                padding: const EdgeInsets.all(5.0),
                                decoration: new BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 20),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: TextFormField(
                                  enableInteractiveSelection: false,
                                    controller: _passwordController,
                                    obscureText: !_passwordVisible,
                                    validator: (val) => val.length < 6
                                        ? 'The Password must be at least 6 characters.'
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.enhanced_encryption,
                                        color: Color.fromRGBO(249, 129, 42, 20),
                                      ),
                                      hasFloatingPlaceholder: true,
                                      filled: true,
                                      border: InputBorder.none,
                                      fillColor: Colors.white.withOpacity(0),
                                      labelText: "Password",
                                      labelStyle: TextStyle(color:Colors.deepOrange),
                                      suffixIcon: GestureDetector(
                                        onLongPress: () {
                                          setState(() {
                                            _passwordVisible = true;
                                          });
                                        },
                                        onLongPressUp: () {
                                          setState(() {
                                            _passwordVisible = false;
                                          });
                                        },
                                        child: Icon(_passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,color: Color.fromRGBO(249, 129, 42, 20),),
                                      ),
                                    ),
                                  ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 20, 20, 10),
                              child: semi_circlar_button('Sign In', () async {
                                final form = formKey.currentState;
                                if (form.validate()) {
                                  form.save();
                                  _signInWithEmailAndPassword();
                                }
                              }),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                              child:
                                  semi_circlar_button('Create an account', () {
                                    Route route = HorizontalTransition(
                                        builder: (BuildContext context) =>
                                        new RegisterPage());
                                    Navigator.push(context, route);
                              }),
                            ),
                          ],
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: separator,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Stack(
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: new OutlineButton(
                                  child: new Text(
                                    'Sign in With Google',
                                    style: textStyle.copyWith(fontSize: 15.0,color: Colors.white),
                                  ),
                                  borderSide: BorderSide(color: Colors.white),
                                  onPressed: () async {
                                    print("Login button with Google fetching data from server....");
                                    signInWithGoogle();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: new OutlineButton(
                                  child: new Text(
                                    'Sign in With Phone',
                                    style: textStyle.copyWith(fontSize: 15.0),
                                  ),
                                  borderSide: BorderSide(color: Colors.white),
                                  onPressed: () {
                                    Route route = HorizontalTransition(
                                        builder: (BuildContext context) =>
                                            new otpPage());
                                    Navigator.push(context, route);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
