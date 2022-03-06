import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class RPSCustomPainterOval extends CustomPainter {
  final Color getColor;
  RPSCustomPainterOval({this.getColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.02;
    paint_0.shader = ui.Gradient.linear(
        Offset(0, size.height * 0.50),
        Offset(size.width * 0.73, size.height * 0.50),
        [getColor, Color(0xffffffff)],
        [0.00, 1.00]);

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.6950455, size.height * 0.0093846);
    path_0.quadraticBezierTo(
        size.width * 0.2480455, size.height * 0.0479231, 0, size.height);
    path_0.quadraticBezierTo(size.width * 0.1416364, size.height * 1.0062308,
        size.width * 0.7317273, size.height * 0.9944615);
    path_0.lineTo(size.width * 0.6950455, size.height * 0.0003846);
    path_0.close();

    canvas.drawPath(path_0, paint_0);

    Paint paint_1 = new Paint()
      ..color = Color.fromARGB(255, 29, 17, 226)
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.7;
    paint_1.shader = ui.Gradient.radial(
        Offset(size.width * 0.70, size.height * 0.51),
        size.width * 0.67,
        [getColor, Color(0xffffffff)],
        [0.00, 1.00]);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.6999091, size.height * 0.0133846);
    path_1.cubicTo(
        size.width * 0.8163636,
        size.height * 0.0133846,
        size.width * 0.9912273,
        size.height * 0.1520769,
        size.width * 0.9912273,
        size.height * 0.5063846);
    path_1.cubicTo(
        size.width * 0.9912273,
        size.height * 0.7036154,
        size.width * 0.9037273,
        size.height * 0.9993846,
        size.width * 0.6999091,
        size.height * 0.9993846);
    path_1.cubicTo(
        size.width * 0.5833182,
        size.height * 0.9993846,
        size.width * 0.4085455,
        size.height * 0.8513077,
        size.width * 0.4085455,
        size.height * 0.5063846);
    path_1.cubicTo(
        size.width * 0.4085455,
        size.height * 0.3091538,
        size.width * 0.4960455,
        size.height * 0.0133846,
        size.width * 0.6999091,
        size.height * 0.0133846);
    path_1.close();

    canvas.drawPath(path_1, paint_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
