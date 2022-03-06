import 'dart:convert';
import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:swipe/config/utils/constants.dart';
import 'package:http/http.dart' as http;

class DeleteGalleryImage {
  int statusCode = 0;
  Future deleteImage({required String imageUrl}) async {
    var box = Hive.box(Constants.storageBox);
    final String? authToken = box.get(Constants.authToken);

    Map data = {
      "photos": ["$imageUrl"]
    };
    var body = json.encode(data);

    String extUrl = 'api/gallery';
    Uri url = Uri.parse(baseUrl + extUrl);

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'token': authToken!
    };

    final response = await http.delete(url, headers: requestHeaders, body: body);
    log(body);
    log(response.body);
    log(response.statusCode.toString());
    statusCode = response.statusCode;
    if (response.statusCode == 200) {
      print('Delete Image Successful!!!');
      return jsonDecode(response.body);
    } else {
      print('Delete Image Failed!!!');
    }
  }
}
