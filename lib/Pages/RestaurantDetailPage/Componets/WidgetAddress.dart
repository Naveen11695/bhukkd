import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Services/HttpRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

Widget buildAddress(
    AsyncSnapshot snapshot, BuildContext context, double c_width) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Text("Address",
            style: TextStyle(
                fontFamily: FONT_TEXT_PRIMARY,
                fontWeight: FontWeight.w300,
                fontSize: 20.0,
                color: Colors.black87)),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 6),
        child: Row(children: [
          Expanded(
            flex: 1,
            child: Text(
              snapshot.data.restruant_Location.address,
              overflow: TextOverflow.clip,
              style: TextStyle(
                  fontFamily: FONT_TEXT_SECONDARY,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  color: TEXT_SECONDARY_COLOR),
            ),
          )
        ]),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FlutterMap(
                  options: new MapOptions(
                    center: new LatLng(
                        double.parse(snapshot.data.restruant_Location.latitude),
                        double.parse(
                            snapshot.data.restruant_Location.longitude)),
                    zoom: 13.0,
                  ),
                  layers: [
                    new TileLayerOptions(
                      urlTemplate: "https://api.tiles.mapbox.com/v4/"
                          "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                      additionalOptions: {
                        'accessToken': map_api_key,
                        'id': 'mapbox.streets',
                      },
                    ),
                    new MarkerLayerOptions(
                      markers: [
                        new Marker(
                          width: 100.0,
                          height: 100.0,
                          point: new LatLng(
                              double.parse(
                                  snapshot.data.restruant_Location.latitude),
                              double.parse(
                                  snapshot.data.restruant_Location.longitude)),
                          builder: (ctx) => new Container(
                            child: new Icon(Icons.restaurant),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
