import 'dart:convert';
import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/model/activity_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ActivityService {
  Future<ActivityModel> fetchActivityData() async {
    // sp value is set from login
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String studentId = prefs.getString('studentId').toString();
    Map data = {
      "student_id": studentId,
    };
    var body = json.encode(data);
    String extUrl = 'get_student_activity_attendance';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = "http://192.168.0.89:8000/birdem-ams/api/get_student_activity_attendance";

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      // log(response.body);
      print('Activity Info Request Successful!!!');
      return activityModelFromJson(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
