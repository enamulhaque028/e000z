import 'package:flutter/material.dart';

buildContainerOffline() {
  return Column(
    children: [
      Container(
        color: Color(0xFFEE4400),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "OFFLINE",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 8.0,
            ),
            SizedBox(
              width: 12.0,
              height: 12.0,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
