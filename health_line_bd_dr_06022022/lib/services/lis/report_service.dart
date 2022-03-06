import 'dart:convert';
import 'dart:developer';
import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/model/lis/report_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PatientService {
  Future fetchPatientInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var patientId = prefs.getString('patientId');
    Map data = {"P_PATIENT_ID": patientId.toString()};
    var body = json.encode(data);
    String extUrl = 'report/rget';
    Uri url = Uri.parse(baseUrlLis + extUrl);
    // String url = "http://192.168.0.54:8088/ords/ordstest/report/rget";

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    print(body);
    if (response.statusCode == 200) {
      log(response.body);
      return reportFromJson(response.body);
    } else {
      log('failed to load Report');
      throw Exception("Unable to perform request!");
    }
  }
}
