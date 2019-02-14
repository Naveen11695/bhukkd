import 'package:flutter/material.dart';

class HorizontalTransition extends MaterialPageRoute{
  HorizontalTransition({WidgetBuilder builder, RouteSettings settings}):super(builder:builder, settings:settings);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);


  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child){ 
    Animation<Offset> customAnimation = new Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(animation);
    return new SlideTransition(position: customAnimation,child: child,);
  }



}
