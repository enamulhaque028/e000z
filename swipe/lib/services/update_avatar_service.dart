import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:swipe/config/utils/constants.dart';
import 'package:http/http.dart' as http;

class UpdateAvatarService {
  int statusCode = 0;
  Future updateProfile({required String imagePath}) async {
    var box = Hive.box(Constants.storageBox);
    final String? authToken = box.get(Constants.authToken);

    String extUrl = 'api/user/avatar';
    Uri url = Uri.parse(baseUrl + extUrl);

    Map<String, String> headers = {
      'token': authToken!
    };

    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('avatar', imagePath));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    statusCode = response.statusCode;
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      return json.decode(responseBody);
    }
    else {
      print(response.reasonPhrase);
    }
  }
}
