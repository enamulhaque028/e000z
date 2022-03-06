import 'package:flutter/material.dart';
import 'package:health_line_bd/config/common_const.dart';

class AllDoctorTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String speciality;
  final String degree;
  final String institute;
  final String rating;
  final String departmentName;

  const AllDoctorTile({
    Key key,
    @required this.imageUrl,
    @required this.name,
    @required this.speciality,
    @required this.degree,
    @required this.institute,
    @required this.rating,
    @required this.departmentName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFFd8ebff),
            blurRadius: 20.0,
            spreadRadius: 0.0,
            offset: const Offset(5.0, 5.0),
          )
        ],
      ),
      child: Card(
        // color: Color(0xFFFFFFFF),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ClipOval(
                      child: imageUrl == 'null'
                          ? Image.asset(
                              defaultFemaleAssetImg,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              '$imageUrl',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$name',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          '$speciality',
                          style: TextStyle(
                            // fontSize: 18,
                            // color: Colors.grey,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          '$degree',
                          style: TextStyle(
                            // fontSize: 18,
                            // color: Colors.grey,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          '$departmentName',
                          style: TextStyle(
                            // fontSize: 18,
                            // color: Colors.grey,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          '$institute',
                          style: TextStyle(
                            // fontSize: 18,
                            // color: Colors.grey,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(
                        '($rating Ratings)',
                        style: TextStyle(
                          // fontSize: 18,
                          // color: Colors.grey,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
