import 'package:flutter/material.dart';
import 'List.dart';
import 'Calender.dart';
import '../Screens/Home/styles.dart';

class ListViewContent extends StatelessWidget {
  final Animation<double> listTileWidth;
  final Animation<Alignment> listSlideAnimation;
  final Animation<EdgeInsets> listSlidePosition;
  ListViewContent({
    this.listSlideAnimation,
    this.listSlidePosition,
    this.listTileWidth,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: listSlideAnimation.value,
      children: <Widget>[
        new Calender(margin: listSlidePosition.value * 5.5),
        Column(children: <Widget>[
          new ListData(
              width: listTileWidth.value,
              title: "My Account",
              subtitle: "Change your email/password or delete your account.",
              image: user),
          new ListData(
              width: listTileWidth.value,
              title: "Privacy",
              subtitle: "Hide your profile from search engines",
              image: privacy),
          new ListData(
              width: listTileWidth.value,
              title: "Manage Payment Options",
              subtitle: "Address, Favourites, Refrerrals & Offers",
              image: paymentOption),
          new ListData(
              width: listTileWidth.value,
              title: "Your Bookings",
              subtitle: "Past booking history",
              image: bookings),
          new ListData(
              width: listTileWidth.value,
              title: "Help",
              subtitle: "FAQ & Link",
              image: help),
        ],),
      ],
    );
  }
}

