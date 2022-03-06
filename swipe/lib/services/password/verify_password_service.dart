import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:swipe/config/utils/constants.dart';

class VerifyPasswordService {
  int statusCode = 0;

  Future verifyCode({required String email, required String code}) async {
    Map data = {"email": email, "code": code};
    var body = json.encode(data);
    String extUrl = 'auth/forgot/verify';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = 'https://aos-swipe-backend.herokuapp.com/auth/forgot/verify';

    final http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    log(response.body);
    log(body);
    log(response.statusCode.toString());
    statusCode = response.statusCode;
    if (response.statusCode == 200) {
      print('Verify code successful!!!');
      return jsonDecode(response.body);
    } else {
      log('Verify code failed');
      // log(response.statusCode.toString());
      return jsonDecode(response.body);
    }
  }
}
