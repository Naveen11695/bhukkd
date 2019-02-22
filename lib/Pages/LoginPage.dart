import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Components/userInput.dart';

class LoginPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);



    final logo = Image.asset(
        'assets/images/icon.png',
        width: 120.0,
        height: 120.0,
      );


    final background = Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/7.jpeg'),
              fit: BoxFit.cover,
            )
        )
    );

    final orangeOpacity = Container(
      color: Color(0xAAAF2222),
    );

    const TextStyle textStyle = TextStyle(
      color: Color(0xFFFFFFFF),
      fontFamily: 'Raleway',
    );


    final description = Text(
      "Spot the right place to find your favorite food.",
      textAlign: TextAlign.center,
      style: textStyle.copyWith(fontSize: 20.0,),
    );

    final separator = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      Container(
        width: 20.0, height: 2.0, color: Colors.white,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('OR', style: textStyle,),
      ),
      Container(
        width: 20.0, height: 2.0, color: Colors.white,),
      ],
    );

    Widget button(String label, Function onTap) {
      return Material(
        color: Color.fromARGB(200, 255, 138, 128),
        borderRadius: BorderRadius.circular(30.0),
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.white24,
          highlightColor: Colors.white10,

          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: Text(label, style: textStyle.copyWith(fontSize: 20.0),),
            ),
          ),
        ),
      );
    }


    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          background,
          orangeOpacity,
          new SafeArea(child:
          ListView(
           // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(100, 20, 100, 30),
                child: logo,
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 100),
                child: description,
              ),

        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Container (
                padding: EdgeInsets.symmetric(vertical: 2.0),
                decoration: new BoxDecoration (
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
              child: new Container (
                padding: EdgeInsets.symmetric(vertical: 2.0),
                decoration: new BoxDecoration (
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
                child: button('Sign In', () { print("SignIn");}),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
                child: button('Create an account', () { print("create an account");}),
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: new OutlineButton(
                            child: new Text('Sign in With Google',style: textStyle.copyWith(fontSize: 15.0),),
                            borderSide: BorderSide(color: Colors.black),
                            onPressed:null ,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
                          child: new OutlineButton(
                            child: new Text('Sign in With Facebook',style: textStyle.copyWith(fontSize: 15.0),),
                            borderSide: BorderSide(color: Colors.black),
                            onPressed:null ,
                          ),
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




















