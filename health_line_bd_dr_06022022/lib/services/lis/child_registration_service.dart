import 'dart:developer';
import 'package:health_line_bd/config/common_const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

int statusCodeChild;

Future sumbitChildRegistrationData(
    String name,
    String mobileNo,
    String email,
    String genderID,
    String bloodGrpID,
    String birthDate,
    int ageDay,
    int ageMonth,
    int ageYear,
    String maritialID,
    String relationID,
    String fileDownloadUrl) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String parentId = prefs.getString('parentId');
  Map data = {
    "REG_REQ_ID": 0,
    "PARENTS_ID": parentId,
    "REQSTER_NM": name,
    "SORGNDR_NO": genderID,
    "DTOF_BIRTH": birthDate,
    "NOF_AGE_YY": ageYear,
    "NOF_AGE_MM": ageMonth,
    "NOF_AGE_DD": ageDay,
    "BLD_GRP_NO": bloodGrpID,
    "CMOBILE_NO": mobileNo,
    "EMAIL_ADDR": email,
    "MSTATUS_ID": maritialID,
    "RELTION_ID": relationID,
    "PHOTO_LOCA": fileDownloadUrl
  };
  var body = json.encode(data);
  String extUrl = 'cmh/dpnreg';
  Uri url = Uri.parse(baseUrlLis + extUrl);
  // String url = 'http://192.168.0.54:8088/ords/ordstest/cmh/dpnreg';

  final http.Response response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  log(response.body);
  log(body);
  statusCodeChild = response.statusCode;
  if (response.statusCode == 200) {
    print('Registration successful!!!');
    // return jsonDecode(response.body);
  } else {
    log('Registration failed');
    // log(response.statusCode.toString());
    // return jsonDecode(response.body);
  }
}
