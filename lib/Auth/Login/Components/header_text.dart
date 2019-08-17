import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  HeaderText({@required this.text, @required this.imagePath, this.opacity});

  final String text;
  final String imagePath;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(44, 57, 73, opacity),
            borderRadius: BorderRadius.circular(50)),
        child: Row(
          children: <Widget>[
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.07,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.15,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                    image: new AssetImage(imagePath), fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.30,
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "Pacifico",
                  letterSpacing: 2.5,
                  wordSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                  textBaseline: TextBaseline.ideographic,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
