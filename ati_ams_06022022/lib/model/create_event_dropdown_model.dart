// To parse this JSON data, do
//
//     final createEventDropdownModel = createEventDropdownModelFromJson(jsonString);

import 'dart:convert';

CreateEventDropdownModel createEventDropdownModelFromJson(String str) =>
    CreateEventDropdownModel.fromJson(json.decode(str));

String createEventDropdownModelToJson(CreateEventDropdownModel data) =>
    json.encode(data.toJson());

class CreateEventDropdownModel {
  CreateEventDropdownModel({
    this.success,
    this.message,
    this.data,
  });

  final bool success;
  final String message;
  final Data data;

  factory CreateEventDropdownModel.fromJson(Map<String, dynamic> json) =>
      CreateEventDropdownModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.topic,
    this.activityInfo,
    this.teacherList,
  });

  final List<Topic> topic;
  final List<ActivityInfo> activityInfo;
  final List<TeacherList> teacherList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        topic: List<Topic>.from(json["topic"].map((x) => Topic.fromJson(x))),
        activityInfo: List<ActivityInfo>.from(
            json["activity_info"].map((x) => ActivityInfo.fromJson(x))),
        teacherList: List<TeacherList>.from(
            json["teacher_list"].map((x) => TeacherList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "topic": List<dynamic>.from(topic.map((x) => x.toJson())),
        "activity_info":
            List<dynamic>.from(activityInfo.map((x) => x.toJson())),
        "teacher_list": List<dynamic>.from(teacherList.map((x) => x.toJson())),
      };
}

class ActivityInfo {
  ActivityInfo({
    this.activityId,
    this.activityName,
  });

  final int activityId;
  final String activityName;

  factory ActivityInfo.fromJson(Map<String, dynamic> json) => ActivityInfo(
        activityId: json["activity_id"] ?? null,
        activityName: json["activity_name"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "activity_id": activityId,
        "activity_name": activityName,
      };
}

class TeacherList {
  TeacherList({
    this.id,
    this.name,
  });

  final int id;
  final String name;

  factory TeacherList.fromJson(Map<String, dynamic> json) => TeacherList(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Topic {
  Topic({
    this.id,
    this.topic,
  });

  final int id;
  final String topic;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json["id"],
        topic: json["topic"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "topic": topic,
      };
}
