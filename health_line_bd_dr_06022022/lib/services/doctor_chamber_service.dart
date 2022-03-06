import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/model/chamber_model.dart';
import 'package:http/http.dart' as http;

class DoctorChamberService {
  Future<DoctorChamberModel> fetchDoctorChamber(
      {@required String currentChember}) async {
    String extUrl = 'chamber/84/$currentChember'; //84 ==> userId from login
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = "https://bdhealthline.net/health-line-bd-ws/api/chamber/84/55";

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    // log(response.body);
    // log(body);
    log(url.toString());
    if (response.statusCode == 200) {
      // log(response.body);
      log('Doctor chamber data retrived successful!!!');
      return doctorChamberModelFromJson(response.body);
    } else {
      log('Doctor chamber data retrived failed!!!');
      // log(response.statusCode.toString());
      return jsonDecode(response.body);
    }
  }
}
