import 'package:flutter/material.dart';
import 'styles.dart';

class RowBoxData {
  String title;
  String subtitle;
  DecorationImage image;
  RowBoxData({this.subtitle, this.title, this.image});
}

class DataListBuilder {
  List<RowBoxData> rowItemList = new List<RowBoxData>();
  RowBoxData row2 = new RowBoxData(
      title: "Yoga classes with Emily",
      subtitle: "7 - 8am Workout",
      image: avatar6);
  RowBoxData row3 = new RowBoxData(
      title: "Yoga classes with Emily",
      subtitle: "7 - 8am Workout",
      image: avatar6);
  RowBoxData row8 = new RowBoxData(
      title: "Yoga classes with Emily",
      subtitle: "7 - 8am Workout",
      image: avatar6);

  DataListBuilder() {
    rowItemList.add(row2);
    rowItemList.add(row3);
    rowItemList.add(row8);
  }
}
