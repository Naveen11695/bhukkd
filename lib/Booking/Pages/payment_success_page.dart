import 'dart:async';
import 'dart:ui';

import 'package:bhukkd/Auth/Home/GetterSetter/GetterSetterBookingDetails.dart';
import 'package:bhukkd/Auth/Home/GetterSetter/GetterSetterUserDetails.dart';
import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Services/HttpRequest.dart';
import 'package:date_format/date_format.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class PaymentSuccessPage extends StatefulWidget {
  @override
  PaymentSuccessPageState createState() {
    return new PaymentSuccessPageState();
  }
}

class PaymentSuccessPageState extends State<PaymentSuccessPage> {
  bool isDataAvailable = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((_) => goToDialog());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    showSuccessDialog();
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
                  "Connecting to merchant account. Please do not close the app.",
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

  void showSuccessDialog() {
    setState(() {
      isDataAvailable = false;
      Future.delayed(Duration(seconds: 3)).then((_) => goToDialog());
    });
  }

  sendMessage() async {
    Iterable<dynamic> key =
        (await parseJsonFromAssets('assets/api/config.json')).values;
    String apiKey = key.elementAt(7);
    String message =
        "hi ${GetterSetterUserDetails.firstName.toLowerCase()}, "
        "Your booking order-id is \"${GetterSetterBookingDetails.bookingId}\n\""
        "Thank you, a member of staff will process your booking request and will confirm with you shortly.";
    String sender = "TXTLCL";
    String number = GetterSetterUserDetails.phoneNumber.trim();

    try {
      getKey();
      final response =
      await http.get(Uri.encodeFull("https://api.textlocal.in/send/?"
          "apikey=$apiKey"
          "&message=$message"
          "&sender=$sender"
          "&numbers=$number"));
      if (response.statusCode == 200) {
        print("Sucessfully delivered " + response.body);
      } else {
        print("SMS failed to delivered");
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("<SMS exception>" + e.toString());
    }
  }


  goToDialog() {
    //sendMessage();  <------ Send SMS to User---------------------------------------------------------------------------------------------------------

      isDataAvailable = true;
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/HomePage', (Route r) => r == null);
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    successTicket(),
                    SizedBox(
                      height: 10.0,
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ));
  }

  successTicket() => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Material(
          clipBehavior: Clip.antiAlias,
          elevation: 2.0,
          borderRadius: BorderRadius.circular(4.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Thank You!",
                    style: TextStyle(
                        color: TEXT_PRIMARY_COLOR,
                        fontFamily: FONT_TEXT_SECONDARY,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Your transaction was successful"),
                ),
                ListTile(
                  title: Text("Date"),
                  subtitle: Text(formatDate(
                      DateTime.now(), ['dd', ' ', 'M', ' ', 'yyyy'])),
                  trailing: Text(formatDate(
                      DateTime.now(), ['hh', ' : ', 'nn', ' ', 'am'])),
                ),
                ListTile(
                  title: Text(GetterSetterUserDetails.firstName +
                      ' ' +
                      GetterSetterUserDetails.lastName),
                  subtitle: Text(
                    GetterSetterUserDetails.emailId,
                    style: TextStyle(
                        fontFamily: FONT_TEXT_PRIMARY,
                        color: TEXT_SECONDARY_COLOR),
                  ),
                  trailing: Icon(
                    FontAwesomeIcons.userCircle,
                    color: SECONDARY_COLOR_1,
                    size: 25,
                  ),
                ),
                ListTile(
                  title: Text("Amount"),
                  subtitle: Text(" Rs. " +
                      ((GetterSetterBookingDetails.totalSecrityCost < 999)
                          ? GetterSetterBookingDetails.totalSecrityCost
                              .toString()
                          : formatter.format(
                              GetterSetterBookingDetails.totalSecrityCost))),
                  trailing: Text(
                    "Completed",
                    style: TextStyle(
                        color: Colors.green, fontFamily: FONT_TEXT_SECONDARY),
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 0.0,
                  color: Colors.grey.shade300,
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.ccVisa,
                      color: Colors.blue,
                    ),
                    title: Text("Credit/Debit Card"),
                    subtitle: Text("Your Card ending ***6"),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
