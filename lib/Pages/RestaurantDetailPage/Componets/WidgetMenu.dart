import 'dart:ui';

import 'package:bhukkd/Constants/app_constant.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

Widget buildMenu(AsyncSnapshot snapShot, BuildContext context, double c_width) {
  return ListView.builder(
    shrinkWrap: true,
    cacheExtent: 3,
    scrollDirection: Axis.horizontal,
    itemCount: snapShot.data.length >= 3 ? 3 : snapShot.data.length,
    itemBuilder: (BuildContext context, int index) {
      int _index = index;
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  Scaffold(
                    backgroundColor: Colors.black,
                    appBar: AppBar(
                      leading: new IconButton(
                        icon: new Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      title: Text(
                        "Menu",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: FONT_TEXT_PRIMARY,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          letterSpacing: 1,
                          shadows: [
                            Shadow(
                              // bottomLeft
                                offset: Offset(1.5, 1.5),
                                color: Colors.black54),
                            Shadow(
                              // bottomRight
                                offset: Offset(1.5, 1.5),
                                color: Colors.black54),
                            Shadow(
                              // topRight
                                offset: Offset(1.5, 1.5),
                                color: Colors.black54),
                            Shadow(
                              // topLeft
                                offset: Offset(1.5, 1.5),
                                color: Colors.black54),
                          ],
                        ),
                      ),
                      centerTitle: true,
                    ),
                    body: Container(
                      child: PhotoViewGallery.builder(
                        scrollPhysics: const BouncingScrollPhysics(),
                        builder: (BuildContext context, int index) {
                          return PhotoViewGalleryPageOptions(
                            imageProvider: NetworkImage(
                              snapShot.data[index],
                            ),
                            initialScale: PhotoViewComputedScale.contained * 1,
                            minScale: PhotoViewComputedScale.contained * 1,
                            maxScale: PhotoViewComputedScale.contained * 2,
                            heroTag: index,
                          );
                        },
                        itemCount: snapShot.data.length,
                        loadingChild: Center(
                          child: Container(
                            height: 50,
                            width: 50,
                            child: new FlareActor(
                              "assets/animations/dotLoader.flr",
                              animation: "load",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        pageController: PageController(
                            initialPage: _index,
                            keepPage: true,
                            viewportFraction: 1),
                      ),
                    ),
                  )));
        },
        child: index == 2 && snapShot.data.length != 3
            ? Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Stack(
            children: <Widget>[
              Container(
                child: Image.network(
                  snapShot.data[index],
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                color: Color.fromRGBO(0, 0, 0, 100),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, bottom: 10.0),
                child: Center(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            " +" + (snapShot.data.length - 3).toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: FONT_TEXT_EXTRA,
                                color: Colors.white,
                                fontSize: 30),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        )
            : Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Container(
            color: SECONDARY_COLOR_1,
            child: Image.network(
              snapShot.data[index],
              fit: BoxFit.fill,
              width: 120,
              height: 100,
            ),
          ),
        ),
      );
    },
  );
}

Widget buildMenuWaiting(double c_width) {
  return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Container(
            color: SECONDARY_COLOR_1,
            width: 120,
            height: 100,
            child: Center(
              child: new FlareActor(
                "assets/animations/loading_2.flr",
                animation: "Untitled",
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        );
      });
}
