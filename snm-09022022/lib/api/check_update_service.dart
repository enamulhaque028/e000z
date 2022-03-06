import 'dart:convert';
import 'dart:developer';
import 'package:dil_app/config/common_const.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CheckUpdate {
  Future fetchInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var saUserID = prefs.getString('saUserID');
    Map data = {
    "ATIAPPL_ID": "5",
    "SAUSERS_ID": saUserID
  };
    var body = json.encode(data);
    String extUrl = 'appData';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = "http://192.168.0.54:8088/ords/ordstest/user/vrsn";

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    // print('::::::::::::::check_update_body: $body ::::::::::::::');
    if (response.statusCode == 200) {
      log('check_update_response: ${response.body}');
      return jsonDecode(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
