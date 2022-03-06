import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:swipe/config/utils/constants.dart';
import 'package:http/http.dart' as http;

class UserDetailsService {
  Future fetchUserDetails({bool isCelebrity = false}) async {
    var box = Hive.box(Constants.storageBox);
    final String? authToken = box.get(Constants.authToken);
    final String? userId = box.get(Constants.userId);
    String userDetailsUrl = 'api/user/$userId';
    String celebrityListUrl = 'api/celebrity/list/all';

    String extUrl = isCelebrity ? celebrityListUrl : userDetailsUrl;
    Uri url = Uri.parse(baseUrl + extUrl);

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'token': authToken!
    };

    final response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      log(response.body.toString());
      return response.body;
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
