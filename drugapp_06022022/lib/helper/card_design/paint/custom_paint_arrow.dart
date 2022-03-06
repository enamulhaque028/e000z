import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class RPSCustomPainterArrow extends CustomPainter {
  final Color getColor;
  RPSCustomPainterArrow({@required this.getColor});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint_0.shader = ui.Gradient.linear(
      Offset(size.width * 0.64, size.height * 0.80),
      Offset(0, size.height * 1.00),
      [getColor, getColor.withOpacity(0.2)],
      [0.60, 1.0],
      //TileMode.repeated,
    );

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.0679375);
    path_0.quadraticBezierTo(size.width * 0.0107333, size.height * 0.1689375,
        size.width * 0.0666667, size.height * 0.1875000);
    path_0.quadraticBezierTo(size.width * 0.2166667, size.height * 0.1875000,
        size.width * 0.6666667, size.height * 0.1875000);
    path_0.lineTo(size.width * 0.9651667, size.height * 0.4937500);
    path_0.lineTo(size.width * 0.6666667, size.height * 0.8125000);
    path_0.quadraticBezierTo(size.width * 0.2166667, size.height * 0.8125000,
        size.width * 0.0666667, size.height * 0.8125000);
    path_0.cubicTo(
        size.width * 0.0040000,
        size.height * 0.8205625,
        size.width * 0.0062667,
        size.height * 0.8936250,
        0,
        size.height * 0.9206250);

    canvas.drawPath(path_0, paint_0);

    Paint paint_1 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint_1.shader = ui.Gradient.linear(
        Offset(size.width * -0.01, size.height * 0.09),
        Offset(size.width * 0.17, size.height * 0.09),
        [Color(0xffc9c3c3), Color(0xffffffff)],
        // [Color(0xffc9c3c3), Color(0xffffffff)],
        [0.30, 1.00]);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.1687333, size.height * 0.1873125);
    path_1.quadraticBezierTo(size.width * 0.1687333, size.height * 0.0513750,
        size.width * 0.1687333, 0);
    path_1.quadraticBezierTo(size.width * 0.0305667, size.height * -0.0051875,
        size.width * 0.0055667, 0);
    path_1.cubicTo(
        size.width * -0.0097333,
        size.height * 0.0485625,
        size.width * -0.0127333,
        size.height * 0.1477500,
        size.width * 0.0232667,
        size.height * 0.1682500);
    path_1.cubicTo(
        size.width * 0.0420333,
        size.height * 0.1920000,
        size.width * 0.0720000,
        size.height * 0.1891875,
        size.width * 0.1687333,
        size.height * 0.1873125);
    path_1.close();

    canvas.drawPath(path_1, paint_1);

    Paint paint_2 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint_2.shader = ui.Gradient.linear(
        Offset(size.width * -0.01, size.height * 0.90),
        Offset(size.width * 0.17, size.height * 0.90),
        [Color(0xffc9c3c3), Color(0xffffffff)],
        [0.30, 1.00]);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.1688333, size.height * 0.8190625);
    path_2.quadraticBezierTo(size.width * 0.1676000, size.height * 0.9550000,
        size.width * 0.1671333, size.height);
    path_2.lineTo(1, size.height * 0.9968750);
    path_2.quadraticBezierTo(size.width * -0.0082667, size.height * 0.9078750,
        size.width * 0.0044000, size.height * 0.8750000);
    path_2.cubicTo(
        size.width * 0.0078000,
        size.height * 0.8031250,
        size.width * 0.0898000,
        size.height * 0.8014375,
        size.width * 0.1688333,
        size.height * 0.8190625);
    path_2.close();

    canvas.drawPath(path_2, paint_2);
    Paint paint_3 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint_3.shader = ui.Gradient.radial(
        Offset(size.width * 0.55, size.height * 0.75),
        size.width * 0.42,
        [Color(0xffdbcccc), Color(0xffffffff)],
        [0.00, 1.00]);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.1243333, size.height * 0.8156250);
    path_3.quadraticBezierTo(size.width * 0.7727333, size.height * 0.8992969,
        size.width * 0.9492000, size.height * 0.99271875);
    path_3.lineTo(size.width * 0.9733333, size.height * 0.5005625);
    path_3.lineTo(size.width * 0.6666667, size.height * 0.8125000);
    path_3.quadraticBezierTo(size.width * 0.5608333, size.height * 0.8132812,
        size.width * 0.2433333, size.height * 0.8156250);
    path_3.close();

    canvas.drawPath(path_3, paint_3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
