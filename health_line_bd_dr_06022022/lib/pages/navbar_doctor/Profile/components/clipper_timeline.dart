import 'package:flutter/material.dart';

class ClipperTimeLine extends StatelessWidget {
  final double height;
  final Color lineColor;
  final Color circleColor;
  ClipperTimeLine({
    @required this.height,
    this.lineColor = const Color(0xFF648fd6),
    this.circleColor = const Color(0xFF34017e),
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 3,
          height: height,
          decoration: new BoxDecoration(
            color: lineColor,
            shape: BoxShape.rectangle,
          ),
        ),
        Container(
          width: 18,
          height: 18,
          decoration: new BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 3,
          height: height,
          decoration: new BoxDecoration(
            color: lineColor,
            shape: BoxShape.rectangle,
          ),
        ),
      ],
    );
  }
}
