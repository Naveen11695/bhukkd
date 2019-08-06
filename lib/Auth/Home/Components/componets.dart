import 'package:bhukkd/Auth/Home/Components/List.dart';
import 'package:flutter/material.dart';

Widget homeOptionBox(Animation<double> listTileWidth, String heading,
    String subHeading, DecorationImage icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
    child: new ListData(
        width: listTileWidth.value,
        title: heading,
        subtitle: subHeading,
        image: icon),
  );
}
