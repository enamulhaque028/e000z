import 'dart:math';
import 'package:flutter/material.dart';

class DailyDrinkAmount extends StatelessWidget {
  final double goal;
  final double waterDrunk;
  DailyDrinkAmount({
    @required this.goal,
    @required this.waterDrunk,
  });
  @override
  Widget build(BuildContext context) {
    var leftAmount = goal - waterDrunk;
    var percent = waterDrunk / goal;
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: -pi / 2,
          child: Container(
            width: 170,
            height: 170,
            child: CustomPaint(
              painter: DialPainter(percent: percent),
            ),
          ),
        ),
        leftAmount <= 0
            ? Text('Goal Reached',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ))
            : RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: '${leftAmount.toStringAsFixed(1)} L',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
                  TextSpan(text: '\n'),
                  TextSpan(
                      text: 'left to drink',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
                ]),
              )
      ],
    );
  }
}

class DialPainter extends CustomPainter {
  final double percent;
  DialPainter({@required this.percent});
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.height / 2, size.width / 2);
    double fullRadius = (size.height / 2);
    Paint circle = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;
    Paint arc = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), fullRadius - 2, circle);
    canvas
      ..drawArc(Rect.fromCircle(center: center, radius: fullRadius - 2), 0,
          2 * pi * percent, false, arc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
