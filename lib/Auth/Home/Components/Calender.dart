import 'package:bhukkd/Constants/app_constant.dart';
import 'package:flutter/material.dart';

import 'CalenderCell.dart';

class Calender extends StatelessWidget {
  final EdgeInsets margin;
  final List<String> week = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
  final List arrayDay = [];

  Calender({this.margin});

  int totaldays(int month, int year) {
    if (month == 2) {
      if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0))
        return (29);
      else
        return (28);
    } else if (month == 4 || month == 6 || month == 9 || month == 11)
      return (30);
    else
      return (31);
  }

  @override
  Widget build(BuildContext context) {
    int element = new DateTime.now().day - new DateTime.now().weekday;
    int totalDay = totaldays(new DateTime.now().month, DateTime
        .now()
        .year);
    if (DateTime
        .now()
        .day < 15) {
      totalDay = totaldays(new DateTime.now().month - 1, DateTime
          .now()
          .year);
    }
    for (var i = 0; i <= 7; i++) {
      if (element > totalDay) element = 1;
      if (element <= 0) {
        element += totalDay;
      }
      arrayDay.add(element);
      element++;
    }
    var i = 0;
    return (new Container(
      margin: margin,
      alignment: Alignment.center,
      padding: new EdgeInsets.only(top: 50.0),
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(50.0),
              topRight: const Radius.circular(50.0))),
      child: Column(
        children: <Widget>[
          new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: week.map((String week) {
                i++;
                return new CalenderCell(
                    week: week,
                    day: arrayDay[i].toString(),
                    today:
                    arrayDay[i] != new DateTime.now().day ? false : true);
              }).toList()),
          Container(
            height: 5.0,
            width: double.infinity,
            color: TEXT_SECONDARY_COLOR,
            child: Text(""),
          )
        ],
      ),
    ));
  }
}
