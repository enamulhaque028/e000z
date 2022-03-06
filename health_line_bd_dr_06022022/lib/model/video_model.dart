// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

import 'dart:typed_data';

VideoModel videoModelFromJson(Uint8List str) =>
    VideoModel.fromJson(json.decode(utf8.decode(str)));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  VideoModel({
    this.message,
    this.listResponse,
  });

  final String message;
  final List<ListResponse> listResponse;

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        message: json["message"],
        listResponse: List<ListResponse>.from(
            json["listResponse"].map((x) => ListResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "listResponse": List<dynamic>.from(listResponse.map((x) => x.toJson())),
      };
}

class ListResponse {
  ListResponse({
    this.videoId,
    this.videoTitle,
    this.videoDes,
    this.videoDuration,
    this.videoUrl,
    this.topicUId,
  });

  final int videoId;
  final String videoTitle;
  final String videoDes;
  final String videoDuration;
  final String videoUrl;
  final TopicUId topicUId;

  factory ListResponse.fromJson(Map<String, dynamic> json) => ListResponse(
        videoId: json["videoId"],
        videoTitle: json["videoTitle"],
        videoDes: json["videoDes"],
        videoDuration: json["videoDuration"],
        videoUrl: json["videoUrl"],
        topicUId: topicUIdValues.map[json["topicUId"]],
      );

  Map<String, dynamic> toJson() => {
        "videoId": videoId,
        "videoTitle": videoTitle,
        "videoDes": videoDes,
        "videoDuration": videoDuration,
        "videoUrl": videoUrl,
        "topicUId": topicUIdValues.reverse[topicUId],
      };
}

enum TopicUId { TIP }

final topicUIdValues = EnumValues({"TIP": TopicUId.TIP});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
