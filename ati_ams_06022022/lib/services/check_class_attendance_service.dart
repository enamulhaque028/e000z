import 'dart:convert';
import 'dart:developer';
import 'package:ati_ams/config/common_const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CheckClassAttendanceService {
  //check student block
  Future checkBlock() async {
    // below sp values are set in login
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String studentId = prefs.getString('studentId').toString();
    Map data = {"student_id": studentId};
    var body = json.encode(data);
    String extUrl = 'check_student_block';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = "http://192.168.0.89:8000/birdem-ams/api/check_student_block";

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      log(response.body);
      print('Class block check Successful!!!');
      return json.decode(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  //check student attendance
  Future checkAttendance({
    @required String classRoutineId,
    @required String classStartDate,
  }) async {
    // below sp values are set in login
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String studentId = prefs.getString('studentId').toString();
    Map data = {
      "student_id": studentId,
      "class_routint_id": classRoutineId,
      "class_start_date": classStartDate,
    };
    var body = json.encode(data);
    String extUrl = 'check_student_class_attendance';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = "http://192.168.0.89:8000/birdem-ams/api/check_student_class_attendance";

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      log(response.body);
      print('Class attendance check Successful!!!');
      return json.decode(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
