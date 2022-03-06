import 'dart:convert';

import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/model/attendance_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceService {
  Future<AttendanceModel> fetchAttendanceData() async {
    // below sp values are set in login
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String departmentId = prefs.getString('departmentId').toString();
    String courseType = prefs.getString('courseType').toString();
    String courseNameId = prefs.getString('courseNameId').toString();
    Map data = {
      "department_id": departmentId,
      "course_type": courseType,
      "course_name_id": courseNameId,
    };
    var body = json.encode(data);
    String extUrl = 'class_routine';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = "http://192.168.0.89:8000/birdem-ams/api/class_routine";

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      // log(response.body);
      print('Class Info Request Successful!!!');
      return attendanceModelFromJson(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
