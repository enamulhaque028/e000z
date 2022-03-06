import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Swipe',
      style: new TextStyle(
        fontSize: 52.0,
        fontWeight: FontWeight.bold,
        foreground: Paint()..shader = AppColor.linearGradient,
      ),
    );
  }
}
