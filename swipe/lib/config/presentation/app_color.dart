import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  static Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color.fromRGBO(26, 201, 252, 1),
      Color.fromRGBO(29, 116, 242, 1)
    ],
  ).createShader(Rect.fromLTWH(104.0, 106.0, 166.0, 63.0));

  static const Color kBackground = Color(0XFFfcfcfd);
  static const Color primaryTextColor = Color(0XFF9098B1);
  static const Color secondaryTextColor = Color.fromRGBO(34, 33, 91, 1);
  static const Color borderColor = Color.fromRGBO(235, 240, 255, 1);
  static const Color iconBackground = Color(0XFFDDF4FE);
  // static const Color kSecondary = Color(0xFFBD7A43);
  // static const Color kTextField = Color(0xFFE5E5E5);
}
