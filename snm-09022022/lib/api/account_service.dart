import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:dil_app/config/common_const.dart';
import 'package:dil_app/model/account_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AccountService {
  // request for account
  Future createAccount({
    @required String userCode,
    @required String clientName,
    @required String clientID,
    @required String projectName,
    @required String projectID,
    @required String name,
    @required String email,
    @required String mobileNo,
    @required String deptName,
    @required String designationName,
  }) async {
    Map data = {
      "userCode": userCode,
      "clientName": clientName,
      "clientID": clientID,
      "projectName": projectName,
      "projectID": projectID,
      "name": name,
      "email": email,
      "mobileNo": mobileNo,
      "deptName": deptName,
      "designationName": designationName,
    };

    var body = json.encode(data);
    String extUrl = 'create_client_user';
    Uri url = Uri.parse(baseUrl + extUrl);
    //String url = 'http://192.168.0.89/ati-erp/api/create_client_user';

    final http.Response response = await http.post(url, body: body);
    print(response.body);
    log(body);

    if (response.statusCode == 200) {
      log(response.body);
      print('Account Create Successful!!!');
      return json.decode(response.body);
    } else {
      throw Exception('Failed to submit');
    }
  }

  //fetch requested account info
  Future<AccountModel> fetchAccountData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userCode = prefs.getString('userCode').toString();
    Map data = {"CREATED_BY": userCode};
    var body = json.encode(data);
    String extUrl = 'get_client_request';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = "http://192.168.0.89/ati-erp/api/get_client_request";

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body
    );
    if (response.statusCode == 200) {
      // log(response.body);
      print('Account Info Request Successful!!!');
      return accountModelFromJson(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
