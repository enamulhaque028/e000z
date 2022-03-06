import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:swipe/config/utils/constants.dart';

class ForgotPasswordService {
  int statusCode = 0;

  Future sendCode({
    required String email,
  }) async {
    Map data = {"email": email};
    var body = json.encode(data);
    String extUrl = 'auth/forgot';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = 'https://aos-swipe-backend.herokuapp.com/auth/forgot';

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
      print('Code sent successful!!!');
      return jsonDecode(response.body);
    } else {
      log('Code sent failed');
      // log(response.statusCode.toString());
      return jsonDecode(response.body);
    }
  }
}
