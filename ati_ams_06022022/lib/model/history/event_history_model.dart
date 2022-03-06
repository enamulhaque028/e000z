// To parse this JSON data, do
//
//     final eventHistoryModel = eventHistoryModelFromJson(jsonString);

import 'dart:convert';

EventHistoryModel eventHistoryModelFromJson(String str) =>
    EventHistoryModel.fromJson(json.decode(str));

String eventHistoryModelToJson(EventHistoryModel data) =>
    json.encode(data.toJson());

class EventHistoryModel {
  EventHistoryModel({
    this.success,
    this.message,
    this.data,
  });

  final bool success;
  final String message;
  final List<Datum> data;

  factory EventHistoryModel.fromJson(Map<String, dynamic> json) =>
      EventHistoryModel(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.eventType,
    this.topic,
    this.title,
    this.department,
    this.datumCourseName,
    this.datumCourseType,
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
    this.attendanceStatus,
    this.activityAuthorize,
  });

  final int id;
  final int eventType;
  final int topic;
  final String title;
  final int department;
  final int datumCourseName;
  final int datumCourseType;
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
  final int attendanceStatus;
  final String activityAuthorize;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? null,
        eventType: json["event_type"] ?? null,
        topic: json["topic"] ?? null,
        title: json["title"] ?? null,
        department: json["department"] ?? null,
        datumCourseName: json["course_name"] ?? null,
        datumCourseType: json["course_type"] ?? null,
        batch: json["batch"] ?? null,
        start: json["start"] == null
            ? json["start"]
            : DateTime.parse(json["start"]),
        end: json["end"] == null ? json["end"] : DateTime.parse(json["end"]),
        color: json["color"] ?? null,
        activeStatus: json["active_status"] ?? null,
        createdBy: json["created_by"] ?? null,
        createdAt: json["created_at"] == null
            ? json["created_at"]
            : DateTime.parse(json["created_at"]),
        updatedBy: json["updated_by"] ?? null,
        updatedAt: json["updated_at"] == null
            ? json["updated_at"]
            : DateTime.parse(json["updated_at"]),
        orgId: json["org_id"] ?? null,
        batchNo: json["BATCH_NO"] ?? null,
        deptName: json["DEPT_NAME"] ?? null,
        courseType: json["COURSE_TYPE"] ?? null,
        courseName: json["COURSE_NAME"] ?? null,
        topicName: json["TOPIC_NAME"] ?? null,
        activityName: json["activity_name"] ?? null,
        attendanceStatus: json["attendance_status"] ?? null,
        activityAuthorize: json["activity_authorize"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_type": eventType,
        "topic": topic,
        "title": title,
        "department": department,
        "course_name": datumCourseName,
        "course_type": datumCourseType,
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
        "attendance_status": attendanceStatus,
        "activity_authorize": activityAuthorize,
      };
}
