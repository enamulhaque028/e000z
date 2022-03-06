import 'dart:convert';
import 'dart:developer';

import 'package:ati_ams/config/common_const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateInfoService {
  Future studentInfoUpdate({
    @required String name,
    @required String profileImgPath,
    @required String signatureImgPath,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String studentId =
        prefs.getString('studentId').toString(); // sp value is det from login

    String extUrl = 'update_stud_info';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = "http://192.168.0.89:8000/birdem-ams/api/update_stud_info";

    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({'student_id': studentId, 'students_name': name});

    profileImgPath == ''
        ? Container()
        : request.files
            .add(await http.MultipartFile.fromPath('file', profileImgPath));
    signatureImgPath == ''
        ? Container()
        : request.files.add(
            await http.MultipartFile.fromPath('signature', signatureImgPath));

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      Map resp = json.decode(responseBody);
      log(responseBody);
      return resp;
    } else {
      log(response.reasonPhrase);
    }
  }
}
