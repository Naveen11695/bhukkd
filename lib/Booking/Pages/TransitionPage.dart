import 'dart:async';
import 'dart:math';

import 'package:bhukkd/Auth/Home/GetterSetter/GetterSetterBookingDetails.dart';
import 'package:bhukkd/Auth/Home/GetterSetter/GetterSetterUserDetails.dart';
import 'package:bhukkd/Booking/Pages/payment_success_page.dart';
import 'package:bhukkd/Components/CustomTransition.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Transition extends StatefulWidget {
  @override
  TransitionState createState() => TransitionState();
}

class TransitionState extends State<Transition> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String uid;

  @override
  void initState() {
    super.initState();
    delayTimer();
  }

  Future delayTimer() async {
    Duration duration = new Duration(seconds: 10);
    await _auth.currentUser().then((val) {
      uid = val.uid;
      return new Timer(duration, sendDataToFireStore);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SECONDARY_COLOR_1,
      body: Stack(
        children: [
          FlareActor(
            "assets/animations/loading_2.flr",
            animation: "Untitled",
            fit: BoxFit.contain,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 350.0),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  "Booking the tables for " +
                      GetterSetterBookingDetails.noOfTables.toString() +
                      " people.",
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      shadows: [
                        Shadow(
                            // bottomLeft
                            offset: Offset(-1.5, -1.5),
                            color: Colors.black54),
                        Shadow(
                            // bottomRight
                            offset: Offset(1.5, -1.5),
                            color: Colors.black54),
                        Shadow(
                            // topRight
                            offset: Offset(1.5, 1.5),
                            color: Colors.black54),
                        Shadow(
                            // topLeft
                            offset: Offset(-1.5, 1.5),
                            color: Colors.black54),
                      ],
                      fontSize: 30.0,
                      fontFamily: "Pacifico",
                      letterSpacing: 2.5,
                      wordSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                      textBaseline: TextBaseline.ideographic,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sendDataToFireStore() async {
    var rndnumber = "";
    var rnd = new Random();
    for (var i = 0; i < 6; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    GetterSetterBookingDetails.bookingId = uid +
        "-" +
        GetterSetterBookingDetails.resId +
        "-" +
        GetterSetterBookingDetails.bookingDate.replaceAll(":", "") +
        "-" +
        GetterSetterBookingDetails.timeSlot.split(" ")[0] +
        "-" +
        rndnumber;
    print(rndnumber);
    Firestore.instance
        .collection("BookingDetails")
        .document(GetterSetterBookingDetails.bookingId)
        .setData({
      "OrderId": GetterSetterBookingDetails.bookingId,
      "FirstName": GetterSetterUserDetails.firstName.trim().toUpperCase(),
      "MiddleName": GetterSetterUserDetails.middleName.trim().toUpperCase(),
      "LastName": GetterSetterUserDetails.lastName.trim().toUpperCase(),
      "Gender": GetterSetterUserDetails.gender,
      "PhoneNumber": GetterSetterUserDetails.phoneNumber,
      "EmailId": GetterSetterUserDetails.emailId.trim().toUpperCase(),
      "Address": GetterSetterUserDetails.address,
      "_resId": GetterSetterBookingDetails.resId.trim().toUpperCase(),
      "_resImageUrl": GetterSetterBookingDetails.resImageUrl,
      "_resName": GetterSetterBookingDetails.resName.trim(),
      "_resAddress": GetterSetterBookingDetails.resAddress.trim(),
      "_resRating": GetterSetterBookingDetails.resRating.trim(),
      "_noOfTables": GetterSetterBookingDetails.noOfTables,
      "_avgCost": GetterSetterBookingDetails.avgCost,
      "_securityPerPerson": GetterSetterBookingDetails.securityPerPerson,
      "_totalSecrityCost": GetterSetterBookingDetails.totalSecrityCost,
      "_bookingDate": GetterSetterBookingDetails.bookingDate.trim(),
      "_timeSlot": GetterSetterBookingDetails.timeSlot.trim(),
      "_status": GetterSetterBookingDetails.status.trim(),
      "_timeStamp": GetterSetterBookingDetails.bookingDate.split(":")[2] +
          (GetterSetterBookingDetails.bookingDate.split(":")[1].length == 1
              ? "0" + GetterSetterBookingDetails.bookingDate.split(":")[1]
              : GetterSetterBookingDetails.bookingDate.split(":")[1]) +
          (GetterSetterBookingDetails.bookingDate.split(":")[0].length == 1
              ? "0" + GetterSetterBookingDetails.bookingDate.split(":")[0]
              : GetterSetterBookingDetails.bookingDate.split(":")[0]) +
          'T' +
          (DateTime
              .now()
              .hour
              .toString()
              .length == 1
              ? "0" + DateTime
              .now()
              .hour
              .toString()
              : DateTime
              .now()
              .hour
              .toString()) +
          (DateTime
              .now()
              .minute
              .toString()
              .length == 1
              ? "0" + DateTime
              .now()
              .minute
              .toString()
              : DateTime
              .now()
              .minute
              .toString()) +
          (DateTime
              .now()
              .second
              .toString()
              .length == 1
              ? "0" + DateTime
              .now()
              .second
              .toString()
              : DateTime
              .now()
              .second
              .toString()),
    }).whenComplete(() {
      print("Successfull: BookingDetails add");
      Route route = HorizontalTransition(
          builder: (BuildContext context) => new PaymentSuccessPage());
      Navigator.push(context, route);
    }).catchError((e) {
      print("Error: BookingDetails add" + e.toString());
    });
  }
}
