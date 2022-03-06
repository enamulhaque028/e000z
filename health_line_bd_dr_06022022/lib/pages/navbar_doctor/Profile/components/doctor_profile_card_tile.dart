import 'package:flutter/material.dart';

class DoctorProfileCardTile extends StatelessWidget {
  final Color shadowColor;
  final String title;
  final String desc;
  const DoctorProfileCardTile({
    Key key,
    @required this.shadowColor,
    @required this.title,
    @required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: shadowColor.withOpacity(0.8),
            blurRadius: 10.0,
            // offset: Offset(0, 5),
          ),
        ],
      ),
      child: SizedBox(
        height: 105,
        width: 150,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/medical_report.png',
                  height: 30,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: Color(0xFF43bdde),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          desc.trim().toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color(0xFF727690),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DoctorSignCardTile extends StatelessWidget {
  final Color shadowColor;
  final String title;
  final String signImgUrl;
  const DoctorSignCardTile({
    Key key,
    @required this.shadowColor,
    @required this.title,
    @required this.signImgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: shadowColor.withOpacity(0.8),
            blurRadius: 10.0,
            // offset: Offset(0, 5),
          ),
        ],
      ),
      child: SizedBox(
        height: 105,
        width: 150,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFF43bdde),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Image.network(
                  signImgUrl,
                  height: 60,
                  width: 120,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
