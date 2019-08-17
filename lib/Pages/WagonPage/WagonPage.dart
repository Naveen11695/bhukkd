import 'package:bhukkd/Auth/Home/GetterSetter/GetterSetterBookingDetails.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class WagonPage extends StatefulWidget {
  WagonPage({Key key}) : super(key: key);

  @override
  _WagonPageState createState() => new _WagonPageState();
}

class _WagonPageState extends State<WagonPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _uid;
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: FutureBuilder(
              future: _auth.currentUser(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null) {
                    _uid = snapshot.data.uid;
                    _email = snapshot.data.email;
                    return FutureBuilder(
                        future: _getUserBooking(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.data != null) {
                              return CustomScrollView(
                                slivers: <Widget>[
                                  SliverAppBar(
                                    elevation: 10,
                                    floating: false,
                                    pinned: true,
                                    expandedHeight: 160,
                                    backgroundColor: SECONDARY_COLOR_1,
                                    title: Text(
                                      "Past Bookings",
                                      style: TextStyle(
                                          fontFamily: FONT_TEXT_PRIMARY,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          wordSpacing: 2.0,
                                          letterSpacing: 1.0,
                                          color: Colors.white),
                                    ),
                                  ),
                                  SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                        return ExpansionTile(
                                          key: PageStorageKey<String>("list"),
                                          title: ListTile(
                                            title: Text(
                                              snapshot.data[index]['_resName'],
                                              style: new TextStyle(
                                                  fontSize: 25.0,
                                                  fontFamily: FONT_TEXT_PRIMARY,
                                                  fontWeight: FontWeight.w600,
                                                  color: TEXT_PRIMARY_COLOR,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                            leading: ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl: snapshot.data[index]
                                                    ['_resImageUrl'],
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            trailing: Text(
                                              snapshot.data[index]['_timeSlot']
                                                  .toString(),
                                              style: new TextStyle(
                                                  fontSize: 15.0,
                                                  fontFamily: FONT_TEXT_PRIMARY,
                                                  fontWeight: FontWeight.w300,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            subtitle: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, bottom: 8.0),
                                              child: Text(
                                                _formatDate(
                                                  DateTime(
                                                      _getDate(
                                                          snapshot.data[index]
                                                              ['_bookingDate'],
                                                          2),
                                                      _getDate(
                                                          snapshot.data[index]
                                                              ['_bookingDate'],
                                                          1),
                                                      _getDate(
                                                          snapshot.data[index]
                                                              ['_bookingDate'],
                                                          0)),
                                                ),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily:
                                                        FONT_TEXT_SECONDARY,
                                                    color: TEXT_SECONDARY_COLOR,
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                          ),
                                          children: <Widget>[
                                            new Column(
                                              children: _buildExpandableContent(
                                                  snapshot.data[index]),
                                            ),
                                          ],
                                        );
                                      },
                                      childCount: snapshot.data.length,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Container(
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/not_found.gif",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            }
                          } else {
                            return Container(
                              child: Center(
                                child: new FlareActor(
                                  "assets/animations/loading_Untitled.flr",
                                  animation: "Untitled",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          }
                        });
                  } else {
                    return Container(
                      child: Center(
                        child: Image.asset(
                          "assets/images/not_found.gif",
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  }
                } else {
                  return Container(
                    child: Center(
                      child: new FlareActor(
                        "assets/animations/loading_Untitled.flr",
                        animation: "Untitled",
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                }
              })),
    );
  }

  _getUserBooking() async {
    var snapShort = [];
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("BookingDetails").getDocuments();
    var list = querySnapshot.documents;
    for (var val in list) {
      if (val.data["EmailId"] == _email.trim().toUpperCase())
        snapShort.add(val.data);
    }
    if (snapShort.length != 0) {
      return snapShort;
    }
  }

  _buildExpandableContent(Map snapShort) {
    List<Widget> columnContent = [];
    columnContent.add(
      Column(
        children: <Widget>[
          new ListTile(
            title: new Text(
              snapShort["_resAddress"].toString(),
              style: new TextStyle(
                  fontFamily: FONT_TEXT_PRIMARY,
                  fontSize: 15.0,
                  color: Colors.black54),
            ),
            leading: Icon(
              FontAwesomeIcons.hotel,
              color:
                  (snapShort["_status"].toString().compareTo("canceled") == 0)
                      ? Colors.red
                      : !(_islessThanNow(
                      snapShort["_bookingDate"], snapShort["_status"]))
                      ? Colors.green
                      : SECONDARY_COLOR_1,
            ),
            trailing: new Text(
              "For " + snapShort["_noOfTables"].toString() + " people.",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: FONT_TEXT_PRIMARY,
                  color: TEXT_SECONDARY_COLOR,
                  fontSize: 18.0),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Text(
                snapShort["_noOfTables"].toString() +
                    " X " +
                    ((snapShort["_securityPerPerson"] < 999)
                        ? snapShort["_securityPerPerson"].toString()
                        : formatter.format(snapShort["_securityPerPerson"])) +
                    " = " +
                    ((snapShort["_totalSecrityCost"] < 999)
                        ? snapShort["_totalSecrityCost"].toString()
                        : formatter.format(snapShort["_totalSecrityCost"])),
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: FONT_TEXT_SECONDARY,
                    fontSize: 18.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    _viewDetails(snapShort);
                  },
                  splashColor: Colors.white24,
                  highlightColor: Colors.white10,
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.30,
                    child: Center(
                      child: Text(
                        "View The Details",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontSize: 15.0,
                            fontFamily: FONT_TEXT_PRIMARY,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.8,
                            wordSpacing: 0.0,
                            textBaseline: TextBaseline.ideographic,
                            color: TEXT_PRIMARY_COLOR),
                      ),
                    ),
                  ),
                ),
                !(_islessThanNow(
                        snapShort["_bookingDate"], snapShort["_status"]))
                    ? Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0),
                            child: Text(
                              " | ",
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: FONT_TEXT_PRIMARY,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.8,
                                  wordSpacing: 0.0,
                                  textBaseline: TextBaseline.ideographic,
                                  color: TEXT_PRIMARY_COLOR),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _cancelBooking(context, snapShort["_resId"]);
                            },
                            splashColor: Colors.white24,
                            highlightColor: Colors.white10,
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.30,
                              child: Center(
                                child: Text(
                                  "Cancel The Bookings",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: FONT_TEXT_PRIMARY,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.8,
                                      wordSpacing: 0.0,
                                      textBaseline: TextBaseline.ideographic,
                                      color: TEXT_PRIMARY_COLOR),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          )
        ],
      ),
    );
    return columnContent;
  }

  int _getDate(String date, int index) {
    return int.parse(date.toString().split(":")[index]);
  }

  String _formatDate(DateTime _date) {
    return formatDate(
        _date,
        (_date.day == 1)
            ? ['DD', ' , ', 'd', 'st ', 'MM', ' ', 'yy']
            : (_date.day == 2)
                ? ['DD', ' , ', 'd', 'nd ', 'MM', ' ', 'yy']
                : ['DD', ' , ', 'd', 'th ', 'MM', ' ', 'yy']);
  }

  _islessThanNow(String date, String status) {
    if (DateTime.now().isAfter(
        DateTime(_getDate(date, 2), _getDate(date, 1), _getDate(date, 0)))) {
      return true;
    } else {
      if ((status.compareTo("canceled") == 0)) {
        return true;
      } else {
        return false;
      }
    }
  }

  _cancelBooking(BuildContext context, String resId) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Cancel The Booking",
      desc: "Do you want to cancel the booking ?",
      buttons: [
        DialogButton(
          child: Text(
            "Proceed",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            setState(() {
              _changeStatusToCanceled(resId);
            });
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  void _changeStatusToCanceled(String resid) async {
    var fireStore = Firestore.instance;
    DocumentReference documentReference =
        fireStore.collection('BookingDetails').document(_uid + "-" + resid);
    documentReference.get().then((dataSnapshot) {
      if (dataSnapshot.exists) {
        documentReference.updateData({"_status": "canceled"}).whenComplete(() {
          GetterSetterBookingDetails.status = "canceled";
          Navigator.pop(context);
        }).catchError((e) {
          print("Error: UserDetails update" + e.toString());
        });
      }
    });
  }

  void _viewDetails(Map snapshot) {
    Alert(
        context: context,
        title: "Booking Details",
        content: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(FontAwesomeIcons.userCircle),
              title: Text('Name'),
              subtitle: Text(snapshot["FirstName"].toString().toUpperCase() +
                  " " +
                  snapshot["LastName"].toString().toUpperCase()),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.mobile),
              title: Text('Phone Number'),
              subtitle: Text(
                snapshot["PhoneNumber"].toString().toUpperCase(),
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.idBadge),
              title: Text('OrderId'),
              subtitle: Text(snapshot["OrderId"].toString().toUpperCase()),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.hotel),
              title: Text('Restaurant'),
              subtitle: Text(snapshot["_resName"].toString().toUpperCase()),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.ccVisa),
              title: Text('Payment'),
              subtitle: Text(
                "Rs. " + snapshot["_totalSecrityCost"].toString().toUpperCase(),
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.checkDouble),
              title: Text('Booking Status'),
              subtitle: Text(
                snapshot["_status"].toString().toUpperCase(),
                style: TextStyle(
                    color:
                        (snapshot["_status"].toString().compareTo("canceled") ==
                                0)
                            ? Colors.red
                            : Colors.green),
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: SECONDARY_COLOR_1,
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
