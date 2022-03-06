import 'dart:convert';
import 'dart:developer';
import 'package:ati_ams/model/geodata_model.dart';
import 'package:ati_ams/pages/home/profile/edit/widgets/image_picker.dart';
import 'package:ati_ams/services/geodata_service.dart';
import 'package:ati_ams/widgets/attendance_dialog.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'view/dashboard_view.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map apiResp = {};
  bool isLoading = true;
  GeoDataModel geoData = new GeoDataModel();
  String institutionCode;
  String date = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
  String time = DateFormat.jm().format(DateTime.now()).toString();
  String imageUrl = '';
  String name = '';
  String institutionCodeSP = '';
  @override
  void initState() {
    getRespFromSP().then((data) {
      setState(() {
        apiResp = data['data']['user_info'];
      });
    }).then((value) {
      institutionCodeSP = institutionCode.toString() == 'null'
          ? 'BIRDEM_01'
          : institutionCode.toString();
      log('dashboard_page: $institutionCodeSP');
      GeoDataService().fetchGeoData(institutionCodeSP).then((value) {
        setState(() {
          geoData = value;
          isLoading = false;
        });
      });
    });
    super.initState();
  }

  Future getRespFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiResp = json.decode(prefs.getString('apiresp'));
    institutionCode = prefs.getString('institution');
    imageUrl = prefs.getString('imageUrl');
    name = prefs.getString('studentName');
    return apiResp;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   brightness: Brightness.dark,
        //   backgroundColor: Color(PrimaryColor),
        //   title: Text('Dashboard'),
        // ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : DashboardTile(
                name: name.toString(),
                id: apiResp['stu_id'].toString(),
                department: apiResp['DEPARTMENT'].toString(),
                gender: apiResp['GENDER'].toString(),
                dateOfBirth: apiResp['date_of_birth'].toString(),
                profileImage: (apiResp['students_image'].toString() == '' &&
                        PickImages.profileImgPath == '')
                    ? ''
                    : imageUrl,
                onTapAttendance: () {
                  geoData.data.isEmpty
                      ? CoolAlert.show(
                          context: context,
                          // width: 350,
                          type: CoolAlertType.warning,
                          text: 'Selected institute data not found!')
                      : showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            String institute =
                                institutionCodeSP == 'BIRDEM_01' ? '1' : '2';
                            return AttendanceDialog(
                              alertText:
                                  "Would you like to attend in this institution?",
                              geoData: geoData.data,
                              date: date,
                              time: time,
                              dutySession: "1",
                              department: apiResp['department'].toString(),
                              courseType: apiResp['course_type'].toString(),
                              courseName: apiResp['course_name'].toString(),
                              attendanceType: "I",
                              classRoutineId: "",
                              activityId: "",
                              institute: institute,
                              activityAuthorize: "",
                              classDate: '',
                              dayName: '',
                              blockId: '',
                              classStartTime: '',
                              classEndTime: '',
                              classType: '',
                              classRoom: '',
                              teacherId: '',
                              topicId: '',
                            );
                          },
                        );
                },
              ),
      ),
    );
  }
}
