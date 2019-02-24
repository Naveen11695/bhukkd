import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/api/HttpRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class LoginPage extends StatelessWidget {
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
          background,
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
                          color: Color.fromARGB(200, 255, 255, 255),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: new ListTile(
                          leading: const Icon(Icons.person),
                          title: new TextField(
                            decoration: new InputDecoration(
                              hintText: "Email Id or Phone no.",
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
                          color: Color.fromARGB(200, 255, 255, 255),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: new ListTile(
                          leading: const Icon(Icons.person),
                          title: new TextField(
                            decoration: new InputDecoration(
                              hintText: "Password",
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
                    print("create an account");
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
                                padding: const EdgeInsets.all(30.0),
                                child: new OutlineButton(
                                  child: new Text(
                                    'Sign in With Google',
                                    style: textStyle.copyWith(fontSize: 15.0),
                                  ),
                                  borderSide: BorderSide(color: Colors.white),
                                  onPressed: () {
                                    print("Login button with Google fetching data from server....");
                                    fetchRestByGeoCode();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
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
