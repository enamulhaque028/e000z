import 'dart:developer';

import 'package:flutter/material.dart';

class PrescriptionHeaderTile extends StatelessWidget {
  final String drName;
  final String gender;
  final String bloodGroup;
  final String age;
  final String date;
  final String designation;
  final String speciality;
  final String bmdcNo;
  final String bdhlNo;
  const PrescriptionHeaderTile({
    Key key,
    @required this.drName,
    @required this.gender,
    @required this.bloodGroup,
    @required this.age,
    @required this.date,
    @required this.designation,
    @required this.speciality,
    @required this.bmdcNo,
    @required this.bdhlNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Container(
        height: 150,
        width: width,
        color: Color(0xFFd3fdf9),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(
                    'Health Line BD',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.teal[600],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      log('Download prescription');
                    },
                    child: Icon(
                      Icons.cloud_download_rounded,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: $drName',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextTileWidget(
                        title: 'Gender: $gender',
                      ),
                      TextTileWidget(
                        title: 'Blood Group: $bloodGroup',
                      ),
                      TextTileWidget(
                        title: 'Age: $age',
                      ),
                      TextTileWidget(
                        title: 'Date: $date',
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$drName',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextTileWidget(
                        title: '$designation',
                      ),
                      TextTileWidget(
                        title: '$speciality',
                      ),
                      TextTileWidget(
                        title: '$bmdcNo',
                      ),
                      TextTileWidget(
                        title: '$bdhlNo',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextTileWidget extends StatelessWidget {
  const TextTileWidget({
    @required this.title,
    Key key,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.5),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
