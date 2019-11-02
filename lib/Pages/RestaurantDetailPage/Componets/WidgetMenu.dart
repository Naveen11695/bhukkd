import 'package:bhukkd/Constants/app_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

Widget buildMenu(AsyncSnapshot snapShot, BuildContext context, double c_width) {
  return ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemCount: snapShot.data.length,
    itemBuilder: (BuildContext context, int index) {
      int _index = index;
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Container(
                    color: Colors.black,
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
                  )));
        },
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            color: SECONDARY_COLOR_1,
            child: CachedNetworkImage(
              imageUrl: snapShot.data[index],
              fit: BoxFit.fill,
              width: 150,
              height: 150,
              placeholder: (context, url) => Center(
                child: Container(
                  width: 150,
                  height: 150,
                  child: Center(
                    child: new FlareActor(
                      "assets/animations/loading_Untitled.flr",
                      animation: "Untitled",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
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
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: SECONDARY_COLOR_1,
            width: 150,
            height: 150,
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
