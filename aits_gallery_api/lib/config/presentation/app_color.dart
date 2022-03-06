import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  static const Gradient buttonGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(253, 188, 70, 1),
      Color.fromRGBO(250, 150, 30, 1),
    ],
  );
  static const Gradient backgroungGradient = LinearGradient(
    colors: [
      const Color.fromRGBO(125, 128, 255, 1),
      const Color.fromRGBO(78, 42, 255, 1),
    ],
    begin: const FractionalOffset(1.0, 0.0),
    end: const FractionalOffset(0.0, 1.0),
    stops: [0.0, 1.0],
    tileMode: TileMode.clamp,
  );
}
