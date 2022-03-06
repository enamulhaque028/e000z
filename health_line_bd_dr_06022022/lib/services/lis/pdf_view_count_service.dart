import 'dart:developer';
import 'package:health_line_bd/config/common_const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future pdfViewCounterService(String reqId, String testNo) async {
  Map data = {
    "P_REPVEW_CNT": 1,
    "P_INV_REQ_ID": reqId,
    "P_PL_INVT_ID": testNo,
  };
  var body = json.encode(data);
  String extUrl = 'report/vwcnt';
  Uri url = Uri.parse(baseUrlLis + extUrl);
  // String url = 'http://192.168.0.54:8088/ords/ordstest/report/vwcnt';

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
    print('Count successfully sent!!!');
    // return jsonDecode(response.body);
  } else {
    log('Count failed!!!');
    // log(response.statusCode.toString());
    // return jsonDecode(response.body);
  }
}
