import 'package:flutter/material.dart';

class AppAction extends StatelessWidget {
  const AppAction({
    Key? key,
    required this.imagePath,
    required this.activityName,
    required this.onTap,
  }) : super(key: key);
  final String imagePath;
  final String activityName;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isPortrait ? 3.0 : 20.0),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 30,
              width: 30,
            ),
            Text(
              activityName,
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
