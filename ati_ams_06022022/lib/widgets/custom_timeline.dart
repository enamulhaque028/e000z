import 'package:flutter/material.dart';

class CustomTimeLine extends StatelessWidget {
  final double height;
  final Color lineColor;
  final Color circleColor;
  final bool isImageFromApi;
  CustomTimeLine({
    @required this.height,
    this.lineColor = const Color(0xFF648fd6),
    this.circleColor = const Color(0xFF34017e),
    this.isImageFromApi = false,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
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
