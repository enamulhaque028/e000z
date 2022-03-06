import 'dart:developer';

import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/model/event_model.dart';
import 'package:ati_ams/model/geodata_model.dart';
import 'package:ati_ams/pages/home/event/create_event/create_event_dialog.dart';
import 'package:ati_ams/services/event_service.dart';
import 'package:ati_ams/services/geodata_service.dart';
import 'package:ati_ams/widgets/attendance_dialog.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'view/event_view.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  var isLoading = true;
  EventModel eventData = new EventModel();
  GeoDataModel geoData = new GeoDataModel();
  String institutionCode;
  String date = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
  String time = DateFormat.jm().format(DateTime.now()).toString();

  @override
  void initState() {
    EventService().fetchEventData().then((data) {
      setState(() {
        eventData = data;
      });
    }).then((value) {
      getRespFromSP().then((value) {
        String institutionCodeSP = institutionCode.toString() == 'null'
            ? 'BIRDEM_01'
            : institutionCode.toString();
        log('event_page: $institutionCodeSP');
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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : eventData.data.eventInfo.isEmpty
              ? Center(
                  child: Text('No event found!'),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  itemCount: eventData.data.eventInfo.length,
                  itemBuilder: (context, index) {
                    var eventInfo = eventData.data.eventInfo[index];
                    String eventStartDate = DateFormat('dd-MM-yyyy')
                        .format(eventInfo.start)
                        .toString();
                    String eventEndDate = DateFormat('dd-MM-yyyy')
                        .format(eventInfo.end)
                        .toString();
                    return EventTile(
                      name: eventInfo.title.toString(),
                      topic: eventInfo.topicName.toString(),
                      authorizedBy: eventInfo.activityAuthorize.toString(),
                      activityName: eventInfo.activityName.toString(),
                      address: eventInfo.deptName.toString(),
                      duration: '$eventStartDate - $eventEndDate',
                      attendanceDate: '08-10-2021',
                      attendanceTime: '10:30 AM',
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
                                  return AttendanceDialog(
                                    alertText:
                                        "Would you like to attend in this event?",
                                    geoData: geoData.data,
                                    date: date,
                                    time: time,
                                    dutySession: "",
                                    department: eventInfo.department.toString(),
                                    courseType: eventInfo.courseType.toString(),
                                    courseName: eventInfo.courseName.toString(),
                                    attendanceType: "A",
                                    classRoutineId: "",
                                    activityId: eventInfo.id.toString(),
                                    institute: "",
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
                    );
                  },
                ),
    );
  }
}
