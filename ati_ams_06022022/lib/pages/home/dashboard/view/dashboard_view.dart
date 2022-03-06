import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/services/send_attendance_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'item_view_card.dart';
import 'select_institution.dart';

class DashboardTile extends StatefulWidget {
  final String name, id, department, gender, dateOfBirth, profileImage;
  final Function onTapAttendance;
  const DashboardTile({
    Key key,
    @required this.name,
    @required this.id,
    @required this.department,
    @required this.gender,
    @required this.dateOfBirth,
    @required this.onTapAttendance,
    @required this.profileImage,
  }) : super(key: key);

  @override
  _DashboardTileState createState() => _DashboardTileState();
}

class _DashboardTileState extends State<DashboardTile> {
  String checkInOutDay = '';
  String dayToday = DateTime.now().day.toString();
  @override
  void initState() {
    getCheckInOutDayFromSP();
    super.initState();
  }

  getCheckInOutDayFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      checkInOutDay = prefs.getString('checkInOutDay');
    });
    print('$checkInOutDay - $dayToday');
  }

  @override
  Widget build(BuildContext context) {
    DateTime dt = DateTime.parse(widget.dateOfBirth);
    String dateOfBirthFormatted =
        DateFormat('dd-MM-yyyy').format(dt).toString();
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 100,
                width: 100,
              ),
              Text(
                'BIRDEM ACADEMY',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: 220,
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    cViolet,
                    Color(0xff0f5549).withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: widget.profileImage == ''
                            ? AssetImage(
                                'assets/images/user_profile.png',
                              )
                            : NetworkImage(
                                widget.profileImage,
                              ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                    // SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'NAME: ${widget.name}',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'ID: ${widget.id}',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Dept of ${widget.department}',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[400],
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Gender',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    widget.gender,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Date of Birth',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    dateOfBirthFormatted,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          SelectInstitution(),
          SizedBox(height: 20),
          ValueListenableBuilder(
            valueListenable: checkInOutDayVal,
            builder: (context, value, widgets) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (dayToday == checkInOutDay || dayToday == value)
                      ? ItemViewCard(
                          title: 'ATTENDANCE',
                          info: 'Institute Out',
                          icon: Icons.logout,
                          onTap: () {
                            widget.onTapAttendance();
                          },
                        )
                      : ItemViewCard(
                          title: 'ATTENDANCE',
                          info: 'Institute In',
                          icon: Icons.fingerprint,
                          onTap: () {
                            widget.onTapAttendance();
                          },
                        ),
                  // ItemViewCard(
                  //   title: 'LOGOUT',
                  //   info: 'Logout from all activities',
                  //   icon: Icons.logout,
                  //   onTap: () {
                  //     logOutUser(context);
                  //   },
                  // ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
