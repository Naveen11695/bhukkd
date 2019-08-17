import 'package:bhukkd/Auth/Home/GetterSetter/GetterSetterBookingDetails.dart';
import 'package:bhukkd/Auth/Home/GetterSetter/GetterSetterUserDetails.dart';
import 'package:bhukkd/Auth/Home/Pages/DetailPage.dart';
import 'package:bhukkd/Auth/Onboarding/Pages/onboarding_page.dart';
import 'package:bhukkd/Booking/Pages/TransitionPage.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Components/CustomTransition.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class BookingMain extends StatefulWidget {
  final restruant_photo_url;
  final restruantInfo;

  BookingMain(this.restruant_photo_url, this.restruantInfo);

  @override
  _BookingMainState createState() => _BookingMainState();
}

class _BookingMainState extends State<BookingMain> {
  double c_height;
  double c_width;
  var defaultColor = SECONDARY_COLOR_4;
  var selectedColor = SECONDARY_COLOR_1;

  var btnColor_1,
      btnColor_2,
      btnColor_3,
      btnColor_4,
      btnColor_5,
      btnColor_6,
      btnColor_7,
      btnColor_8,
      btnColor_9;

  var _Crindex = 1;

  TextStyle _textStyle(double size, Color color, String font) {
    return TextStyle(
        fontSize: size,
        fontFamily: font,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.8,
        wordSpacing: 0.0,
        textBaseline: TextBaseline.ideographic,
        color: color);
  }

  var _n = 2;

  DateTime _date;

  String _timeSlot;

  @override
  void initState() {
    btnColor_1 = defaultColor;
    btnColor_2 = defaultColor;
    btnColor_3 = defaultColor;
    btnColor_4 = defaultColor;
    btnColor_5 = defaultColor;
    btnColor_6 = defaultColor;
    btnColor_7 = defaultColor;
    btnColor_8 = defaultColor;
    btnColor_9 = defaultColor;

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final newState = _scrollController.offset <=
          (_scrollController.position.minScrollExtent + 120.0);

      if (newState != _isScrollLimitReached) {
        setState(() {
          _isScrollLimitReached = newState;
        });
      }
    });

    super.initState();
  }

  final booking_scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isScrollLimitReached = false;
  ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    c_height = MediaQuery.of(context).size.height * 0.5;
    c_width = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
      key: booking_scaffoldKey,
      body: CustomScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: SECONDARY_COLOR_1,
            expandedHeight: 260.0,
            primary: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: _isScrollLimitReached
                  ? ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 200),
                      child: Text(
                        widget.restruantInfo.restruant_Name,
                        textDirection: TextDirection.ltr,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: FONT_TEXT_PRIMARY,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          wordSpacing: 0.5,
                          shadows: [
                            Shadow(
                                // bottomLeft
                                offset: Offset(1.5, 1.5),
                                color: SECONDARY_COLOR_1,
                                blurRadius: 20),
                            Shadow(
                                // bottomRight
                                offset: Offset(1.5, 1.5),
                                color: Colors.white,
                                blurRadius: 5),
                            Shadow(
                                // topRight
                                offset: Offset(1.5, 1.5),
                                color: SECONDARY_COLOR_1,
                                blurRadius: 5),
                            Shadow(
                                // topLeft
                                offset: Offset(1.5, 1.5),
                                color: SECONDARY_COLOR_1,
                                blurRadius: 5),
                          ],
                        ),
                      ),
                    )
                  : Text(
                      widget.restruantInfo.restruant_Name,
                      textDirection: TextDirection.ltr,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: FONT_TEXT_PRIMARY,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        wordSpacing: 0.5,
                        shadows: [
                          Shadow(
                              // bottomLeft
                              offset: Offset(1.5, 1.5),
                              color: SECONDARY_COLOR_1,
                              blurRadius: 20),
                          Shadow(
                              // bottomRight
                              offset: Offset(1.5, 1.5),
                              color: Colors.white,
                              blurRadius: 5),
                          Shadow(
                              // topRight
                              offset: Offset(1.5, 1.5),
                              color: SECONDARY_COLOR_1,
                              blurRadius: 5),
                          Shadow(
                              // topLeft
                              offset: Offset(1.5, 1.5),
                              color: SECONDARY_COLOR_1,
                              blurRadius: 5),
                        ],
                      ),
                    ),
              centerTitle: false,
              background: CachedNetworkImage(
                imageUrl: widget.restruant_photo_url,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) => new Image.asset(
                  "assets/images/default.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              collapseMode: CollapseMode.parallax,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return booking_Form(context, c_width, c_height);
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget booking_Form(BuildContext context, double _width, double _height) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 20.0, left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: SECONDARY_COLOR_1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    width: c_width * 1.2,
                    child: Text(
                      widget.restruantInfo.restruant_Location.address,
                      textDirection: TextDirection.ltr,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: FONT_TEXT_SECONDARY,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        wordSpacing: 0.5,
                      ),
                    ),
                  ),
                  DecoratedBox(
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                            widget.restruantInfo.restruant_User_rating
                                .aggregate_rating,
                            style: TextStyle(
                              fontFamily: FONT_TEXT_PRIMARY,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ))),
                    decoration: BoxDecoration(
                      color: SECONDARY_COLOR_1,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(5.0, 5.0),
                            blurRadius: 20)
                      ],
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10.0,
                bottom: 20.0,
              ),
              child: _buildPartySize(),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10.0,
                bottom: 20.0,
              ),
              child: _buildDate(),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10.0,
                bottom: 20.0,
              ),
              child: _buildTimeSlot(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8.0,
              ),
              child: semi_circlar_button("Find the Table", findTable),
            ),
          ],
        ),
      ),
    );
  }

  _buildPartySize() {
    return Card(
      elevation: 10,
      color: SECONDARY_COLOR_4,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: blackTitle("Party Size:", 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new FloatingActionButton(
                  heroTag: "btn1",
                  onPressed: minus,
                  child: new Icon(
                      const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                      color: Colors.red),
                  backgroundColor: Colors.white,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 8.0, left: 40, right: 40),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  width: 100,
                  height: 100,
                  child: Center(
                    child: new Text('$_n',
                        style: TextStyle(
                            fontSize: 60.0,
                            fontFamily: FONT_TEXT_PRIMARY,
                            color: Color.fromRGBO(
                                15 * _Crindex, 0, 0, _Crindex * 5.0))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: add,
                  child: new Icon(
                    Icons.add,
                    color: Colors.green,
                  ),
                  backgroundColor: Colors.white,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _n.toString(),
                    style: _textStyle(30, Colors.white, "Pacifico"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      " X ",
                      style: _textStyle(30, Colors.white, "Pacifico"),
                    ),
                  ),
                  Text(
                    widget.restruantInfo.currency +
                        _securityPerPerson().toString(),
                    style: _textStyle(30, Colors.white, "Pacifico"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      " = ",
                      style: _textStyle(30, Colors.white, "Pacifico"),
                    ),
                  ),
                  Text(
                    widget.restruantInfo.currency +
                        ((_totalSecurity() < 999)
                            ? _totalSecurity().toString()
                            : formatter.format(_totalSecurity())),
                    style: _textStyle(30, Colors.white, "Pacifico"),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "* Average cost per person: " +
                  ((widget.restruantInfo.restruant_Avg_cost_for_two / 2))
                      .toString(),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: _textStyle(25, Colors.white, "Pacifico"),
            ),
          ),
        ],
      ),
    );
  }

  _buildDate() {
    return Card(
      elevation: 10,
      color: SECONDARY_COLOR_4,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: blackTitle("Date: ", 20),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime.now(),
                                maxTime: DateTime.now().add(Duration(days: 7)),
                                onChanged: (date) {},
                                onConfirm: (date) {
                                  setState(() {
                                    _date = date;
                                  });
                                },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: Text(
                            _formatDate(),
                            style: _textStyle(25, Colors.white, "Pacifico"),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildTimeSlot() {
    return Card(
      elevation: 10,
      color: SECONDARY_COLOR_4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: blackTitle("Time Slot:", 20),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(children: <Widget>[
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        color: btnColor_1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        padding: EdgeInsets.all(10.0),
                        child: new Text(
                          "9:45 AM",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: "Montserrat-Bold"),
                        ),
                        onPressed: () {
                          _timeSlot = "9:45 AM";
                          selectedChange();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        color: btnColor_2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        padding: EdgeInsets.all(10.0),
                        child: new Text(
                          "10:00 AM",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: "Montserrat-Bold"),
                        ),
                        onPressed: () {
                          _timeSlot = "10:00 AM";
                          selectedChange();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        color: btnColor_3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        padding: EdgeInsets.all(10.0),
                        child: new Text(
                          "11:00 AM",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: "Montserrat-Bold"),
                        ),
                        onPressed: () {
                          _timeSlot = "11:00 AM";
                          selectedChange();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: FlatButton(
                      color: btnColor_4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      padding: EdgeInsets.all(10.0),
                      child: new Text(
                        "12:00 PM",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: "Montserrat-Bold"),
                      ),
                      onPressed: () {
                        _timeSlot = "12:00 PM";
                        selectedChange();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: FlatButton(
                      color: btnColor_5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      padding: EdgeInsets.all(10.0),
                      child: new Text(
                        "2:45 PM",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: "Montserrat-Bold"),
                      ),
                      onPressed: () {
                        _timeSlot = "2:45 PM";
                        selectedChange();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: FlatButton(
                      color: btnColor_6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      padding: EdgeInsets.all(10.0),
                      child: new Text(
                        "4:00 PM",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: "Montserrat-Bold"),
                      ),
                      onPressed: () {
                        _timeSlot = "4:00 PM";
                        selectedChange();
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      color: btnColor_7,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      padding: EdgeInsets.all(10.0),
                      child: new Text(
                        "6:00 PM",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: "Montserrat-Bold"),
                      ),
                      onPressed: () {
                        _timeSlot = "6:00 PM";
                        selectedChange();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      color: btnColor_8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      padding: EdgeInsets.all(10.0),
                      child: new Text(
                        "8:00 PM",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: "Montserrat-Bold"),
                      ),
                      onPressed: () {
                        _timeSlot = "8:00 PM";
                        selectedChange();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      color: btnColor_9,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      padding: EdgeInsets.all(10.0),
                      child: new Text(
                        "11:00 PM",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: "Montserrat-Bold"),
                      ),
                      onPressed: () {
                        _timeSlot = "11:00 PM";
                        selectedChange();
                      },
                    ),
                  ),
                ],
              ),
            ],),
          ),

        ],
      ),
    );
  }

  void add() {
    setState(() {
      if (_n < 15) {
        _n++;
        _Crindex = _n;
      }
    });
  }

  void minus() {
    setState(() {
      if (_n >= 2) {
        _n--;
        _Crindex = _n;
      }
    });
  }

  void selectedChange() {
    setState(() {
      deSelectAll();
      switch (_timeSlot) {
        case "9:45 AM":
          btnColor_1 = selectedColor;
          break;
        case "10:00 AM":
          btnColor_2 = selectedColor;
          break;
        case "11:00 AM":
          btnColor_3 = selectedColor;
          break;
        case "12:00 PM":
          btnColor_4 = selectedColor;
          break;
        case "2:45 PM":
          btnColor_5 = selectedColor;
          break;
        case "4:00 PM":
          btnColor_6 = selectedColor;
          break;
        case "6:00 PM":
          btnColor_7 = selectedColor;
          break;
        case "8:00 PM":
          btnColor_8 = selectedColor;
          break;
        case "11:00 PM":
          btnColor_9 = selectedColor;
          break;
      }
    });
  }

  void deSelectAll() {
    btnColor_1 = defaultColor;
    btnColor_2 = defaultColor;
    btnColor_3 = defaultColor;
    btnColor_4 = defaultColor;
    btnColor_5 = defaultColor;
    btnColor_6 = defaultColor;
    btnColor_7 = defaultColor;
    btnColor_8 = defaultColor;
    btnColor_9 = defaultColor;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  findTable() async {
    if (_timeSlot != null) {
      _auth.currentUser().then((val) {
        if (val != null) {
          if (GetterSetterUserDetails.firstName != null &&
              GetterSetterUserDetails.lastName != null &&
              GetterSetterUserDetails.dob != null &&
              GetterSetterUserDetails.gender != null &&
              GetterSetterUserDetails.phoneNumber != null &&
              GetterSetterUserDetails.address != null) {
            setData();
            Route route = HorizontalTransition(
                builder: (BuildContext context) => new Transition());
            Navigator.push(context, route);
          } else {
            Route route = HorizontalTransition(
                builder: (BuildContext context) => new Account("BookingPage"));
            Navigator.push(context, route);
          }
        } else {
          Route route = HorizontalTransition(
              builder: (BuildContext context) =>
                  new OnBoardingPage("BookingPage"));
          Navigator.push(context, route);
        }
      });
    } else {
      var snackBar = SnackBar(content: Text("Please select the time slot."));
      booking_scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  void setData() {
    GetterSetterBookingDetails.resId = widget.restruantInfo.restruant_Id;
    GetterSetterBookingDetails.resImageUrl =
        widget.restruantInfo.restruant_Thumb;
    GetterSetterBookingDetails.resName = widget.restruantInfo.restruant_Name;
    GetterSetterBookingDetails.resAddress =
        widget.restruantInfo.restruant_Location.address;
    GetterSetterBookingDetails.resRating =
        widget.restruantInfo.restruant_User_rating.aggregate_rating;
    GetterSetterBookingDetails.noOfTables = _n;
    GetterSetterBookingDetails.avgCost =
        (widget.restruantInfo.restruant_Avg_cost_for_two / 2);
    GetterSetterBookingDetails.securityPerPerson = _securityPerPerson();
    GetterSetterBookingDetails.totalSecrityCost = _totalSecurity();
    if (_date == null) {
      GetterSetterBookingDetails.bookingDate = DateTime.now().day.toString() +
          ":" +
          DateTime.now().month.toString() +
          ":" +
          DateTime.now().year.toString();
    } else {
      GetterSetterBookingDetails.bookingDate = _date.day.toString() +
          ":" +
          _date.month.toString() +
          ":" +
          _date.year.toString();
    }
    GetterSetterBookingDetails.timeSlot = _timeSlot;
    GetterSetterBookingDetails.status = "Reserved";
  }

  _securityPerPerson() {
    return double.parse(((double.parse(widget
                    .restruantInfo.restruant_Avg_cost_for_two
                    .toString()) /
                (2.0 * AVERAGE_TABLE_COST)) <
            999)
        ? (double.parse(widget.restruantInfo.restruant_Avg_cost_for_two
                    .toString()) /
                (2.0 * AVERAGE_TABLE_COST))
            .toString()
        : formatter.format(double.parse(
                widget.restruantInfo.restruant_Avg_cost_for_two.toString()) /
            (2.0 * AVERAGE_TABLE_COST)));
  }

  double _totalSecurity() {
    return _n * double.parse(_securityPerPerson().toString());
  }

  String _formatDate() {
    return (_date == null)
        ? formatDate(
            DateTime.now(),
            (DateTime.now().day == 1)
                ? ['DD', ' , ', 'd', 'st ', 'MM', ' ', 'yy']
                : (DateTime.now().day == 2)
                    ? ['DD', ' , ', 'd', 'nd ', 'MM', ' ', 'yy']
                    : ['DD', ' , ', 'd', 'th ', 'MM', ' ', 'yy'])
        : formatDate(
            _date,
            (_date.day == 1)
                ? ['DD', ' , ', 'd', 'st ', 'MM', ' ', 'yy']
                : (_date.day == 2)
                    ? ['DD', ' , ', 'd', 'nd ', 'MM', ' ', 'yy']
                    : ['DD', ' , ', 'd', 'th ', 'MM', ' ', 'yy']);
  }
}
