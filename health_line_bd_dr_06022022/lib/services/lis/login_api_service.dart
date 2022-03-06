import 'dart:developer';
import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/config/sp_utils.dart';
import 'package:health_line_bd/model/lis/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class APIService {
  Future lisLogin(LoginRequestModelLIS requestModel) async {
    try {
      String extUrl = 'user/login';
      Uri url = Uri.parse(baseUrlLis + extUrl);
      // String url = "http://192.168.0.54:8088/ords/ordstest/user/login";
      final response = await http.post(
        url,
        body: requestModel.toJson(),
      );
      //print('body: [${response.body}]');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (response.statusCode == 200 &&
          response.body != null &&
          response.body.isNotEmpty) {
        log('body: [${response.body}]');
        prefs.setString('apiresp', response.body);
        return json.decode(response.body);
      } else {
        //throw Exception('Failed to load data!');
        print('Invalid credentials or connection problem');
      }
    } catch (e) {
      print(e);
      //return null;
    }
  }

  Future login(LoginRequestModel requestModel) async {
    try {
      String extUrl = 'user/login';
      Uri url = Uri.parse(baseUrl + extUrl);
      // String url = "https://bdhealthline.net/health-line-bd-ws/api/user/login";
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestModel.toJson()),
      );
      //print('body: [${response.body}]');
      print('status code: ${response.statusCode}');
      if (response.statusCode == 200 &&
          response.body != null &&
          response.body.isNotEmpty) {
        log('body: [${response.body}]');
        var jsonResponse = json.decode(response.body);
        SharedPref().setLoginResp(response.body);
        SharedPref().setDrName(jsonResponse['listResponse'][0]['doctorName']);
        SharedPref().setDrEmail(jsonResponse['objResponse']['userEmail']);
        SharedPref().setDrMobileNo(jsonResponse['objResponse']['mobileNo']);
        SharedPref().setDrRegNo(jsonResponse['listResponse'][0]['bmdcRegNo']);
        SharedPref().setDrDegree(jsonResponse['listResponse'][0]['degree']);
        SharedPref()
            .setDrDept(jsonResponse['listResponse'][0]['specialityName']);
        SharedPref()
            .setDrProfileImg(jsonResponse['listResponse'][0]['imgPath']);
        SharedPref()
            .setDrSignImg(jsonResponse['listResponse'][0]['sigImgPath']);
        return json.decode(response.body);
      } else {
        //throw Exception('Failed to load data!');
        print('Invalid credentials or connection problem');
      }
    } catch (e) {
      print(e);
      //return null;
    }
  }
}
