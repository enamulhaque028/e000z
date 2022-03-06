// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

EventModel eventModelFromJson(String str) =>
    EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  EventModel({
    this.success,
    this.message,
    this.data,
  });

  final bool success;
  final String message;
  final Data data;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
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
    this.eventInfo,
    this.teacherList,
  });

  final List<EventInfo> eventInfo;
  final List<TeacherList> teacherList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        eventInfo: List<EventInfo>.from(
            json["event_info"].map((x) => EventInfo.fromJson(x))),
        teacherList: List<TeacherList>.from(
            json["teacher_list"].map((x) => TeacherList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "event_info": List<dynamic>.from(eventInfo.map((x) => x.toJson())),
        "teacher_list": List<dynamic>.from(teacherList.map((x) => x.toJson())),
      };
}

class EventInfo {
  EventInfo({
    this.id,
    this.eventType,
    this.topic,
    this.title,
    this.department,
    this.eventInfoCourseName,
    this.eventInfoCourseType,
    this.batch,
    this.start,
    this.end,
    this.color,
    this.activeStatus,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.orgId,
    this.batchNo,
    this.deptName,
    this.courseType,
    this.courseName,
    this.topicName,
    this.activityName,
    this.activityAuthorize,
  });

  final int id;
  final int eventType;
  final int topic;
  final String title;
  final int department;
  final int eventInfoCourseName;
  final int eventInfoCourseType;
  final int batch;
  final DateTime start;
  final DateTime end;
  final String color;
  final int activeStatus;
  final dynamic createdBy;
  final DateTime createdAt;
  final dynamic updatedBy;
  final DateTime updatedAt;
  final int orgId;
  final String batchNo;
  final String deptName;
  final String courseType;
  final String courseName;
  final String topicName;
  final String activityName;
  final String activityAuthorize;

  factory EventInfo.fromJson(Map<String, dynamic> json) => EventInfo(
        id: json["id"] ?? null,
        eventType: json["event_type"] ?? null,
        topic: json["topic"] ?? null,
        title: json["title"] ?? null,
        department: json["department"] ?? null,
        eventInfoCourseName: json["course_name"] ?? null,
        eventInfoCourseType: json["course_type"] ?? null,
        batch: json["batch"] ?? null,
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
        color: json["color"] ?? null,
        activeStatus: json["active_status"] ?? null,
        createdBy: json["created_by"] ?? null,
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedBy: json["updated_by"] ?? null,
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        orgId: json["org_id"] ?? null,
        batchNo: json["BATCH_NO"] ?? null,
        deptName: json["DEPT_NAME"] ?? null,
        courseType: json["COURSE_TYPE"] ?? null,
        courseName: json["COURSE_NAME"] ?? null,
        topicName: json["TOPIC_NAME"] ?? null,
        activityName: json["activity_name"] ?? null,
        activityAuthorize: json["activity_authorize"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_type": eventType,
        "topic": topic,
        "title": title,
        "department": department,
        "course_name": eventInfoCourseName,
        "course_type": eventInfoCourseType,
        "batch": batch,
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
        "color": color,
        "active_status": activeStatus,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
        "updated_by": updatedBy,
        "updated_at": updatedAt.toIso8601String(),
        "org_id": orgId,
        "BATCH_NO": batchNo,
        "DEPT_NAME": deptName,
        "COURSE_TYPE": courseType,
        "COURSE_NAME": courseName,
        "TOPIC_NAME": topicName,
        "activity_name": activityName,
        "activity_authorize": activityAuthorize,
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
