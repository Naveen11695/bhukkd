import 'dart:async';

import 'package:bhukkd/Auth/GoogleSignIn.dart';
import 'package:bhukkd/Auth/Home/Components/Calender.dart';
import 'package:bhukkd/Auth/Home/Components/FadeContainer.dart';
import 'package:bhukkd/Auth/Home/Components/HomeTopView.dart';
import 'package:bhukkd/Auth/Home/Components/ListViewContainer.dart';
import 'package:bhukkd/Auth/Home/Screens/Home/homeAnimation.dart';
import 'package:bhukkd/Auth/Home/Screens/Home/styles.dart';
import 'package:bhukkd/Auth/register_page.dart';
import 'package:bhukkd/Components/AddButton.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Components/CustomTransition.dart';
import 'package:bhukkd/flarecode/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../Pages/otpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

Animation<double> containerGrowAnimation;
AnimationController _screenController;
AnimationController _buttonController;
Animation<double> buttonGrowAnimation;
Animation<double> listTileWidth;
Animation<Alignment> listSlideAnimation;
Animation<Alignment> buttonSwingAnimation;
Animation<EdgeInsets> listSlidePosition;
Animation<Color> fadeScreenAnimation;
var animateStatus = 0;
Size screenSize;
String month = new DateFormat.MMMM().format(
  new DateTime.now(),
);
int index = new DateTime.now().month;

class _LoginPage extends State<LoginPage> with TickerProviderStateMixin {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible;
  bool _success;
  String _userEmail;
  var snackBar;
  var handleError = "";
  Animation<double> buttonGrowAnimation;

  Widget buttonLoading = Container(
    child: Text(
      "Sign In",
      style: new TextStyle(
          fontSize: 20.0,
          fontFamily: "Montserrat",
// fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          wordSpacing: 0.0,
          textBaseline: TextBaseline.ideographic,
          color: Colors.white),
    ),
  );

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();

    _screenController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);
    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1500), vsync: this);

    buttonGrowAnimation = new CurvedAnimation(
      parent: _screenController,
      curve: Curves.easeOut,
    );

    fadeScreenAnimation = new ColorTween(
      begin: const Color.fromRGBO(247, 64, 106, 1.0),
      end: const Color.fromRGBO(247, 64, 106, 0.0),
    ).animate(
      new CurvedAnimation(
        parent: _screenController,
        curve: Curves.ease,
      ),
    );
    containerGrowAnimation = new CurvedAnimation(
      parent: _screenController,
      curve: Curves.easeIn,
    );

    buttonGrowAnimation = new CurvedAnimation(
      parent: _screenController,
      curve: Curves.easeOut,
    );
    containerGrowAnimation.addListener(() {
      this.setState(() {});
    });
    containerGrowAnimation.addStatusListener((AnimationStatus status) {});

    listTileWidth = new Tween<double>(
      begin: 1000.0,
      end: 600.0,
    ).animate(
      new CurvedAnimation(
        parent: _screenController,
        curve: new Interval(
          0.225,
          0.600,
          curve: Curves.bounceIn,
        ),
      ),
    );

    listSlideAnimation = new AlignmentTween(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).animate(
      new CurvedAnimation(
        parent: _screenController,
        curve: new Interval(
          0.325,
          0.700,
          curve: Curves.ease,
        ),
      ),
    );
    buttonSwingAnimation = new AlignmentTween(
      begin: Alignment.topCenter,
      end: Alignment.bottomRight,
    ).animate(
      new CurvedAnimation(
        parent: _screenController,
        curve: new Interval(
          0.225,
          0.600,
          curve: Curves.ease,
        ),
      ),
    );
    listSlidePosition = new EdgeInsetsTween(
      begin: const EdgeInsets.only(bottom: 16.0),
      end: const EdgeInsets.only(bottom: 80.0),
    ).animate(
      new CurvedAnimation(
        parent: _screenController,
        curve: new Interval(
          0.325,
          0.800,
          curve: Curves.ease,
        ),
      ),
    );
    _screenController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _screenController.dispose();
    _buttonController.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    timeDilation = 0.3;
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
          future: _auth.currentUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                //.........................................//Home Start//......................................................//

                print("................" + snapshot.data.email.toString());

                return Container(
                  child: Builder(builder: (BuildContext context) {
                    return ListView(
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new ImageBackground(
                              backgroundImage: backgroundImage,
                              containerGrowAnimation: containerGrowAnimation,
                              profileImage: profileImage,
                              email: snapshot.data.email.toString(),
                            ),
                            new ListViewContent(
                              listSlideAnimation: listSlideAnimation,
                              listSlidePosition: listSlidePosition,
                              listTileWidth: listTileWidth,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Material(
                                color: Color.fromRGBO(0, 0, 0, 50),
                                borderRadius: BorderRadius.circular(
                                  20.0,
                                ),
                                child: semi_circlar_button(
                                  'Sign out',
                                  () async {
                                    buttonLoading = buttonSignin;
                                    final FirebaseUser user =
                                        await _auth.currentUser();
                                    if (user == null) {
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content:
                                            const Text('No one has signed in.'),
                                      ));
                                      return;
                                    }
                                    _signOut();
                                    final String uid = user.email;
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(uid +
                                          ' has successfully signed out.'),
                                    ));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                );
                //.........................................//Home Start//......................................................//

              } else {
                print("nope");

                //.........................................//LoginForm Start//......................................................//

                return Scaffold(
                  //resizeToAvoidBottomPadding: false,
                  body: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        child: login_background,
                      ),
                      opacity,
                      SafeArea(
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(100, 20, 100, 30),
                              child: logo,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 50, 20, 25),
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
                                            color: Color.fromRGBO(
                                                255, 255, 255, 20),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: new TextFormField(
                                            controller: _emailController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              prefixIcon: const Icon(
                                                Icons.person,
                                                color: Color.fromRGBO(
                                                    249, 129, 42, 20),
                                              ),
                                              border: InputBorder.none,
                                              hasFloatingPlaceholder: true,
                                              hintText: 'you@example.com',
                                              filled: true,
                                              fillColor:
                                                  Colors.white.withOpacity(0),
                                              labelStyle: TextStyle(
                                                  color: Colors.deepOrange),
                                              labelText: "Email Id",
                                            ),
                                            validator: (val) =>
                                                (!val.contains('@') ||
                                                        !(val.length > 6))
                                                    ? 'Not a valid email.'
                                                    : null,
                                          ),
                                        ),
                                        new Container(
                                          margin: const EdgeInsets.all(5.0),
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: new BoxDecoration(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 20),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
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
                                                color: Color.fromRGBO(
                                                    249, 129, 42, 20),
                                              ),
                                              hasFloatingPlaceholder: true,
                                              filled: true,
                                              border: InputBorder.none,
                                              fillColor:
                                                  Colors.white.withOpacity(0),
                                              labelText: "Password",
                                              labelStyle: TextStyle(
                                                  color: Colors.deepOrange),
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
                                                child: Icon(
                                                  _passwordVisible
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Color.fromRGBO(
                                                      249, 129, 42, 20),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 20, 20, 10),
                                            child: Material(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 50),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                20.0,
                                              ),
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    buttonLoading=buttonLoading2;
                                                  });
                                                  final form =
                                                      formKey.currentState;
                                                  if (form.validate()) {
                                                    form.save();
                                                    _signInWithEmailAndPassword();
                                                  }
                                                },
                                                splashColor: Colors.white24,
                                                highlightColor: Colors.white10,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal:150.0, vertical: 10.0),
                                                  child: buttonLoading,
                                                ),
                                              ),
                                            )
                                            ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 5, 20, 20),
                                          child: semi_circlar_button(
                                              'Create an account', () {
                                            Route route = HorizontalTransition(
                                                builder:
                                                    (BuildContext context) =>
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
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: new OutlineButton(
                                      child: new Text(
                                        'Sign in With Google',
                                        style: textStyle.copyWith(
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      ),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      onPressed: () async {
                                        print(
                                            "Login button with Google fetching data from server....");
                                        signInWithGoogle();
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: new OutlineButton(
                                      child: new Text(
                                        'Sign in With Phone',
                                        style:
                                            textStyle.copyWith(fontSize: 15.0),
                                      ),
                                      borderSide:
                                          BorderSide(color: Colors.white),
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
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );

                //.........................................//LoginForm Ends//......................................................//
              }
            } else {
              print("no connection");
              return Container(
                child: Center(child: new FlareActor(
                  "assets/animations/loading_Untitled.flr",
                  animation: "Untitled",
                  fit: BoxFit.contain,
                ),),
              );
            }
          }),
    );
  }

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

  void _signOut() async {
    await _auth.signOut();
    setState(() {});
  }
}
