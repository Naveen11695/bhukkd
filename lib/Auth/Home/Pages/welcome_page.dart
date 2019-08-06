import 'package:bhukkd/Auth/Home/Components/Animation/styles.dart';
import 'package:bhukkd/Auth/Home/Components/Calender.dart';
import 'package:bhukkd/Auth/Home/Components/HomeTopView.dart';
import 'package:bhukkd/Auth/Home/Components/ListViewContainer.dart';
import 'package:bhukkd/Auth/Home/Components/welcome_animation.dart';
import 'package:bhukkd/Auth/Home/GetterSetter/GetterSetterUserDetails.dart';
import 'package:bhukkd/Auth/Login/components/forward_button.dart';
import 'package:bhukkd/Auth/Login/components/header_text.dart';
import 'package:bhukkd/Auth/Login/components/trapozoid_cut_colored_image.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

abstract class GoToLoginListener {
  void onGoAheadTap();
}

Animation<double> containerGrowAnimation;
AnimationController _screenController;
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

class WelcomePage extends StatefulWidget {
  final WelcomeEnterAnimation welcomeEnterAnimation;
  final GoToLoginListener goTOLoginListener;
  final screenKey;

  WelcomePage(
      {@required AnimationController controller,
      @required this.goTOLoginListener,
      this.screenKey})
      : welcomeEnterAnimation = new WelcomeEnterAnimation(controller);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AnimationController _controller;
  Animation<double> _heightFactorAnimation;
  final double collapsedHeightFactor = 0.69;
  final double expendedHeightFactor = 0.1;
  bool isAnimationCompleted = false;

  Widget buttonLoading = Text(
    "Sign In",
    style: new TextStyle(
        fontSize: 20.0,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
        wordSpacing: 0.0,
        textBaseline: TextBaseline.ideographic,
        color: Colors.white),
  );

  @override
  void initState() {
    super.initState();

    _screenController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);

    containerGrowAnimation = new CurvedAnimation(
      parent: _screenController,
      curve: Curves.easeIn,
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
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _heightFactorAnimation =
        Tween<double>(begin: collapsedHeightFactor, end: expendedHeightFactor)
            .animate(_controller);
    _screenController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      child: FutureBuilder(
          future: _auth.currentUser(),
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                //.........................................//Home Start//......................................................//
                GetterSetterUserDetails.emailId =
                    snapshot.data.email.toString();
                return Container(
                  color: SECONDARY_COLOR,
                  child: Stack(children: <Widget>[
                    Column(
                      children: <Widget>[
                        new ImageBackground(
                          backgroundImage: backgroundImage,
                          containerGrowAnimation: containerGrowAnimation,
                          profileImage: profileImage,
                          email: GetterSetterUserDetails.emailId,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              elevation: 20,
                              child: new Calender(
                                  margin: listSlidePosition.value * 0)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: new EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .45,
                          left: 10,
                          right: 10),
                      child: Card(
                        elevation: 20,
                        child: ListView(
                          children: <Widget>[
                            bottomView(context),
                          ],
                        ),
                      ),
                    ),
                  ]),
                );
                //.........................................//Home Start//......................................................//

              } else {
                print("nope");
                return Stack(
                  children: <Widget>[
                    _trapoziodView(size, textTheme),
                    _buttonContainer(size),
                  ],
                );
              }
            } else {
              print("no connection");
              return Container(
                child: Center(
                  child: new FlareActor(
                    "assets/animations/loading_2.flr",
                    animation: "Untitled",
                    fit: BoxFit.contain,
                  ),
                ),
              );
            }
          }),
    );
  }

  Widget _trapoziodView(Size size, TextTheme textTheme) {
    return Transform(
      transform: Matrix4.translationValues(0.0,
          -widget.welcomeEnterAnimation.translation.value * size.height, 0.0),
      child: TrapozoidTopBar(
          child: Container(
        height: size.height * 0.7,
        color: Colors.deepOrange,
        child: Stack(
          children: <Widget>[
            _buildBackgroundImage(),
            _buildTextHeader(size, textTheme),
          ],
        ),
      )),
    );
  }

  Widget _buttonContainer(Size size) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.8),
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Transform(
                  transform: Matrix4.translationValues(
                      -widget.welcomeEnterAnimation.translation.value * 200,
                      0.0,
                      0.0),
                  child: HeaderText(
                    text: TITLE_SIGNIN,
                    imagePath: IMAGE_SLIPPER_PATH,
                    opacity: 255,
                  )),
            ),
            SizedBox(
              width: 16,
            ),
            Transform(
              transform: Matrix4.translationValues(
                  widget.welcomeEnterAnimation.translation.value * 200,
                  0.0,
                  0.0),
              child: ForwardButton(
                onPressed: () {
                  widget.goTOLoginListener.onGoAheadTap();
                },
                label: BUTTON_GOAHEAD,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Container(
      decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
              image: new AssetImage(IMAGE_WELCOME_PATH),
              fit: BoxFit.cover,
              colorFilter:
                  ColorFilter.mode(Colors.black45, BlendMode.multiply))),
    );
  }

  Widget _buildTextHeader(Size size, TextTheme textTheme) {
    return FadeTransition(
      opacity: widget.welcomeEnterAnimation.titleLabelOpacity,
      child: Padding(
        padding: EdgeInsets.only(top: size.height * 0.15, left: 24, right: 24),
        child: Container(
          width: double.infinity,
          child: login_description,
        ),
      ),
    );
  }

  Widget bottomView(BuildContext context) {
    return Column(
      children: <Widget>[
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
                final FirebaseUser user = await _auth.currentUser();
                if (user == null) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: const Text('No one has signed in.'),
                  ));
                  return;
                }
                _signOut();
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Signed Out'),
                ));
              },
            ),
          ),
        ),
      ],
    );
  }

  void _signOut() async {
    removeData();
    try {
      _auth.signOut();
      _googleSignIn.disconnect();
      print("Signed Out");
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  void removeData() {
    GetterSetterUserDetails.firstName = null;
    GetterSetterUserDetails.middleName = null;
    GetterSetterUserDetails.lastName = null;
    GetterSetterUserDetails.dob = null;
    GetterSetterUserDetails.gender = null;
    GetterSetterUserDetails.phoneNumber = null;
    GetterSetterUserDetails.emailId = null;
    GetterSetterUserDetails.address = null;
    GetterSetterUserDetails.description = null;
  }
}
