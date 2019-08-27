import 'package:avataaar_image/avataaar_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Avataaar.dart';

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
        shape: BoxShape.rectangle,
        image: profileImage,
      ),
    );
  }

  Future _setAvtaaar() async {
    var response;
    var fireStore = Firestore.instance;
    DocumentReference snapshot =
    fireStore.collection('UsersData').document(email);
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
        height: screenSize.height / 4.0,
        child: new Container(
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
                  child: FutureBuilder(
                    future: _setAvtaaar(),
                    builder: (BuildContext context, AsyncSnapshot snapShot) {
                      if (snapShot.connectionState == ConnectionState.done) {
                        if (snapShot.data != null) {
                          return ClipOval(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                gradient: RadialGradient(
                                  colors: [Colors.grey, Colors.white],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: _userImage = AvataaarImage(
                                  avatar: _avataarList[int.parse((snapShot.data
                                      .toString()
                                      .trim()
                                      .compareTo("null") ==
                                      0)
                                      ? "0"
                                      : snapShot.data.toString())],
                                  errorImage: Icon(Icons.error),
                                  placeholder: CircularProgressIndicator(
                                    valueColor:
                                    new AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                  width: 150.0,
                                ),
                              ),
                            ),
                          );
                        } else {
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
                      } else {
                        return new Container(
                          width: containerGrowAnimation.value * 150,
                          height: containerGrowAnimation.value * 150,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ),
                          ),
                        );
                      }
                    },
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
                    placeholder: CircularProgressIndicator(
                      valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
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

  void _onTileClicked(int index) async {
    var fireStore = Firestore.instance;
    DocumentReference documentReference =
    fireStore.collection('UsersData').document(email);
    await documentReference.get().then((dataSnapshot) {
      if (dataSnapshot.exists) {
        documentReference
            .updateData({"Avataaar_index": index}).whenComplete(() {
          print("Successfull: Avataaar_index update");
        }).catchError((e) {
          print("Error: Avataaar_index update" + e.toString());
        });
      } else {
        documentReference.setData({"Avataaar_index": index}).whenComplete(() {
          print("Successfull: Avataaar_index update");
        }).catchError((e) {
          print("Error: Avataaar_index add" + e.toString());
        });
      }
    });
    setState(() {
      Navigator.pop(context);
    });
  }
}
