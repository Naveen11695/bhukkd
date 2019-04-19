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
        new Calender(margin: listSlidePosition.value * 6.0),
        Container(
          child: Column(
            children: <Widget>[
              InkWell(
                  onTap: () {
                    print("Account");
                  },
                  splashColor: Colors.black45,
                  highlightColor: Colors.black45,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    child: new ListData(
                        width: listTileWidth.value,
                        title: "My Account",
                        subtitle:
                            "Change your email/password or delete your account.",
                        image: user),
                  )),
              InkWell(
                onTap: () {
                  print("Privacy");
                },
                splashColor: Colors.black45,
                highlightColor: Colors.black45,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: new ListData(
                      width: listTileWidth.value,
                      title: "Privacy",
                      subtitle: "Hide your profile from search engines",
                      image: privacy),
                ),
              ),
              InkWell(
                onTap: () {
                  print("Payment");
                },
                splashColor: Colors.black45,
                highlightColor: Colors.black45,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: new ListData(
                      width: listTileWidth.value,
                      title: "Manage Payment Options",
                      subtitle: "Address, Favourites, Refrerrals & Offers",
                      image: paymentOption),
                ),
              ),
              InkWell(
                onTap: () {
                  print("Bookings");
                },
                splashColor: Colors.black45,
                highlightColor: Colors.black45,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: new ListData(
                      width: listTileWidth.value,
                      title: "Your Bookings",
                      subtitle: "Past booking history",
                      image: bookings),
                ),
              ),
              InkWell(
                onTap: () {
                  print("Help");
                },
                splashColor: Colors.black45,
                highlightColor: Colors.black45,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: new ListData(
                      width: listTileWidth.value,
                      title: "Help",
                      subtitle: "FAQ & Link",
                      image: help),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
