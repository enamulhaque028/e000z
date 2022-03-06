import 'dart:developer';
import 'package:ati_ams/config/common_const.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/login_model.dart';

class APIService {
  Future login(LoginRequestModel requestModel) async {
    try {
      String extUrl = 'login';
      Uri url = Uri.parse(baseUrl + extUrl);
      final response = await http.post(
        url,
        body: requestModel.toJson(),
      );
      print(requestModel.toJson());
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
}
