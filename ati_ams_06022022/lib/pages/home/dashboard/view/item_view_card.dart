import 'package:ati_ams/config/common_const.dart';
import 'package:flutter/material.dart';

class ItemViewCard extends StatelessWidget {
  final String title;
  final String info;
  final IconData icon;
  final Function onTap;
  const ItemViewCard({
    Key key,
    @required this.title,
    @required this.info,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Card(
        elevation: 8.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
              child: RawMaterialButton(
                onPressed: () => onTap(),
                elevation: 5.0,
                fillColor: cViolet,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    icon,
                    size: 50.0,
                    color: Colors.white,
                  ),
                ),
                shape: CircleBorder(),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Divider(color: cViolet),
            Padding(
              padding:
                  const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 8.0),
              child: Text(
                info,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
