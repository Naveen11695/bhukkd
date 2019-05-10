import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Components/CustomTransition.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

var handleError = "";

bool _passwordVisible;

class RegisterPage extends StatefulWidget {
  final String title = 'Registration';
  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {


  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  bool _success;
  String _userEmail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
   SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: scaffoldKey,
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
                        key: _formKey,
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
                                color: Color.fromRGBO(255, 255, 255, 20),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: TextFormField(
                                enableInteractiveSelection: false,
                                controller: _passwordController,
                                obscureText: !_passwordVisible,
                                validator: (val) =>
                                val.length < 6
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
                                    child: Icon(_passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                      color: Color.fromRGBO(249, 129, 42, 20),),
                                  ),
                                ),
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
                                controller: _confirmpasswordController,
                                validator: (val) =>
                                (val.isEmpty||val.compareTo(_passwordController.text) != 0)
                                    ? 'The Password must be same.'
                                    : null,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.confirmation_number,
                                    color: Color.fromRGBO(249, 129, 42, 20),
                                  ),
                                  hasFloatingPlaceholder: true,
                                  filled: true,
                                  border: InputBorder.none,
                                  fillColor: Colors.white.withOpacity(0),
                                  labelText: "Confirm Password",
                                  labelStyle: TextStyle(
                                      color: Colors.deepOrange),
                                ),
                              ),
                            ),
                            SizedBox(height: 25.0,),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                              child:
                              semi_circlar_button(
                                  'Create an account', () async {
                                final form = _formKey.currentState;
                                if (form.validate()) {
                                  form.save();
                                  _register(context);
                                }
                              }),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                              child:
                              semi_circlar_button(
                                  'Cancel', () async {
                                Navigator.pop(context);
                              }),
                            ),
                            SizedBox(height: 25.0,),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }



  void _register(BuildContext _context) async {
    _formKey.currentState.save();
    try {
      print("Email: " + _emailController.text.trim());
      print("password: " + _passwordController.text.trim());
      final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (user != null) {
        setState(() {
          _success = true;
          _userEmail = user.email;
          print("registered successfully");
          Navigator.pop(context);
        });
      } else {
        _success = false;
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
          case "ERROR_EMAIL_ALREADY_IN_USE":
            handleError =
            "The email address is already in use by another account.";
            break;
          case "ERROR_NETWORK_REQUEST_FAILED":
            handleError =
            "A network timeout. Please connect to more stable network.";
        }
        var snackBar = SnackBar(content: Text(handleError));
        scaffoldKey.currentState.showSnackBar(snackBar);
      });
    }
  }



}
