import 'package:flutter/material.dart';

class PrescriptionFooterTile extends StatelessWidget {
  final String signatureUrl;
  const PrescriptionFooterTile({
    Key key,
    @required this.signatureUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 96,
      width: MediaQuery.of(context).size.width,
      color: Color(0xFFe7faf8),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Column(
                  children: [
                    Text(
                      'Signature',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset(
                      '$signatureUrl',
                      // height: 80,
                      width: 100,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
