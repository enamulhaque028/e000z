import 'package:flutter/material.dart';

class HistoryItemView extends StatelessWidget {
  const HistoryItemView({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Image.asset(
              'assets/images/point.png',
              height: 25,
              width: 25,
            ),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            )
          ],
        ),
        SizedBox(height: 4),
      ],
    );
  }
}
