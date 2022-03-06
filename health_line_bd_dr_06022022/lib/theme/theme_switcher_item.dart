import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSwitcherItem extends StatelessWidget {
  final ThemeData themeData;
  final Color color;
  final String spColorValue;
  const ThemeSwitcherItem({
    Key key,
    @required this.themeData,
    @required this.color,
    @required this.spColorValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: ThemeSwitcher(
        builder: (ctx) {
          return InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('spColorValue', spColorValue);
              ThemeSwitcher.of(ctx).changeTheme(
                theme: themeData,
              );
              // Navigator.of(context).pop();
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => MyHomePage(),
              //   ),
              //   (Route<dynamic> routue) => false,
              // );
            },
            child: CircleAvatar(
              backgroundColor: color,
              radius: 20,
            ),
          );
        },
      ),
    );
  }
}
