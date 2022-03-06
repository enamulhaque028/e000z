import 'dart:developer';
import 'package:health_line_bd/config/common_const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future checkExistingUserService(String personalNo) async {
  Map data = {
    "P_PRSONL_NO": personalNo,
  };
  var body = json.encode(data);
  String extUrl = 'cmh/chkreg';
  Uri url = Uri.parse(baseUrlLis + extUrl);
  // String url = 'http://192.168.0.54:8088/ords/ordstest/cmh/chkreg';

  final http.Response response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  log(response.body);
  log(body);
  if (response.statusCode == 200 &&
      response.body != null &&
      response.body.isNotEmpty) {
    print('Request Successful!!!');
    return jsonDecode(response.body);
  } else {
    log('Count failed!!!');
    // log(response.statusCode.toString());
    return jsonDecode(response.body);
  }
}
