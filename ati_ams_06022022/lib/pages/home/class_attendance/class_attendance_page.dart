import 'dart:developer';

import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/model/attendance_model.dart';
import 'package:ati_ams/model/geodata_model.dart';
import 'package:ati_ams/services/attendance_service.dart';
import 'package:ati_ams/services/check_class_attendance_service.dart';
import 'package:ati_ams/services/geodata_service.dart';
import 'package:ati_ams/widgets/attendance_dialog.dart';
import 'package:ati_ams/widgets/custom_progress.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'view/attendance_view.dart';

class ClassAttendancePage extends StatefulWidget {
  const ClassAttendancePage({Key key}) : super(key: key);

  @override
  _ClassAttendancePageState createState() => _ClassAttendancePageState();
}

class _ClassAttendancePageState extends State<ClassAttendancePage> {
  var isLoading = true;
  bool isApiCallProcess = false;
  AttendanceModel attendanceData = new AttendanceModel();
  GeoDataModel geoData = new GeoDataModel();
  String institutionCode;
  String date = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
  String time = DateFormat.jm().format(DateTime.now()).toString();

  @override
  void initState() {
    AttendanceService().fetchAttendanceData().then((data) {
      setState(() {
        attendanceData = data;
        // isLoading = false;
      });
    }).then((value) {
      getRespFromSP().then((value) {
        String institutionCodeSP = institutionCode.toString() == 'null'
            ? 'BIRDEM_01'
            : institutionCode.toString();
        log('class_page: $institutionCodeSP');
        GeoDataService().fetchGeoData(institutionCodeSP).then((value) {
          setState(() {
            geoData = value;
            isLoading = false;
          });
        });
      });
    });
    super.initState();
  }

  Future getRespFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    institutionCode = prefs.getString('institution');
    return institutionCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeaf4ff),
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Color(PrimaryColor),
        title: Text('Class Attendance'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : attendanceData.data.isEmpty
              ? Center(
                  child: Text('No class found!'),
                )
              : ProgressHUD(
                  inAsyncCall: isApiCallProcess,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    itemCount: attendanceData.data.length,
                    itemBuilder: (context, index) {
                      var attendanceInfo = attendanceData.data[index];
                      String classStartDate = DateFormat('dd-MM-yyyy')
                          .format(attendanceInfo.classStartDate)
                          .toString();
                      String classStartTime = DateFormat.jm()
                          .format(attendanceInfo.classStartTime)
                          .toString();
                      String classEndTime = DateFormat.jm()
                          .format(attendanceInfo.classEndTime)
                          .toString();
                      final now = DateTime.now();
                      final today = DateTime(now.year, now.month, now.day);
                      final dateToCheck = DateTime.parse(
                          attendanceInfo.classStartDate.toIso8601String());
                      final aDate = DateTime(
                          dateToCheck.year, dateToCheck.month, dateToCheck.day);
                      return AttendanceTile(
                        department: attendanceInfo.deptName.toString(),
                        courseName: attendanceInfo.courseName,
                        classTopic: attendanceInfo.topicName.toString(),
                        instructor: attendanceInfo.teacherName.toString(),
                        date: classStartDate.toString(),
                        duration: '$classStartTime - $classEndTime',
                        attendanceDate: '08-10-2021',
                        attendanceTime: '10:30 AM',
                        onTapAttendance: () {
                          setState(() {
                            isApiCallProcess = true;
                          });
                          CheckClassAttendanceService()
                              .checkBlock()
                              .then((value) {
                            if (value['data']['block_status'].toString() ==
                                '0') {
                              setState(() {
                                isApiCallProcess = false;
                              });
                              CoolAlert.show(
                                  context: context,
                                  // width: 350,
                                  type: CoolAlertType.warning,
                                  text: 'You are not in block!');
                            } else {
                              CheckClassAttendanceService()
                                  .checkAttendance(
                                      classRoutineId:
                                          attendanceInfo.id.toString(),
                                      classStartDate: classStartDate)
                                  .then((value) {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                if (value['data']['calss_atten_status']
                                        .toString() ==
                                    '0') {
                                  if (aDate == today) {
                                    geoData.data.isEmpty
                                        ? CoolAlert.show(
                                            context: context,
                                            // width: 350,
                                            type: CoolAlertType.warning,
                                            text:
                                                'Selected institute data not found!')
                                        : showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AttendanceDialog(
                                                alertText:
                                                    "Would you like to attend in this class?",
                                                geoData: geoData.data,
                                                date: date,
                                                time: time,
                                                dutySession: '1',
                                                department: attendanceInfo
                                                    .departmentId
                                                    .toString(),
                                                courseType: attendanceInfo
                                                    .courseType
                                                    .toString(),
                                                courseName: attendanceInfo
                                                    .courseNameId
                                                    .toString(),
                                                attendanceType: "C",
                                                classRoutineId: attendanceInfo
                                                    .id
                                                    .toString(),
                                                activityId: "",
                                                institute: "",
                                                activityAuthorize: "",
                                                classDate: attendanceInfo
                                                    .classStartDate
                                                    .toString(),
                                                dayName: attendanceInfo.dayName
                                                    .toString(),
                                                blockId: attendanceInfo.blockId
                                                    .toString(),
                                                classStartTime: attendanceInfo
                                                    .classStartTime
                                                    .toString(),
                                                classEndTime: attendanceInfo
                                                    .classEndTime
                                                    .toString(),
                                                classType: attendanceInfo
                                                    .classType
                                                    .toString(),
                                                classRoom: attendanceInfo
                                                    .classRoom
                                                    .toString(),
                                                teacherId: attendanceInfo
                                                    .teacherId
                                                    .toString(),
                                                topicId: attendanceInfo.topicId
                                                    .toString(),
                                              );
                                            },
                                          );
                                  } else {
                                    CoolAlert.show(
                                        context: context,
                                        // width: 350,
                                        type: CoolAlertType.warning,
                                        text:
                                            'You can\'t give attendance for this class now!');
                                  }
                                } else {
                                  CoolAlert.show(
                                      context: context,
                                      // width: 350,
                                      type: CoolAlertType.warning,
                                      text:
                                          'Your attendance has already been recorded!');
                                }
                              });
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
    );
  }
}
