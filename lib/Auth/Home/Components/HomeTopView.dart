import 'dart:convert';

import 'package:bhukkd/api/LocationRequest.dart';
import 'package:bhukkd/models/SharedPreferance/SharedPreference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Avataaar.dart';
import 'package:avataaar_image/avataaar_image.dart';

class ImageBackground extends StatefulWidget {
  DecorationImage backgroundImage;
  DecorationImage profileImage;
  Animation<double> containerGrowAnimation;
  String email;

  ImageBackground({
    this.backgroundImage,
    this.containerGrowAnimation,
    this.profileImage,
    this.email,
  });

  _ImageBackground createState() => new _ImageBackground(
      backgroundImage: backgroundImage,
      profileImage: profileImage,
      containerGrowAnimation: containerGrowAnimation,
      email: email);
}

class _ImageBackground extends State<ImageBackground> {
  DecorationImage backgroundImage;
  DecorationImage profileImage;
  Animation<double> containerGrowAnimation;
  String email;
  Avataaar _avatar;

  _ImageBackground({
    this.backgroundImage,
    this.containerGrowAnimation,
    this.profileImage,
    this.email,
  });

  void _randomizeAvatar() => _avatar = Avataaar.random();

  Widget _userImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userImage = new Container(
      width: containerGrowAnimation.value * 150,
      height: containerGrowAnimation.value * 150,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        image: profileImage,
        boxShadow: [
          BoxShadow(
              color: Colors.black, offset: Offset(5.0, 5.0), blurRadius: 20.0)
        ],
      ),
    );
  }

  Future _setAvtaaar() async {
    var response;
    var fireStore = Firestore.instance;
    DocumentReference snapshot =
    fireStore.collection('UserData').document(
        email);
    await snapshot.get().then((dataSnapshot) {
      if (dataSnapshot.exists) {
        response = dataSnapshot.data['Avataaar_index'].toString();
      }
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return (new Container(
        width: screenSize.width,
        height: screenSize.height / 2.8,
        decoration: new BoxDecoration(image: backgroundImage),
        child: new Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
            colors: <Color>[
              const Color.fromRGBO(110, 101, 103, 0.6),
              const Color.fromRGBO(51, 51, 63, 0.9),
            ],
            stops: [0.2, 1.0],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
          )),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => _buildDialog(context),
                  );
                },
                splashColor: Colors.white24,
                highlightColor: Colors.white10,
                child: Container(
                  padding: EdgeInsets.only(top: 40.0),
                  child: FutureBuilder(
                    future: _setAvtaaar(),
                    builder: (BuildContext context, AsyncSnapshot snapShot) {
                      if (snapShot.connectionState == ConnectionState.done) {
                        if (snapShot.data != null) {
                          return Center(
                            child: Container(
                              child: _userImage = AvataaarImage(
                                avatar: _avataarList[int.parse(snapShot.data.toString())],
                                errorImage: Icon(Icons.error),
                                placeholder: CircularProgressIndicator(),
                                width: 200.0,
                              ),
                            ),
                          );
                        }
                        else{
                          print(snapShot.data.toString());
                          return new Container(
                            width: containerGrowAnimation.value * 150,
                            height: containerGrowAnimation.value * 150,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: profileImage,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(5.0, 5.0),
                                    blurRadius: 20.0)
                              ],
                            ),
                          );
                        }
                      }
                      else {
                        return new Container(
                          width: containerGrowAnimation.value * 150,
                          height: containerGrowAnimation.value * 150,
                          child: Center(child: CircularProgressIndicator(),),
                        );
                      }
                    },
                  ),
                ),
              ),
              Center(
                child: Container(
                  child: new Text(
                    email.split('@')[0].toUpperCase(),
                    style: new TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        shadows: [
                          Shadow(
                              // bottomLeft
                              offset: Offset(1.5, 1.5),
                              color: Colors.black,
                              blurRadius: 10),
                          Shadow(
                              // bottomRight
                              offset: Offset(1.5, 1.5),
                              color: Colors.black,
                              blurRadius: 10),
                          Shadow(
                              // topRight
                              offset: Offset(1.5, 1.5),
                              color: Colors.white,
                              blurRadius: 10),
                          Shadow(
                              // topLeft
                              offset: Offset(1.5, 1.5),
                              color: Colors.white,
                              blurRadius: 10),
                        ],
                        letterSpacing: 5.0,
                        color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        )));
  }

  _buildDialog(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        height: 500,
        width: 350,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 1,
              padding: const EdgeInsets.all(4.0),
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 4.0,
              children: _getTiles(_avataarList),
            )),
      ),
    );
  }

  List<Avataaar> _avataarList = [
    menShortHairDreads,
    womenWithShirtCrewNeck2,
    menLongHairBun,
    womenLongHairCurly,
    menWithShortHairTheCaesar,
    womenWithLongHairStraightStrand,
    menWithTurban,
    menWithShortHairSides,
    womenWithShirtCrewNeck1,
    menWithShortHairShortWaved,
    womenWithShortHairShaggyMullet,
    menWithEyePatch,
    womenWithLongHairStraight2,
    menWithShortHairShortCurly,
    womenWithLongHairNotTooLong,
    menWithShortHairShortFlat,
  ];

  List<Widget> _getTiles(List<Avataaar> iconList) {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < iconList.length; i++) {
      tiles.add(new GridTile(
          child: Material(
        child: new InkResponse(
          enableFeedback: true,
          child: Container(
            color: Colors.white,
            child: Center(
              child: Container(
                child: Center(
                  child: AvataaarImage(
                    avatar: iconList[i],
                    errorImage: Icon(Icons.error),
                    placeholder: CircularProgressIndicator(),
                    width: 150.0,
                  ),
                ),
              ),
            ),
          ),
          onTap: () => _onTileClicked(i),
        ),
      )));
    }
    return tiles;
  }

  void _onTileClicked(int index) {
    Firestore.instance
        .collection("UserData")
        .document(email)
        .setData({
      "Avataaar_index": index
    });
    setState(() {
    });
  }
}
