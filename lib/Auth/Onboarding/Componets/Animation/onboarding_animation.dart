import 'package:bhukkd/Constants/app_constant.dart';
import 'package:bhukkd/Constants/color_utility.dart';
import 'package:flutter/material.dart';

class OnBoardingEnterAnimation {
  OnBoardingEnterAnimation(this.controller)
      : colorAnimation = new ColorTween(
          begin: Color(getColorHexFromStr(COLOR_WELCOME)),
          end: Color(getColorHexFromStr(COLOR_LOGIN)),
        ).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.0,
              0.2,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        );

  final AnimationController controller;
  final Animation<Color> colorAnimation;
}
