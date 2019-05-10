import 'package:bhukkd/Auth/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget otpField(BuildContext context) {
  return Row(
    children: <Widget>[
      Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(249, 129, 42, 1),
            ),
            shape: BoxShape.circle,
            color: Colors.white),
        child: Center(
          child: TextField(
            controller: otp1,
            //autofocus: true,
            focusNode: focus1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: new TextStyle(
                color: Color.fromRGBO(249, 129, 42, 1), fontSize: 28),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "-",
            ),
            onChanged: (String newVal) {
              if (newVal.length == 1) {
                focus1.unfocus();
                FocusScope.of(context).requestFocus(focus2);
              }
            },
          ),
        ),
      ),
      SizedBox(
        width: 5,
      ),
      Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(249, 129, 42, 1),
            ),
            shape: BoxShape.circle,
            color: Colors.white),
        child: Center(
          child: TextField(
            controller: otp2,
            textAlign: TextAlign.center,
            focusNode: focus2,
            keyboardType: TextInputType.number,
            style: new TextStyle(
                color: Color.fromRGBO(249, 129, 42, 1), fontSize: 28),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "-",
            ),
            onChanged: (String newVal) {
              if (newVal.length == 1) {
                focus2.unfocus();
                FocusScope.of(context).requestFocus(focus3);
              }
            },
          ),
        ),
      ),
      SizedBox(
        width: 5,
      ),
      Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(249, 129, 42, 1),
            ),
            shape: BoxShape.circle,
            color: Colors.white),
        child: Center(
          child: TextField(
            controller: otp3,
            textAlign: TextAlign.center,
            focusNode: focus3,
            keyboardType: TextInputType.number,
            style: new TextStyle(
                color: Color.fromRGBO(249, 129, 42, 1), fontSize: 28),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "-",
            ),
            onChanged: (String newVal) {
              if (newVal.length == 1) {
                focus3.unfocus();
                FocusScope.of(context).requestFocus(focus4);
              }
            },
          ),
        ),
      ),
      SizedBox(
        width: 5,
      ),
      Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(249, 129, 42, 1),
            ),
            shape: BoxShape.circle,
            color: Colors.white),
        child: Center(
          child: TextField(
            controller: otp4,
            textAlign: TextAlign.center,
            focusNode: focus4,
            keyboardType: TextInputType.number,
            style: new TextStyle(
                color: Color.fromRGBO(249, 129, 42, 1), fontSize: 28),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "-",
            ),
            onChanged: (String newVal) {
              if (newVal.length == 1) {
                focus4.unfocus();
                FocusScope.of(context).requestFocus(focus5);
              }
            },
          ),
        ),
      ),
      SizedBox(
        width: 5,
      ),
      Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(249, 129, 42, 1),
            ),
            shape: BoxShape.circle,
            color: Colors.white),
        child: Center(
          child: TextField(
            controller: otp5,
            textAlign: TextAlign.center,
            focusNode: focus5,
            keyboardType: TextInputType.number,
            style: new TextStyle(
                color: Color.fromRGBO(249, 129, 42, 1), fontSize: 28),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "-",
            ),
            onChanged: (String newVal) {
              if (newVal.length == 1) {
                focus5.unfocus();
                FocusScope.of(context).requestFocus(focus6);
              }
            },
          ),
        ),
      ),
      SizedBox(
        width: 5,
      ),
      Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(249, 129, 42, 1),
            ),
            shape: BoxShape.circle,
            color: Colors.white),
        child: Center(
          child: TextField(
            controller: otp6,
            textAlign: TextAlign.center,
            focusNode: focus6,
            keyboardType: TextInputType.number,
            style: new TextStyle(
                color: Color.fromRGBO(249, 129, 42, 1), fontSize: 28),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "-",
            ),
            onChanged: (String newVal) {
              if (newVal.length == 1) {
                focus6.unfocus();
              }
            },

          ),
        ),
      ),
    ],
  );
}
