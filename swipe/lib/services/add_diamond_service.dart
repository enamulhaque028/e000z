import 'dart:convert';
import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:swipe/config/utils/constants.dart';
import 'package:http/http.dart' as http;

class AddDiamondService {
  int statusCode = 0;
  Future addDiamond({
    required int diamondNo,
    required String diamondType, // diamondType = [chat, audio, video]
  }) async {
    var box = Hive.box(Constants.storageBox);
    final String? authToken = box.get(Constants.authToken);

    Map data = diamondType == 'chat'
        ? {"chattingRate": diamondNo}
        : diamondType == 'audio'
            ? {"voiceRate": diamondNo}
            : {"videoRate": diamondNo};
    var body = json.encode(data);

    String extUrl = 'api/user/celebrity/package';
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
