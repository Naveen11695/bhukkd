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
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
          child: Row(
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                      image: new AssetImage(imagePath), fit: BoxFit.fill),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                text,
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
            ],
          ),
        ),
      ),
    );
  }
}
