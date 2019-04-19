import 'package:bhukkd/Auth/Home/Components/HomeTopView.dart';
import 'package:bhukkd/Auth/Home/Components/ListViewContainer.dart';
import 'package:bhukkd/Auth/Home/Screens/Home/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bhukkd/Auth/LoginPage.dart';

Container willPopScope =  new Container(
      width: screenSize.width,
      height: screenSize.height,
      child: new Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          new ListView(
            shrinkWrap: screenController.value < 1 ? false : true,
            padding: const EdgeInsets.all(0.0),
            children: <Widget>[
              new ImageBackground(
                backgroundImage: backgroundImage,
                containerGrowAnimation: containerGrowAnimation,
                profileImage: profileImage,
              ),
              new ListViewContent(
                listSlideAnimation: listSlideAnimation,
                listSlidePosition: listSlidePosition,
                listTileWidth: listTileWidth,
              )
            ],
          ),
        ],
    ),
);
