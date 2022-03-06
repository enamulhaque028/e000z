import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  List<Offset> offsets1;
  List<Offset> offsets2;
  WaveClipper(this.offsets1, this.offsets2);
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(offsets1[0].dx, offsets1[0].dy);
    path.addPolygon(offsets1, false);
    path.lineTo(offsets2[0].dx, offsets2[0].dy);
    path.addPolygon(offsets2, false);
    path.lineTo(
        offsets2[offsets2.length - 1].dx, offsets2[offsets2.length - 1].dy);
    path.lineTo(offsets1[0].dx, offsets1[0].dy);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
