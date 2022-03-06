import 'dart:convert';
import 'dart:developer';
import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/model/history/class_history_model.dart';
import 'package:ati_ams/model/history/event_history_model.dart';
import 'package:ati_ams/model/history/institute-history_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  Future fetchHistoryData({
    @required String attendanceType,
    @required String startDate,
    @required String endDate,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String studentId =
        prefs.getString('studentId').toString(); // sp value is det from login
    Map data = {
      "student_id": studentId,
      "attendance_type": attendanceType,
      "from_date": startDate,
      "to_date": endDate,
    };
    var body = json.encode(data);
    String extUrl = 'get_stu_attendance';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = "http://192.168.0.89:8000/birdem-ams-api/api/get_stu_attendance";

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    // log(response.body);
    // log(body);
    if (response.statusCode == 200) {
      log(response.body);
      // print('History Data Request Successful!!!');
      return attendanceType == "I"
          ? instituteHistoryModelFromJson(response.body)
          : attendanceType == "A"
              ? eventHistoryModelFromJson(response.body)
              : attendanceType == "C"
                  ? classHistoryModelFromJson(response.body)
                  : Container();
    } else {
      log('History Data Request failed!!!');
      // log(response.statusCode.toString());
      // return jsonDecode(response.body);
    }
  }
}
