import 'package:flutter/material.dart';

class VisitingCardItemTile extends StatelessWidget {
  final String imageUrl;
  final Color color;
  const VisitingCardItemTile({
    Key key,
    @required this.imageUrl,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: color,
      child: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(imageUrl),
      ),
    );
  }
}
