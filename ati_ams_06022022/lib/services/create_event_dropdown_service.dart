import 'dart:convert';
import 'dart:developer';
import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/model/create_event_dropdown_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateEventDropdownService {
  Future<CreateEventDropdownModel> fetchDropdownData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String studentId =
        prefs.getString('studentId').toString(); // sp value is set from login

    String extUrl = 'get_activity_attendance_info';
    Uri url = Uri.parse(baseUrl + extUrl);

    Map data = {
      "student_id": studentId,
    };
    var body = json.encode(data);
    log(url.toString());
    log(body);
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      // log(response.body);
      return createEventDropdownModelFromJson(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
