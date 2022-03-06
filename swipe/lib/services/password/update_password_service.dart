import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:swipe/config/utils/constants.dart';

class UpdatePasswordService {
  int statusCode = 0;

  Future updateCode({required String password, required String token}) async {
    Map data = {"password": password, "token": token};
    var body = json.encode(data);
    String extUrl = 'api/user/password';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = 'https://aos-swipe-backend.herokuapp.com/api/user/password';

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
