import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:dil_app/config/common_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserReviewService {
  Future sendUserReview({
    @required String title,
    @required String description,
    @required String type,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String saUserID = prefs.getString('saUserID');
    Map data = {
      "userCode": saUserID,
      "title": title,
      "description": description,
      "type": type,
    };

    var body = json.encode(data);
    // String extUrl = 'create_client_user';
    // Uri url = Uri.parse(baseUrl + extUrl);
    //String url = 'http://192.168.0.89/ati-erp/api/create_client_user';

    // final http.Response response = await http.post(url, body: body);
    // print(response.body);
    log(body);

    // if (response.statusCode == 200) {
    //   log(response.body);
    //   return json.decode(response.body);
    // } else {
    //   throw Exception('Failed to submit');
    // }
  }
}
