import 'package:flutter/material.dart';

class ItemViewCircle extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTapCircle;
  const ItemViewCircle({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.onTapCircle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            onTapCircle();
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffeaf4ff),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Color(0xff0f4557),
              size: 35,
            ),
            alignment: Alignment.center,
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
