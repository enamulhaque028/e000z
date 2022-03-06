import 'dart:convert';
import 'dart:developer';
import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/model/lis/accounts_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AccountService {
  Future fetchAccountInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String patientId = prefs.getString('patientId');
    Map data = {"P_PATIENTID": patientId.toString()};
    var body = json.encode(data);
    String extUrl = 'patget/getpat';
    Uri url = Uri.parse(baseUrlLis + extUrl);
    // String url = "http://192.168.0.54:8088/ords/ordstest/patget/getpat";

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    print(body);
    if (response.statusCode == 200) {
      log(response.body);
      return accountsFromJson(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
