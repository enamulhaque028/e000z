import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light();

ThemeData darkTheme = ThemeData.dark();

ThemeData purpleTheme = lightTheme.copyWith(
  primaryColor: Colors.purple[900],
  scaffoldBackgroundColor: Colors.purple[100],
  cardColor: Colors.purple[900],
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: Colors.purple[900],
  ),
  textTheme: const TextTheme(
    // bodyText1: TextStyle(),
    bodyText2: TextStyle(),
  ).apply(
    bodyColor: Colors.white,
    // displayColor: Colors.blue,
  ),
);

ThemeData tealTheme = lightTheme.copyWith(
  primaryColor: Colors.teal,
  scaffoldBackgroundColor: Colors.teal[100],
  cardColor: Colors.teal,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: Colors.teal,
  ),
  textTheme: const TextTheme(
    // bodyText1: TextStyle(),
    bodyText2: TextStyle(),
  ).apply(
    bodyColor: Colors.white,
    // displayColor: Colors.blue,
  ),
);

ThemeData greenTheme = lightTheme.copyWith(
  primaryColor: Colors.green,
  scaffoldBackgroundColor: Colors.green[100],
  cardColor: Colors.green,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: Colors.green,
  ),
  textTheme: const TextTheme(
    // bodyText1: TextStyle(),
    bodyText2: TextStyle(),
  ).apply(
    bodyColor: Colors.white,
    // displayColor: Colors.blue,
  ),
);

ThemeData greyTheme = lightTheme.copyWith(
  primaryColor: Colors.grey,
  scaffoldBackgroundColor: Colors.grey[350],
  cardColor: Colors.grey,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: Colors.grey,
  ),
  textTheme: const TextTheme(
    // bodyText1: TextStyle(),
    bodyText2: TextStyle(),
  ).apply(
    bodyColor: Colors.white,
    // displayColor: Colors.blue,
  ),
);

ThemeData pinkTheme = lightTheme.copyWith(
  primaryColor: Colors.pink,
  scaffoldBackgroundColor: Colors.pink[100],
  cardColor: Colors.pink,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: Colors.pink,
  ),
  textTheme: const TextTheme(
    // bodyText1: TextStyle(),
    bodyText2: TextStyle(),
  ).apply(
    bodyColor: Colors.white,
    // displayColor: Colors.blue,
  ),
);
