import 'package:flutter/material.dart';

import 'block_tile_back.dart';

class BackVisitingCardView extends StatelessWidget {
  final Color blockColor;
  const BackVisitingCardView({Key key, @required this.blockColor})
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
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Container(
                    height: 150,
                    width: size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://media.istockphoto.com/photos/medical-stethoscope-isolated-on-white-background-picture-id1159847028?k=20&m=1159847028&s=612x612&w=0&h=cvXAgMmEv_L65fw7jBG6Kqs3GpYXCp8hjoYBBHL4KK8='),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: Colors.black38,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dr. Mourice Tyler',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Heart Specialist',
                              style: TextStyle(
                                // fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              'https://upload.wikimedia.org/wikipedia/en/a/a1/Dhaka_Medical_College_and_Hospital_logo.png',
                              height: 60,
                              width: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'DMC',
                                    style: TextStyle(
                                      fontSize: 18,
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 110,
              width: size.width,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlockTileBack(
                    // color: blockColor,
                    color: blockColor1,
                    bottomLeftRadius: 15,
                    iconData: Icons.phone_android,
                    text: '+880 1843 498350\n+880 1843 498350',
                  ),
                  BlockTileBack(
                    // color: blockColor.withRed(240).withGreen(30).withBlue(20),
                    color: blockColor2,
                    iconData: Icons.email_outlined,
                    text: 'enamul@atilimited.net\nenamul@atilimited.net',
                  ),
                  BlockTileBack(
                    // color: blockColor.withRed(200).withGreen(30).withBlue(20),
                    color: blockColor3,
                    bottomRightRadius: 15,
                    iconData: Icons.location_on_outlined,
                    text: 'ATI Limited\nGareeb-E-Nawaz-Ave',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
