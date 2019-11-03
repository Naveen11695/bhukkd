import 'package:bhukkd/Auth/Home/GetterSetter/GetterSetterUserDetails.dart';
import 'package:bhukkd/Auth/Login/Pages/otpPage.dart';
import 'package:bhukkd/Auth/Login/components/Animation/login_animation.dart';
import 'package:bhukkd/Auth/Login/components/forward_button.dart';
import 'package:bhukkd/Auth/Login/components/header_text.dart';
import 'package:bhukkd/Auth/Login/components/trapozoid_cut_colored_image.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Components/CustomTransition.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Constants/color_utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class GoToWelcomeListener {
  void onGoToWelcomeTap();
}

class LoginPage extends StatefulWidget {
  final GoToWelcomeListener goToWelcomeListener;
  final LoginEnterAnimation enterAnimation;
  final String screenKey;

  @override
  LoginPage(
      {@required AnimationController controller,
      @required this.goToWelcomeListener,
      this.screenKey})
      : enterAnimation = new LoginEnterAnimation(controller);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var key = "LOGIN";

  String _BUTTON_ACCOUNT = "CREATE AN ACCOUNT";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Stack(
      children: <Widget>[
        _trapoziodView(size, textTheme),
        _buttonContainer(size, textTheme),
        Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 10.0),
          child: Container(
            child: new IconButton(
                icon: new Icon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.white,
                  size: 20.0,
                ),
                onPressed: () {
                  if (widget.screenKey.compareTo("LoginPage") == 0) {
                    widget.goToWelcomeListener.onGoToWelcomeTap();
                  } else {
                    Navigator.pop(context);
                  }
                }),
          ),
        ),
      ],
    );
  }

  Widget _trapoziodView(Size size, TextTheme textTheme) {
    return Transform(
      transform: Matrix4.translationValues(
          0.0, -widget.enterAnimation.Ytranslation.value * size.height, 0.0),
      child: TrapozoidTopBar(
          child: Container(
        height: size.height * 0.68,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            _buildBackgroundImage(size),
            _buildTextHeader(size, textTheme),
            _buildForm(size, textTheme)
          ],
        ),
      )),
    );
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible;
  bool _success;
  String _userEmail;
  var snackBar;
  var handleError = "";
  Animation<double> buttonGrowAnimation;
  static double c_width;
  static double c_height;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  Widget _buildForm(Size size, TextTheme textTheme) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 250),
      body: Padding(
        padding: EdgeInsets.only(top: size.height * 0.20, left: 24, right: 24),
        child: Stack(
          children: <Widget>[
            SafeArea(
              child: ListView(
                children: <Widget>[
                  (key == "LOGIN")
                      ? _buildLoginForm(textTheme)
                      : _buildRegistrationForm(textTheme),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: separator,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  final TextEditingController _confirmpasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Widget _buildLoginForm(TextTheme textTheme) {
    return Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            _buildTextFormUsername(textTheme),
            _buildTextFormPassword(textTheme),
          ],
        ));
  }

  Widget _buildRegistrationForm(TextTheme textTheme) {
    return Form(
      key: _formKey,
      child: FadeTransition(
        opacity: widget.enterAnimation.userNameOpacity,
        child: Column(
          children: <Widget>[
            _buildTextFormUsername(textTheme),
            _buildTextFormPassword(textTheme),
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
                validator: (val) => (val.isEmpty ||
                        val.compareTo(_passwordController.text) != 0)
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
                  labelStyle: TextStyle(color: Colors.deepOrange),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
          if (widget.screenKey.compareTo("LoginPage") == 0) {
            widget.goToWelcomeListener.onGoToWelcomeTap();
          } else {
            Navigator.pop(context);
          }
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
        snackBar = SnackBar(content: Text(handleError));
        Scaffold.of(context).showSnackBar(snackBar);
      });
    }
  }

  Widget _buildTextFormUsername(TextTheme textTheme) {
    return FadeTransition(
      opacity: widget.enterAnimation.userNameOpacity,
      child: new Container(
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
            labelStyle: TextStyle(color: Colors.deepOrange),
            labelText: "Email Id",
          ),
          validator: (val) => (!val.contains('@') || !(val.length > 6))
              ? 'Not a valid email.'
              : null,
        ),
      ),
    );
  }

  Widget _buildTextFormPassword(TextTheme textTheme) {
    return FadeTransition(
      opacity: widget.enterAnimation.passowrdOpacity,
      child: new Container(
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
            labelStyle: TextStyle(color: Colors.deepOrange),
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
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Color.fromRGBO(249, 129, 42, 20),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonContainer(Size size, TextTheme textTheme) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.70,),
      child: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Transform(
                    transform: Matrix4.translationValues(
                        widget.enterAnimation.translation.value * 200,
                        0.0,
                        0.0),
                    child: ForwardButton(
                      onPressed: () async {
                        setState(() {
                          if (key == "LOGIN") {
                            key = "REGISTRATION";
                            _BUTTON_ACCOUNT = "BACK";
                          } else {
                            key = "LOGIN";
                            _BUTTON_ACCOUNT = "CREATE AN ACCOUNT";
                          }
                        });
                      },
                      label: _BUTTON_ACCOUNT,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildSocialMediaAppButton(
                    COLOR_FACEBOOK,
                    IMAGE_PATH_FACEBOOK,
                    46,
                    widget.enterAnimation.facebookScaleTranslation.value,
                    "FACEBOOK"),
                SizedBox(
                  width: 8,
                ),
                _buildSocialMediaAppButton(
                    COLOR_GOOGLE,
                    IMAGE_PATH_GOOGLE,
                    56,
                    widget.enterAnimation.googleScaleTranslation.value,
                    "GOOGLE"),
                SizedBox(
                  width: 8,
                ),
                _buildSocialMediaAppButton(
                    COLOR_TWITTER,
                    IMAGE_PATH_PHONE,
                    66,
                    widget.enterAnimation.twitterScaleTranslation.value,
                    "PHONE"),
                SizedBox(
                  width: size.width * 0.1,
                ),
                Transform(
                  transform: Matrix4.translationValues(
                      widget.enterAnimation.translation.value * 200, 0.0, 0.0),
                  child: ForwardButton(
                    onPressed: () async {
                      if (key == "LOGIN") {
                        final form = formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          _signInWithEmailAndPassword();
                        }
                      } else if (key == "REGISTRATION") {
                        final form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          _register(context);
                        }
                      }
                    },
                    label: BUTTON_PROCEED,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
          _getDataFromFireStore();
          handleError = "";
          snackBar = SnackBar(content: Text("SignIn Successful"));
          Scaffold.of(context).showSnackBar(snackBar);
          if (widget.screenKey.compareTo("LoginPage") == 0) {
            widget.goToWelcomeListener.onGoToWelcomeTap();
          } else {
            Navigator.pop(context);
          }
        });
      } else {
        _success = false;
        print("SignIn Failed");
        snackBar = SnackBar(content: Text("SignIn Failed"));
        Scaffold.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      if (this.mounted) {
        setState(() {
          var _handleError = e.code.toString();
          print(e.message.toString());
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
            case "ERROR_NETWORK_REQUEST_FAILED":
              handleError =
              "A network timeout. Please connect to more stable network.";
              break;
            case "error":
              handleError = "Given fields should not be empty.";
          }
          snackBar = SnackBar(content: Text(handleError));
          Scaffold.of(context).showSnackBar(snackBar);
        });
      }

    }
  }

  _setData(DocumentSnapshot snapshot) async {
    GetterSetterUserDetails.firstName = snapshot.data['FirstName'];
    GetterSetterUserDetails.middleName = snapshot.data['MiddelName'];
    GetterSetterUserDetails.lastName = snapshot.data['LastName'];
    GetterSetterUserDetails.dob = snapshot.data['Dob'];
    GetterSetterUserDetails.gender = snapshot.data['Gender'];
    GetterSetterUserDetails.phoneNumber = snapshot.data['PhoneNumber'];
    GetterSetterUserDetails.emailId = snapshot.data['EmailId'];
    GetterSetterUserDetails.address = snapshot.data['Address'];
    GetterSetterUserDetails.description = snapshot.data['Description'];
  }

  _getDataFromFireStore() async {
    try {
      if (_auth.currentUser() != null) {
        _auth.currentUser().then((val) {
          if (val != null) {
            var fireStore = Firestore.instance;
            DocumentReference snapshot =
                fireStore.collection('UsersData').document(val.email);
            snapshot.get().then((dataSnapshot) {
              if (dataSnapshot.exists) {
                _setData(dataSnapshot);
              }
            });
          } else {
            print("not ");
          }
        });
      }
    } catch (e) {
      print("Error <Main>: " + e.toString());
    }
  }

  Widget _buildSocialMediaAppButton(String color, String image, double size,
      double animatedValue, String loginKey) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.diagonal3Values(animatedValue, animatedValue, 0.0),
      child: InkWell(
        onTap: () async {
          if (loginKey == "GOOGLE") {
            signInWithGoogle();
          } else if (loginKey == "PHONE") {
            Route route = HorizontalTransition(
                builder: (BuildContext context) => new otpPage());
            Navigator.push(context, route);
          }
        },
        child: Container(
          height: size,
          width: size,
          padding: const EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: Color(getColorHexFromStr(color)),
          ),
          child: Image.asset(image),
        ),
      ),
    );
  }

  void signInWithGoogle() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    bool _success;
    String _userID;
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    if (user != null) {
      _success = true;
      _userID = user.uid;
      print("signIn Successfull");
      if (this.mounted) {
        setState(() {
          _getDataFromFireStore();
          snackBar = SnackBar(content: Text("SignIn Successful"));
          Scaffold.of(context).showSnackBar(snackBar);
          if (widget.screenKey.compareTo("LoginPage") == 0) {
            widget.goToWelcomeListener.onGoToWelcomeTap();
          } else {
            Navigator.pop(context);
          }
        });
      }
    } else {
      _success = false;
      print("signIn failed");
      snackBar = SnackBar(content: Text("SignIn Failed"));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  Widget _buildBackgroundImage(Size size) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.0),
      child: Container(
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
              image: new AssetImage(IMAGE_LOGIN_PATH),
              fit: BoxFit.fill,
              colorFilter:
                  ColorFilter.mode(Colors.black45, BlendMode.multiply)),
        ),
      ),
    );
  }

  Widget _buildTextHeader(Size size, TextTheme textTheme) {
    return Transform(
      transform: Matrix4.translationValues(
          -widget.enterAnimation.Xtranslation.value * size.width, 0.0, 0.0),
      child: Padding(
        padding: EdgeInsets.only(top: size.height * 0.15, left: 24, right: 24),
        child: HeaderText(
          text: (key == "LOGIN") ? TITLE_SIGNIN : TITLE_ACCOUNT,
          imagePath: IMAGE_SLIPPER_PATH,
          opacity: 50,
        ),
      ),
    );
  }
}
