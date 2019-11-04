import 'dart:async';
import 'dart:io';

import 'package:bhukkd/Constants/app_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Widget buildSlider(BuildContext context, AsyncSnapshot snapshot) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.32,
    child: Stack(
      children: <Widget>[
        Container(
          child: Swiper(
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              return CachedNetworkImage(
                imageUrl: snapshot.data[index],
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height * 0.5,
                placeholder: (context, url) => Container(
                  color: SECONDARY_COLOR_1,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              );
            },
            itemCount: (snapshot.data.length > 15) ? 15 : snapshot.data.length,
            pagination: new SwiperPagination(),
          ),
        ),
      ],
    ),
  );
}

Future<File> file(String filename) async {
  Directory dir = await getApplicationDocumentsDirectory();
  String pathName = p.join(dir.path, filename);
  return File(pathName);
}

Widget buildSliderWaiting() {
  return Container(
    color: SECONDARY_COLOR_1,
    child: Center(
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
  );
}
