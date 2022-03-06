import 'dart:convert';
import 'dart:developer';
import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/model/lis/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  Future fetchProfileData(bool isIdFromAccount, String pId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var patientId =
        isIdFromAccount == false ? prefs.getString('patientId') : pId;

    String extUrl = 'patget/pget';
    Uri url = Uri.parse(baseUrlLis + extUrl);
    // String url = "http://192.168.0.54:8088/ords/ordstest/patget/pget";

    Map data = {"P_PATIENTID": patientId.toString()};
    var body = json.encode(data);

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    print(body);
    if (response.statusCode == 200) {
      log(response.body);
      return profileFromJson(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
