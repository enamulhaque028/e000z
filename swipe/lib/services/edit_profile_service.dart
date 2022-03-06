import 'dart:convert';
import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:swipe/config/utils/constants.dart';
import 'package:http/http.dart' as http;

class EditProfileService {
  int statusCode = 0;
  Future editProfile({
    required String name,
    required String bio,
    required String type,
    required String gender,
    required String country,
    required String countryCode,
  }) async {
    var box = Hive.box(Constants.storageBox);
    final String? authToken = box.get(Constants.authToken);

    Map data = {
      "name": name,
      "bio": bio,
      "type": type,
      "gender": gender,
      "country": country,
      "countryCode": countryCode,
    };
    var body = json.encode(data);

    String extUrl = 'api/user';
    Uri url = Uri.parse(baseUrl + extUrl);

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'token': authToken!
    };

    final response = await http.patch(url, headers: requestHeaders, body: body);
    log(body);
    log(response.body);
    log(response.statusCode.toString());
    statusCode = response.statusCode;
    if (response.statusCode == 200) {
      print('Update profile successful!!!');
      return jsonDecode(response.body);
    } else {
      print('Update profile failed!!!');
    }
  }
}
