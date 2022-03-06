import 'package:flutter/material.dart';

import 'block_tile_front.dart';

class FrontVisitingCardView extends StatelessWidget {
  final Color blockColor;
  const FrontVisitingCardView({Key key, @required this.blockColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var topPadding = MediaQuery.of(context).padding.top;
    var size = MediaQuery.of(context).size;
    Color blockColor1;
    Color blockColor2;
    Color blockColor3;
    if (blockColor == Colors.red) {
      blockColor1 = Colors.red;
      blockColor2 = Colors.red[600];
      blockColor3 = Colors.red[700];
    } else if (blockColor == Colors.orange) {
      blockColor1 = Colors.orange;
      blockColor2 = Colors.orange[600];
      blockColor3 = Colors.orange[700];
    } else if (blockColor == Colors.blue) {
      blockColor1 = Colors.blue;
      blockColor2 = Colors.blue[600];
      blockColor3 = Colors.blue[700];
    }
    return Container(
      height: 300,
      width: size.width,
      padding: EdgeInsets.only(top: 32, left: 8, right: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 300,
              width: size.width / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                color: Color(0xFF29303a),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://upload.wikimedia.org/wikipedia/en/a/a1/Dhaka_Medical_College_and_Hospital_logo.png',
                      height: 60,
                      width: 60,
                    ),
                    Text(
                      'Dhaka Medical College',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'YOUR SLOGAN',
                      style: TextStyle(
                        // fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                BlockTileFront(
                  color: blockColor3,
                  assetIcon: 'assets/images/stethoscope.png',
                  text: 'GET HEALTH\nRESULTS',
                  topRightRadius: 15,
                ),
                BlockTileFront(
                  color: blockColor2,
                  assetIcon: 'assets/images/ambulance.png',
                  text: 'URGENCY\nSERVICES',
                ),
                BlockTileFront(
                  color: blockColor1,
                  assetIcon: 'assets/images/bed.png',
                  text: 'PRIVET\nRESULTS',
                  bottomRightRadius: 15,
                  height: 88,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
