import 'dart:convert';
import 'dart:developer';
import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/model/video_model.dart';
import 'package:http/http.dart' as http;

class VideoService {
  Future<VideoModel> fetchVideoInfo() async {
    String extUrl =
        'video/get-permitted-videos?roleUid=P&topicUid=TIP&userId=52';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = "https://bdhealthline.net/health-line-bd-ws/api/video/get-permitted-videos?roleUid=P&topicUid=TIP&userId=52";

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    // log(response.body);
    // log(body);
    if (response.statusCode == 200) {
      // log(response.body);
      log('Youtube video data retrived successful!!!');
      return videoModelFromJson(response.bodyBytes);
    } else {
      log('Youtube video data retrived failed!!!');
      // log(response.statusCode.toString());
      return jsonDecode(response.body);
    }
  }
}
