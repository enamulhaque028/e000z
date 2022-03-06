import 'dart:convert';

import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/model/event_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EventService {
  Future fetchEventData() async {
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
    String extUrl = 'get_events';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = "http://192.168.0.89:8000/birdem-ams/api/get_events";

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      // log(response.body);
      print('Event Info Request Successful!!!');
      return eventModelFromJson(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
