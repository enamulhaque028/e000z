import 'package:flutter/material.dart';

class ItemView extends StatelessWidget {
  const ItemView({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.iconColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Icon(
              icon,
              color: iconColor,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 4),
      ],
    );
  }
}
