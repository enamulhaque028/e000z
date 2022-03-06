import 'package:flutter/material.dart';

class BlockTileBack extends StatelessWidget {
  const BlockTileBack({
    @required this.color,
    this.bottomLeftRadius = 0,
    this.bottomRightRadius = 0,
    @required this.iconData,
    @required this.text,
    Key key,
  }) : super(key: key);

  final Color color;
  final double bottomLeftRadius;
  final double bottomRightRadius;
  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size.width / 3 - 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bottomLeftRadius),
              bottomRight: Radius.circular(bottomRightRadius),
            ),
            color: color,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ),
        Positioned(
          top: -30,
          child: SizedBox(
            width: size.width / 3 - 8,
            child: Center(
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                child: Icon(
                  iconData,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
