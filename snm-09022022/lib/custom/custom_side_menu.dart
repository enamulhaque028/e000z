import 'package:dil_app/config/common_const.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    //ToDO
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: cViolet.withOpacity(0.1)),
          ),
        ),
        child: InkWell(
          //splashColor: Colors.orangeAccent,
          onTap: onTap,
          child: Container(
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.red[600],
                      size: 26,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                    ),
                    Text(
                      text,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                // Icon(
                //   Icons.arrow_right,
                //   color: cViolet,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
