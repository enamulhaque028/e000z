import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class PopularDoctors extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String speciality;
  final String degree;
  final Color backgroundColor;
  PopularDoctors({
    @required this.imageUrl,
    @required this.name,
    @required this.speciality,
    @required this.degree,
    @required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 3.0), // shadow direction: bottom right
          )
        ],
      ),
      padding: EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          // SizedBox(
          //   height: 2,
          // ),
          Text(
            speciality,
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
          Text(
            degree,
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
          SmoothStarRating(
              allowHalfRating: false,
              onRated: (v) {},
              starCount: 5,
              rating: 4.5,
              color: Colors.white,
              size: 20.0,
              isReadOnly: true,
              borderColor: Colors.white,
              spacing: 0.0),
          Image.network(
            imageUrl,
            height: 110,
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }
}
