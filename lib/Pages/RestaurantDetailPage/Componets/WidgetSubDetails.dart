import 'package:bhukkd/Components/CustomComponets.dart';
import 'package:bhukkd/Constants/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildSubDetails(
    AsyncSnapshot snapshot, BuildContext context, double c_width) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: c_width * 1.2,
              child: new Text(
                snapshot.data.restruant_Name,
                textDirection: TextDirection.ltr,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.start,
                style: new TextStyle(
                  color: Colors.white,
                  fontFamily: FONT_TEXT_EXTRA,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  wordSpacing: 0.5,
                  shadows: [
                    Shadow(
                        // bottomLeft
                        offset: Offset(1.5, 1.5),
                        color: Colors.white,
                        blurRadius: 20),
                    Shadow(
                        // bottomRight
                        offset: Offset(1.5, 1.5),
                        color: Colors.black54,
                        blurRadius: 5),
                    Shadow(
                        // topRight
                        offset: Offset(1.5, 1.5),
                        color: Colors.black54,
                        blurRadius: 5),
                    Shadow(
                        // topLeft
                        offset: Offset(1.5, 1.5),
                        color: Colors.black54,
                        blurRadius: 5),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: c_width * 0.2,
            ),
            DecoratedBox(
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child:
                      Text(snapshot.data.restruant_User_rating.aggregate_rating,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: FONT_TEXT_PRIMARY,
                            fontSize: 25,
                          ))),
              decoration: BoxDecoration(
                color: Color.fromARGB(
                    240,
                    200 -
                        int.parse(snapshot
                                .data.restruant_User_rating.aggregate_rating
                                .toString()[0]) *
                            100,
                    80,
                    0),
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
          padding: EdgeInsets.only(top: 10, left: 10, bottom: 5),
          child: Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: c_width,
                    child: Text(
                      snapshot.data.restruant_Location.locality_verbose,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: FONT_TEXT_SECONDARY,
                        fontWeight: FontWeight.normal,
                        color: TEXT_SECONDARY_COLOR,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                          width: c_width,
                          child: Text(
                            snapshot.data.restruant_Cuisines,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: FONT_TEXT_PRIMARY,
                                color: Colors.black54),
                          ))),
                ],
              ),
              Container(
                alignment: Alignment.bottomRight,
                height: MediaQuery.of(context).size.height * 0.05,
                width: c_width * 0.75,
                child: snapshot.data.restruant_Is_delivery_now == 0
                    ? Text(
                        "Closed",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: FONT_TEXT_PRIMARY,
                          fontSize: 25,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                      )
                    : Text(
                        "Open",
                        style: TextStyle(
                          color: Colors.green,
                          fontFamily: FONT_TEXT_PRIMARY,
                          fontSize: 25,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                      ),
              ),
            ],
          )),
      SizedBox(
        height: 5,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              "Average Cost for Two",
              style: TextStyle(
                fontFamily: FONT_TEXT_SECONDARY,
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              '₹ ' +
                  ((snapshot.data.restruant_Avg_cost_for_two < 999)
                      ? snapshot.data.restruant_Avg_cost_for_two.toString()
                      : formatter
                          .format(snapshot.data.restruant_Avg_cost_for_two)),
              style: TextStyle(
                  color: TEXT_SECONDARY_COLOR,
                  fontFamily: FONT_TEXT_PRIMARY,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          )
        ]),
      ),
      SizedBox(
        height: 20,
      ),
    ],
  );
}
