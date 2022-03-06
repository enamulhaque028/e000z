import 'package:flutter/material.dart';

class DoctorProfileInfoTile extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final String title1;
  final String title2;
  final VoidCallback onTap;

  const DoctorProfileInfoTile({
    Key key,
    @required this.iconData,
    @required this.iconColor,
    @required this.title1,
    @required this.title2,
    @required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 140,
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Color(0xFFe1e6f0),
              blurRadius: 10.0,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image.asset(
                //   'assets/images/medical_report.png',
                //   height: 30,
                // ),
                Icon(
                  iconData,
                  color: iconColor,
                ),
                SizedBox(height: 8),
                Text(
                  title1,
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  (title2).toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF727690),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
