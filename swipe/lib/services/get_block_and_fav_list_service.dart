import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:swipe/config/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:swipe/models/favourite_list_model.dart';

/* 
 This class is used to 
 1. Fetch FAVOURITE List Data
 2. Fetch BLOCK List Data
 */

class BlockAndFavListService {
  Future<BlockingAndFavListModel> fetchDetails(String extUrl) async {
    var box = Hive.box(Constants.storageBox);
    final String? authToken = box.get(Constants.authToken);

    // String extUrl = 'api/favourite';
    Uri url = Uri.parse(baseUrl + extUrl);

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'token': authToken!
    };

    final response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      log(response.body.toString());
      return blockAndFavListModelFromJson(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
