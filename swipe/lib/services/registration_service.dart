import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:swipe/config/utils/constants.dart';

class RegistrationService {
  int statusCode = 0;

  Future userRegistration({
    required String name,
    required String email,
    required String password,
    required String gender,
    required String birthday,
    required String country,
    required String countryCode,
  }) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
      "gender": gender,
      "birthday": birthday,
      "country": country,
      "countryCode": countryCode
    };
    var body = json.encode(data);
    String extUrl = 'auth/register';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = 'https://aos-swipe-backend.herokuapp.com/auth/register';

    final http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    log(response.body);
    log(body);
    log(response.statusCode.toString());
    statusCode = response.statusCode;
    if (response.statusCode == 201) {
      print('Registration successful!!!');
      // return jsonDecode(response.body);
    } else {
      log('Registration failed');
      // log(response.statusCode.toString());
      return jsonDecode(response.body);
    }
  }
}
