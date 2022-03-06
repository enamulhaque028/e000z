import 'dart:convert';
import 'dart:developer';
import 'package:health_line_bd/config/common_const.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';

class CheckUpdate {
  Future fetchInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int versionCode = int.parse(packageInfo.buildNumber);
    Map data = {"P_MOBIAPSID": versionCode.toString()};
    var body = json.encode(data);
    String extUrl = 'user/vrsn';
    Uri url = Uri.parse(baseUrlLis + extUrl);
    // String url = "http://192.168.0.54:8088/ords/ordstest/user/vrsn";

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    print(body);
    if (response.statusCode == 200) {
      log(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
