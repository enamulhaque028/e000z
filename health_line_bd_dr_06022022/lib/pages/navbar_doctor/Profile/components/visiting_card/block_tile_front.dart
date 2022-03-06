import 'package:flutter/material.dart';

class BlockTileFront extends StatelessWidget {
  const BlockTileFront({
    @required this.color,
    this.topRightRadius = 0,
    this.bottomRightRadius = 0,
    this.height = 86,
    @required this.assetIcon,
    @required this.text,
    Key key,
  }) : super(key: key);

  final Color color;
  final double topRightRadius;
  final double bottomRightRadius;
  final String assetIcon;
  final String text;
  final double height;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: height,
          width: size.width / 2 - 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(topRightRadius),
              bottomRight: Radius.circular(bottomRightRadius),
            ),
            color: color,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: -30,
          child: SizedBox(
            height: height,
            child: Center(
              child: Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                child: Transform.scale(
                  scale: 0.5,
                  child: Image.asset(
                    assetIcon,
                    // height: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
