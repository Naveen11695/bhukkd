import 'package:bhukkd/Components/CustomComponets.dart';
import '../api/HttpRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Pages/otpPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  bool _passwordVisible;
  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
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
          Positioned(top:0,
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
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 100),
                  child: login_description,
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Container(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                        decoration: new BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 20),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: new ListTile(
                          leading: const Icon(Icons.person, color: Color.fromRGBO(249, 129, 42, 20),),
                          title: new TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hasFloatingPlaceholder: true,
                              filled: true,
                              fillColor: Colors.white.withOpacity(0),
                              labelText: "Email Id or Phone no.",
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Container(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                        decoration: new BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 20),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: new ListTile(
                          leading: const Icon(Icons.enhanced_encryption , color: Color.fromRGBO(249, 129, 42, 20),),
                          title: TextFormField(
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              hasFloatingPlaceholder: true,
                              filled: true,
                              fillColor: Colors.white.withOpacity(0),
                              labelText: "Password",
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
                                    _passwordVisible ? Icons.visibility : Icons.visibility_off),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: semi_circlar_button('Sign In', () {
                    print("SignIn");
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
                  child: semi_circlar_button('Create an account', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => otpPage()),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
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
                                    style: textStyle.copyWith(fontSize: 15.0),
                                  ),
                                  borderSide: BorderSide(color: Colors.white),
                                  onPressed: () {
                                    print("Login button with Google fetching data from server....");
                                    // fetchRestByGeoCode();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: new OutlineButton(
                                  child: new Text(
                                    'Sign in With Facebook',
                                    style: textStyle.copyWith(fontSize: 15.0),
                                  ),
                                  borderSide: BorderSide(color: Colors.white),
                                  onPressed: null,
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
