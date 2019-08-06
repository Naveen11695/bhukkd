import 'package:bhukkd/Auth/Home/Components/Animation/styles.dart';
import 'package:bhukkd/Auth/Home/Pages/DetailPage.dart';
import 'package:bhukkd/Auth/Home/Pages/credit_card_page.dart';
import 'package:bhukkd/Components/CustomTransition.dart';
import 'package:bhukkd/Pages/WagonPage/WagonPage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  Navigator.push(
                      context,
                      HorizontalTransition(
                          builder: (BuildContext context) =>
                              Account("LoginPage")));
                },
                splashColor: Colors.black45,
                highlightColor: Colors.black45,
                child: homeOptionBox(listTileWidth, "Account",
                    "Address, email, password or delete your account.", user),
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
                  Navigator.push(
                      context,
                      HorizontalTransition(
                          builder: (BuildContext context) =>
                              CreditCardPage()));
                },
                splashColor: Colors.black45,
                highlightColor: Colors.black45,
                child:
                homeOptionBox(listTileWidth, "Manage Payment Options", "Address, Favourites, Refrerrals & Offers", paymentOption),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      HorizontalTransition(
                          builder: (BuildContext context) =>
                              WagonPage(key: PageStorageKey("WagonPage"))));
                },
                splashColor: Colors.black45,
                highlightColor: Colors.black45,
                child:
                homeOptionBox(listTileWidth, "Your Bookings", "Past booking history", bookings),
              ),
              InkWell(
                onTap: () {
                  _sendMail();
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

  _sendMail() async {
    // Android and iOS
    const uri = 'mailto:naveen.satyam@gmail.com?subject=Possible help with product design.&body=Hi,';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
