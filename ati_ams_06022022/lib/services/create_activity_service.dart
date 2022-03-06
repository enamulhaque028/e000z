import 'dart:convert';
import 'dart:developer';
import 'package:ati_ams/config/common_const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateEventService {
  Future createEvent({
    @required String activityId,
    @required String topicId,
    @required String authorizerId,
    @required String date,
    @required String startTime,
    @required String endTime,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String studentId =
        prefs.getString('studentId').toString(); // sp value is det from login

    Map data = {
      "student_id": studentId,
      "activity": activityId,
      "topic_name": topicId,
      "activity_authorize": authorizerId,
      "attendance_status": "1",
      "date": date,
      "submission_time": startTime,
      "submission_end_time": endTime,
      "created_by": studentId
    };
    var body = json.encode(data);
    String extUrl = 'create_activity_attendance';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = "http://192.168.0.89:8000/birdem-ams/api/create_activity_attendance";

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    log(body.toString());
    if (response.statusCode == 200) {
      // log(response.body);
      print('Create Event Successful!!!');
      return jsonDecode(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
