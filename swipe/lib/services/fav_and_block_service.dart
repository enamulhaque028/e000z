import 'dart:convert';
import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:swipe/config/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:swipe/models/favourite_list_model.dart';

/* 
 This class is used to 
 1. Add user to FAVOURITE list
 2. Add user to BLOCK list
 3. Remove user from FAVOURITE list
 4. Remove user from BLOCK list
 */

class FavAndBlockListService {
  int statusCode = 0;
  Future addRemoveUser({required String userId, required bool isFavourite, required method}) async {
    var box = Hive.box(Constants.storageBox);
    final String? authToken = box.get(Constants.authToken);

    Map data = {
      "users": ["$userId"]
    };
    var body = json.encode(data);

    String extUrl = isFavourite ? 'api/favourite' : 'api/blocking';
    Uri url = Uri.parse(baseUrl + extUrl);

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'token': authToken!
    };

    final response = method == 'post'
        ? await http.post(url, headers: requestHeaders, body: body)
        : await http.delete(url, headers: requestHeaders, body: body);
    log(body);
    log(response.body);
    log(response.statusCode.toString());
    statusCode = response.statusCode;
    if (response.statusCode == 200) {
      print('Request Successful!!!');
      return blockAndFavListModelFromJson(response.body);
    } else {
      print('Request Failed!!!');
    }
  }
}
