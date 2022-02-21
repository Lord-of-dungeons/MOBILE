import 'package:flutter/material.dart';

class CroperImage extends CustomClipper<Path> {
  // double x = 136.0;
  // double y = 66.0;

  double x = 30.0;
  double y = 32.0;

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(36.0, 0.0);
    path.lineTo(36 + x, 0.0);
    path.lineTo(36 + x, y);
    path.lineTo(36.0, y);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CroperImage oldClipper) => false;
}
