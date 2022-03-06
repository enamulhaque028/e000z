// import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/pages/home/profile/edit/edit_profile.dart';
import 'package:ati_ams/pages/home/profile/edit/widgets/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'profile_info_view.dart';

class ProfileTile extends StatelessWidget {
  final String imageUrl;
  final String signatureUrl;
  final String name;
  final String department;
  final String id;
  final String session;
  final String batchNo;
  final String courseType;
  final String courseName;
  final String gender;
  final String dateOfBirth;
  const ProfileTile({
    Key key,
    @required this.imageUrl,
    @required this.signatureUrl,
    @required this.name,
    @required this.department,
    @required this.id,
    @required this.session,
    @required this.batchNo,
    @required this.courseType,
    @required this.courseName,
    @required this.gender,
    @required this.dateOfBirth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    DateTime dt = DateTime.parse(dateOfBirth);
    String dateOfBirthFormatted =
        DateFormat('dd-MM-yyyy').format(dt).toString();
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepPurple[800], Colors.deepPurpleAccent],
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: width * 0.14),
                          CircleAvatar(
                            radius: 65.0,
                            backgroundImage: imageUrl == ''
                                ? AssetImage('assets/images/user_profile.png')
                                : NetworkImage(imageUrl),
                            backgroundColor: Colors.white,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              PickImages.profileImgPath = '';
                              PickImages.signatureImgPath = '';
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    EditProfileDialog(
                                  defaultName: name,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        department,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 260,
                left: 20.0,
                right: 20.0,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            child: Column(
                          children: [
                            Text(
                              'ID',
                              style: TextStyle(
                                  color: Colors.grey[400], fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              id,
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            )
                          ],
                        )),
                        Container(
                          child: Column(children: [
                            Text(
                              'Session',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14.0,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              session,
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            )
                          ]),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                'Batch No',
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 14.0),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                batchNo,
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, top: 16, bottom: 8),
              child: Card(
                child: Container(
                  // height: 250.0,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Information",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Divider(
                          color: Colors.grey[300],
                        ),
                        ProfileInfoTile(
                          title: 'Course Type',
                          value: courseType,
                          iconData: Icons.home,
                          iconColor: Colors.blueAccent[400],
                        ),
                        ProfileInfoTile(
                          title: 'Course Name',
                          value: courseName,
                          iconData: Icons.assignment,
                          iconColor: Colors.yellowAccent[400],
                        ),
                        ProfileInfoTile(
                          title: 'Gender',
                          value: gender,
                          iconData: Icons.person_add,
                          iconColor: Colors.pinkAccent[400],
                        ),
                        ProfileInfoTile(
                          title: 'Date of Birth',
                          value: dateOfBirthFormatted,
                          iconData: Icons.calendar_today_outlined,
                          iconColor: Colors.lightGreen[400],
                        ),
                        signatureUrl == ''
                            ? Container()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.fingerprint,
                                    color: Colors.orange[400],
                                    size: 35,
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Signature",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      Image.network(
                                        '$signatureUrl',
                                        height: 60,
                                      )
                                    ],
                                  )
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
