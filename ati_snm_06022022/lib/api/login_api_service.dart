import 'package:dil_app/config/common_const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/login_model.dart';

class APIService {
  Future login(LoginRequestModel requestModel) async {
    try {
      String extUrl = 'appLogin';
      Uri url = Uri.parse(baseUrl + extUrl);
      //String url = "http://203.130.133.166/ATI-ERP2/api/appLogin";
      final response = await http.post(url, body: requestModel.toJson());
      //print('body: [${response.body}]');
      if (response.statusCode == 200 &&
          response.body != null &&
          response.body.isNotEmpty) {
        //print('body: [${response.body}]');
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
