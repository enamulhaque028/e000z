import 'dart:convert';
import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:swipe/config/utils/constants.dart';
import 'package:http/http.dart' as http;

class SendChatService {
  int statusCode = 0;
  Future sendMesage({
    required String text,
  }) async {
    var box = Hive.box(Constants.storageBox);
    final String? authToken = box.get(Constants.authToken);

    Map data = {
    "type": "text",
    "text": text
  };
    var body = json.encode(data);

    String extUrl = 'api/chatting/chat/61e5aaf4cc89c7fd715aedc4';
    Uri url = Uri.parse(baseUrl + extUrl);

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'token': authToken!
    };

    final response = await http.post(url, headers: requestHeaders, body: body);
    log(body);
    log(response.body);
    log(response.statusCode.toString());
    statusCode = response.statusCode;
    if (response.statusCode == 200) {
      print('Diamond added successful!!!');
      return jsonDecode(response.body);
    } else {
      print('Diamond added failed!!!');
    }
  }
}
