import 'dart:developer';
import 'package:ati_ams/model/geodata_model.dart';
import 'package:ati_ams/services/send_attendance_service.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'custom_progress.dart';

class AttendanceDialog extends StatefulWidget {
  final String alertText;
  final List<Datum> geoData;
  final String date;
  final String time;
  final String dutySession;
  final String department;
  final String courseType;
  final String courseName;
  final String attendanceType;
  final String classRoutineId;
  final String activityId;
  final String institute;
  final String activityAuthorize;
  final String classDate;
  final String dayName;
  final String blockId;
  final String classStartTime;
  final String classEndTime;
  final String classType;
  final String classRoom;
  final String teacherId;
  final String topicId;
  const AttendanceDialog({
    Key key,
    @required this.alertText,
    @required this.geoData,
    @required this.department,
    @required this.courseType,
    @required this.courseName,
    @required this.attendanceType,
    @required this.classRoutineId,
    @required this.activityId,
    @required this.date,
    @required this.time,
    @required this.dutySession,
    @required this.institute,
    @required this.activityAuthorize,
    @required this.classDate,
    @required this.dayName,
    @required this.blockId,
    @required this.classStartTime,
    @required this.classEndTime,
    @required this.classType,
    @required this.classRoom,
    @required this.teacherId,
    @required this.topicId,
  }) : super(key: key);

  @override
  _AttendanceDialogState createState() => _AttendanceDialogState();
}

class _AttendanceDialogState extends State<AttendanceDialog> {
  var currentLat = 0.0;
  var currentLong = 0.0;
  bool isOnPolygon = false;

  bool isApiCallProcess = false;
  double minDistance = 0.0;
  List<LatLng> polygon = [];
  // List<LatLng> polygonVal = [];

  //GET CURRENT LOCATION
  Future getCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {
      currentLat = _locationData.latitude;
      currentLong = _locationData.longitude;
    });
    log('Current LatLng: $currentLat, $currentLong');
    // return currentLong;
  }

  //CHECK IF USER IN POLYGOJN
  isInBoundary() {
    LatLng point = LatLng(currentLat, currentLong);

    setState(() {
      isOnPolygon = PolygonUtil.containsLocation(point, polygon, true);
    });

    //calculate shortest path between a LatLng point(current location) and polygon points
    List distanceList = [];
    for (int i = 0; i < polygon.length - 1; i++) {
      var dist = SphericalUtil.computeDistanceBetween(
        LatLng(currentLat, currentLong),
        polygon[i],
      );
      distanceList.add(dist);
      // log('Distance[${i + 1}]: $dist');
    }
    setState(() {
      minDistance =
          distanceList.reduce((curr, next) => curr > next ? curr : next);
    });
    // log(distanceList.length.toString());
    // log('Max distance: ${distanceList.reduce((curr, next) => curr > next ? curr : next).toString()}');
    // log('Min distance: ${distanceList.reduce((curr, next) => curr < next ? curr : next).toString()}');
    // log(isOnPolygon.toString());
  }

  @override
  void initState() {
    for (int i = 0; i < widget.geoData.length; i++) {
      setState(() {
        polygon.add(LatLng(widget.geoData[i].lat, widget.geoData[i].lng));
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // set up the buttons
    // ignore: deprecated_member_use
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        log(polygon.length.toString());
        Navigator.of(context).pop();
      },
    );
    // ignore: deprecated_member_use
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        setState(() {
          isApiCallProcess = true;
        });
        getCurrentLocation().then((value) {
          isInBoundary();
        }).then((value) {
          log(isOnPolygon.toString());
          isOnPolygon
              ? sendAttendance()
              : () {
                  setState(() {
                    isApiCallProcess = false;
                  });
                  Navigator.of(context).pop();
                  CoolAlert.show(
                    context: context,
                    // width: 350,
                    type: CoolAlertType.error,
                    text:
                        'Your are ${minDistance.toStringAsFixed(2)} meters away from your destination.',
                  );
                }();
        });
      },
    );
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: AlertDialog(
        title: Text("Attendance"),
        content: Text(widget.alertText),
        actions: [
          cancelButton,
          continueButton,
        ],
      ),
    );
  }

  sendAttendance() {
    SendAttendanceInfo()
        .sendAttendance(
            date: widget.date,
            time: widget.time,
            dutySession: widget.dutySession,
            department: widget.department,
            courseType: widget.courseType,
            courseName: widget.courseName,
            attendanceType: widget.attendanceType,
            currentLat: currentLat.toString(),
            currentLng: currentLong.toString(),
            classRoutineId: widget.classRoutineId,
            activityId: widget.activityId,
            institute: widget.institute,
            activityAuthorize: widget.activityAuthorize,
            classDate: widget.classDate,
            dayName: widget.dayName,
            blockId: widget.blockId,
            classStartTime: widget.classStartTime,
            classEndTime: widget.classEndTime,
            classType: widget.classType,
            classRoom: widget.classRoom,
            teacherId: widget.teacherId,
            topicId: widget.topicId)
        .then((value) {
      value['success'].toString() == 'true'
          ? () {
              setState(() {
                isApiCallProcess = false;
              });
              Navigator.of(context).pop();
              CoolAlert.show(
                context: context,
                // width: 350,
                type: CoolAlertType.success,
                text: 'Your attendance has been recorded',
              );
            }()
          : () {
              setState(() {
                isApiCallProcess = false;
              });
              Navigator.of(context).pop();
              CoolAlert.show(
                context: context,
                // width: 350,
                type: CoolAlertType.error,
                text: 'Failed to send attendance!!! Try again',
              );
            }();
    });
  }
}
