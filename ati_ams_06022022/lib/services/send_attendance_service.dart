import 'dart:developer';
import 'package:ati_ams/config/common_const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

var checkInOutDayVal = ValueNotifier<String>('null');

class SendAttendanceInfo {
  Future sendAttendance({
    @required String department,
    @required String courseType,
    @required String courseName,
    @required String attendanceType,
    @required String currentLat,
    @required String currentLng,
    @required String classRoutineId,
    @required String activityId,
    @required String date,
    @required String time,
    @required String dutySession,
    @required String institute,
    @required String activityAuthorize,
    @required String classDate,
    @required String dayName,
    @required String blockId,
    @required String classStartTime,
    @required String classEndTime,
    @required String classType,
    @required String classRoom,
    @required String teacherId,
    @required String topicId,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dayToday = attendanceType == 'I'
        ? DateTime.now().day.toString()
        : prefs.getString('checkInOutDay').toString();
    String studentId = prefs.getString('studentId').toString();
    Map classData = {
      "student_id": studentId,
      "class_date": classDate,
      "day_name": dayName,
      "block_id": blockId,
      "class_start_time": classStartTime,
      "class_end_time": classEndTime,
      "class_type": classType,
      "class_room": classRoom,
      "teacher_id": teacherId,
      "topic_id": topicId,
      "attendance_type": attendanceType,
      "lat": currentLat,
      "lng": currentLng,
      "class_routine_id": classRoutineId,
      "attendance_status": "1"
    };
    Map commonData = {
      "student_id": studentId,
      "date": date,
      "submission_time": time,
      "duty_session": dutySession,
      "department": department,
      "course_type": courseType,
      "course_name": courseName,
      "attendance_type": attendanceType,
      "lat": currentLat,
      "lng": currentLng,
      "class_routine_id": classRoutineId,
      "attendance_status": "1",
      "activity": activityId,
      "inistitute": institute,
      "submission_end_time": time,
      "activity_authorize": activityAuthorize,
    };
    Map data = attendanceType == 'C' ? classData : commonData;
    var body = json.encode(data);
    String extUrl = 'stu_attendance';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = 'http://192.168.0.89:8000/birdem-ams/api/stu_attendance';

    final http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    log(response.body);
    log(body);

    if (response.statusCode == 200 &&
        response.body != null &&
        response.body.isNotEmpty) {
      prefs.setString('checkInOutDay',
          dayToday); // set day to to check institute in/out condition
      checkInOutDayVal.value = dayToday;
      print('Send Attendance Succesfully!!!');
      return jsonDecode(response.body);
    } else {
      log('Failed to send attendance!!!');
      // log(response.statusCode.toString());
      // return jsonDecode(response.body);
    }
  }
}
