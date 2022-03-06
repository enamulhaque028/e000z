import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      // ..color = Color.fromARGB(205, 47, 47, 225)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint_0.shader = ui.Gradient.linear(
      Offset(size.width * 0.64, size.height * 0.80),
      Offset(0, size.height * 1.00),
      [Colors.white, Colors.white.withOpacity(0.2)],
      [1.0, 1.0],
      //TileMode.repeated,
    );

    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(0, size.height * 0.1008500);
    path_0.lineTo(size.width * 0.1400000, size.height * 0.1107000);
    path_0.lineTo(size.width * 0.3585200, size.height * 0.6497500);
    path_0.lineTo(size.width, size.height * 0.6532000);
    path_0.lineTo(size.width, 0);
    path_0.quadraticBezierTo(size.width * 0.7485000, 0, 0, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);

    Paint paint_1 = new Paint()
      // ..color = Color.fromARGB(216, 209, 209, 214)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    paint_1.shader = ui.Gradient.linear(
      Offset(size.width * 0.64, size.height * 0.80),
      Offset(0, size.height * 1.00),
      [Colors.grey[300]],
      // [Colors.black12],
      [1.0],
      //TileMode.repeated,
    );

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.3571000, size.height * 0.6465000);
    path_1.lineTo(size.width * 0.4380000, size.height * 0.8462500);
    path_1.lineTo(size.width, size.height * 0.8498000);
    path_1.lineTo(size.width, size.height * 0.6498500);
    path_1.lineTo(size.width * 0.3571000, size.height * 0.6465000);
    path_1.close();

    canvas.drawPath(path_1, paint_1);

    Paint paint_2 = new Paint()
      // ..color = Color.fromARGB(157, 163, 19, 19)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    paint_2.shader = ui.Gradient.linear(
      Offset(size.width * 0.64, size.height * 0.80),
      Offset(0, size.height * 1.00),
      [Colors.grey[200]],
      [1.0],
      //TileMode.repeated,
    );

    Path path_2 = Path();
    path_2.moveTo(0, size.height * 0.1607500);
    path_2.lineTo(size.width * 0.1238400, size.height * 0.1642000);
    path_2.lineTo(size.width * 0.4238200, size.height * 0.9036500);
    path_2.lineTo(size.width, size.height * 0.9071000);
    path_2.lineTo(size.width, size.height * 0.8486000);
    path_2.lineTo(size.width * 0.4380000, size.height * 0.8450000);
    path_2.lineTo(size.width * 0.1379800, size.height * 0.1036500);
    path_2.lineTo(0, size.height * 0.1000000);
    path_2.lineTo(0, size.height * 0.1607500);
    path_2.close();

    canvas.drawPath(path_2, paint_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// import 'package:flutter/material.dart';

// class RPSCustomPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint_0 = new Paint()
//       ..color = Color.fromARGB(255, 255, 255, 255)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 1;

//     Path path_0 = Path();
//     path_0.moveTo(0, 0);
//     path_0.lineTo(0, size.height * 0.1008500);
//     path_0.quadraticBezierTo(size.width * 0.1068750, size.height * 0.1035500,
//         size.width * 0.1425000, size.height * 0.1044500);
//     path_0.cubicTo(
//         size.width * 0.0034200,
//         size.height * 0.5478000,
//         size.width * 0.5038800,
//         size.height * 0.3906500,
//         size.width * 0.4010000,
//         size.height * 0.9028000);
//     path_0.quadraticBezierTo(size.width * 0.5507500, size.height * 0.9028875,
//         size.width, size.height * 0.9031500);
//     path_0.lineTo(size.width, 0);
//     path_0.quadraticBezierTo(size.width * 0.7485000, 0, 0, 0);
//     path_0.close();

//     canvas.drawPath(path_0, paint_0);

//     Paint paint_1 = new Paint()
//       ..color = Color.fromARGB(255, 222, 225, 228)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 1;

//     Path path_1 = Path();
//     path_1.moveTo(size.width * 0.3940000, size.height * 0.6500000);
//     path_1.lineTo(size.width, size.height * 0.6519000);
//     path_1.lineTo(size.width, size.height * 0.9044000);
//     path_1.quadraticBezierTo(size.width * 0.5500000, size.height * 0.9034625,
//         size.width * 0.4000000, size.height * 0.9031500);
//     path_1.quadraticBezierTo(size.width * 0.4285000, size.height * 0.7336000,
//         size.width * 0.3940000, size.height * 0.6500000);
//     path_1.close();

//     canvas.drawPath(path_1, paint_1);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
