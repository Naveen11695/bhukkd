import 'dart:async';

import 'package:bhukkd/Auth/Home/GetterSetter/GetterSetterUserDetails.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreditCardPage extends StatelessWidget {
  static List<Color> kitGradients = [
    // new Color.fromRGBO(103, 218, 255, 1.0),
    // new Color.fromRGBO(3, 169, 244, 1.0),
    // new Color.fromRGBO(0, 122, 193, 1.0),
    Colors.blueGrey.shade800,
    Colors.black87,
  ];
  BuildContext _context;
  CreditCardBloc cardBloc;
  MaskedTextController ccMask =
      MaskedTextController(mask: "0000 0000 0000 0000");
  MaskedTextController expMask = MaskedTextController(mask: "00/00");

  static const String ralewayFont = FONT_TEXT_SECONDARY;

  Widget bodyData() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[creditCardWidget(), fillEntries()],
        ),
      );

  Widget creditCardWidget() {
    var deviceSize = MediaQuery.of(_context).size;
    return Container(
      height: deviceSize.height * 0.3,
      color: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 3.0,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: kitGradients)),
              ),
              Opacity(
                opacity: 0.1,
                child: Image.asset(
                  "assets/images/map.png",
                  fit: BoxFit.cover,
                ),
              ),
              MediaQuery.of(_context).orientation == Orientation.portrait
                  ? cardEntries()
                  : FittedBox(
                      child: cardEntries(),
                    ),
              Positioned(
                right: 10.0,
                top: 10.0,
                child: Icon(
                  FontAwesomeIcons.ccVisa,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
              Positioned(
                right: 10.0,
                bottom: 10.0,
                child: StreamBuilder<String>(
                  stream: cardBloc.nameOutputStream,
                  initialData: GetterSetterUserDetails.firstName +
                      ' ' +
                      GetterSetterUserDetails.lastName,
                  builder: (context, snapshot) => Text(
                    snapshot.data.length > 0
                        ? snapshot.data.toUpperCase()
                        : GetterSetterUserDetails.firstName.toUpperCase() +
                            ' ' +
                            GetterSetterUserDetails.lastName.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: ralewayFont,
                        fontSize: 20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardEntries() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder<String>(
                stream: cardBloc.ccOutputStream,
                initialData: "**** **** **** ****",
                builder: (context, snapshot) {
                  snapshot.data.length > 0
                      ? ccMask.updateText(snapshot.data)
                      : null;
                  return Text(
                    snapshot.data.length > 0
                        ? snapshot.data
                        : "**** **** **** ****",
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StreamBuilder<String>(
                    stream: cardBloc.expOutputStream,
                    initialData: "MM/YY",
                    builder: (context, snapshot) {
                      snapshot.data.length > 0
                          ? expMask.updateText(snapshot.data)
                          : null;
                      return ProfileTile(
                        textColor: Colors.white,
                        title: "Expiry",
                        subtitle:
                            snapshot.data.length > 0 ? snapshot.data : "MM/YY",
                      );
                    }),
                SizedBox(
                  width: 30.0,
                ),
                StreamBuilder<String>(
                    stream: cardBloc.cvvOutputStream,
                    initialData: "***",
                    builder: (context, snapshot) => ProfileTile(
                          textColor: Colors.white,
                          title: "CVV",
                          subtitle:
                              snapshot.data.length > 0 ? snapshot.data : "***",
                        )),
              ],
            ),
          ],
        ),
      );

  Widget fillEntries() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: ccMask,
              keyboardType: TextInputType.number,
              maxLength: 19,
              style: TextStyle(fontFamily: ralewayFont, color: Colors.black),
              onChanged: (out) => cardBloc.ccInputSink.add(ccMask.text),
              decoration: InputDecoration(
                  labelText: "Credit Card Number",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder()),
            ),
            TextField(
              controller: expMask,
              keyboardType: TextInputType.number,
              maxLength: 5,
              style: TextStyle(fontFamily: ralewayFont, color: Colors.black),
              onChanged: (out) => cardBloc.expInputSink.add(expMask.text),
              decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  labelText: "MM/YY",
                  border: OutlineInputBorder()),
            ),
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 3,
              style: TextStyle(fontFamily: ralewayFont, color: Colors.black),
              onChanged: (out) => cardBloc.cvvInputSink.add(out),
              decoration: InputDecoration(
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  labelText: "CVV",
                  border: OutlineInputBorder()),
            ),
            TextField(
              keyboardType: TextInputType.text,
              maxLength: 20,
              style: TextStyle(fontFamily: ralewayFont, color: Colors.black),
              onChanged: (out) => cardBloc.nameInputSink.add(out),
              decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  labelText: "Name on card",
                  border: OutlineInputBorder()),
            ),
          ],
        ),
      );

  Widget floatingBar() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Ink(
              decoration: ShapeDecoration(
                  shape: StadiumBorder(),
                  gradient: LinearGradient(colors: kitGradients)),
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pop(_context);
                },
                backgroundColor: Colors.transparent,
                icon: Icon(
                  FontAwesomeIcons.gratipay,
                  color: Colors.white,
                ),
                label: Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100.0),
                  child: Text(
                    "ADD THE CARD",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    _context = context;
    cardBloc = CreditCardBloc();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(child: bodyData()),
      floatingActionButton: floatingBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ProfileTile extends StatelessWidget {
  final title;
  final subtitle;
  final textColor;

  ProfileTile({this.title, this.subtitle, this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w700, color: textColor),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          subtitle,
          style: TextStyle(
              fontSize: 15.0, fontWeight: FontWeight.normal, color: textColor),
        ),
      ],
    );
  }
}

class CreditCardBloc {
  final ccInputController = StreamController<String>();
  final expInputController = StreamController<String>();
  final cvvInputController = StreamController<String>();
  final nameInputController = StreamController<String>();

  Sink<String> get ccInputSink => ccInputController.sink;

  Sink<String> get expInputSink => expInputController.sink;

  Sink<String> get cvvInputSink => cvvInputController.sink;

  Sink<String> get nameInputSink => nameInputController.sink;

  final ccOutputController = StreamController<String>();
  final expOutputController = StreamController<String>();
  final cvvOutputController = StreamController<String>();
  final nameOutputController = StreamController<String>();

  Stream<String> get ccOutputStream => ccOutputController.stream;

  Stream<String> get expOutputStream => expOutputController.stream;

  Stream<String> get cvvOutputStream => cvvOutputController.stream;

  Stream<String> get nameOutputStream => nameOutputController.stream;

  CreditCardBloc() {
    ccInputController.stream.listen(onCCInput);
    expInputController.stream.listen(onExpInput);
    cvvInputController.stream.listen(onCvvInput);
    nameInputController.stream.listen(onNameInput);
  }

  onCCInput(String input) {
    ccOutputController.add(input.toString());
  }

  onExpInput(String input) {
    expOutputController.add(input);
  }

  onCvvInput(String input) {
    cvvOutputController.add(input);
  }

  onNameInput(String input) {
    nameOutputController.add(input);
  }

  void ccFormat(String s) {
    print(s);
    ccInputSink.add(s);
  }

  void dispose() {
    ccInputController?.close();
    cvvInputController?.close();
    expInputController?.close();
    nameInputController?.close();
  }
}
