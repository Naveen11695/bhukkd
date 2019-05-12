import 'package:flutter/material.dart';
import 'List.dart';
import 'Calender.dart';
import '../Screens/Home/styles.dart';
import 'componets.dart';

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
        Container(
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  print("My Account");
                },
                splashColor: Colors.black45,
                highlightColor: Colors.black45,
                child: homeOptionBox(listTileWidth, "My Account", "Address, email, password or delete your account.", user),
              ),

              InkWell(
                onTap: () {
                  print("Privacy");
                },
                splashColor: Colors.black45,
                highlightColor: Colors.black45,
                child:
                homeOptionBox(listTileWidth, "Privacy", "Hide your profile from search engines", privacy),
              ),
              InkWell(
                onTap: () {
                  print("Payment");
                },
                splashColor: Colors.black45,
                highlightColor: Colors.black45,
                child:
                homeOptionBox(listTileWidth, "Manage Payment Options", "Address, Favourites, Refrerrals & Offers", paymentOption),
              ),
              InkWell(
                onTap: () {
                  print("Bookings");
                },
                splashColor: Colors.black45,
                highlightColor: Colors.black45,
                child:
                homeOptionBox(listTileWidth, "Your Bookings", "Past booking history", bookings),
              ),
              InkWell(
                onTap: () {
                  print("Help");
                },
                splashColor: Colors.black45,
                highlightColor: Colors.black45,
                child:
              homeOptionBox(listTileWidth, "Help", "FAQ & Link", help),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
