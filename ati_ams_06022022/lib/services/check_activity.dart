import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ati_ams/config/common_const.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckActivity {
  Future checkStudentActivity({
    @required String activityId,
    @required String activityDate,
  }) async {
    // below sp values are set in login
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String studentId = prefs.getString('studentId').toString();
    Map data = {
      "student_id": studentId,
      "activity": activityId,
      "activity_date": activityDate,
    };
    var body = json.encode(data);
    String extUrl = 'check_student_activity_attendance';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = " http://192.168.0.89:8000/birdem-ams/api/check_student_activity_attendance";

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    log('::::::::::::::$body:::::::::::::');
    if (response.statusCode == 200) {
      log(response.body);
      print('Activity attendance check Successful!!!');
      return json.decode(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
