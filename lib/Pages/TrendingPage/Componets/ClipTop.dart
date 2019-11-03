import 'dart:ui';

import 'package:flutter/material.dart';

class ClipTop extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(-100.0, size.height)
      ..lineTo(size.width, size.height - 100.0)
      ..lineTo(size.width, 0.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
