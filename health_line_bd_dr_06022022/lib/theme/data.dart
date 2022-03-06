import 'package:flutter/material.dart';
import 'package:health_line_bd/theme/theme_values.dart';
import 'model.dart';

List<ThemeSwitcherModel> getThemeData() {
  List<ThemeSwitcherModel> data = [];

  data.add(
    ThemeSwitcherModel(
      themeData: lightTheme,
      color: Colors.white,
      spValue: 'lightTheme',
    ),
  );
  data.add(
    ThemeSwitcherModel(
      themeData: darkTheme,
      color: Colors.black,
      spValue: 'darkTheme',
    ),
  );
  data.add(
    ThemeSwitcherModel(
      themeData: purpleTheme,
      color: Colors.purple[900],
      spValue: 'purpleTheme',
    ),
  );
  data.add(
    ThemeSwitcherModel(
      themeData: tealTheme,
      color: Colors.teal,
      spValue: 'tealTheme',
    ),
  );
  data.add(
    ThemeSwitcherModel(
      themeData: greenTheme,
      color: Colors.green,
      spValue: 'greenTheme',
    ),
  );
  data.add(
    ThemeSwitcherModel(
      themeData: greyTheme,
      color: Colors.grey,
      spValue: 'greyTheme',
    ),
  );

  data.add(
    ThemeSwitcherModel(
      themeData: pinkTheme,
      color: Colors.pink,
      spValue: 'pinkTheme',
    ),
  );

  return data;
}
