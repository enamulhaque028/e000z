// To parse this JSON data, do
//
//     final attendanceModel = attendanceModelFromJson(jsonString);

import 'dart:convert';

AttendanceModel attendanceModelFromJson(String str) =>
    AttendanceModel.fromJson(json.decode(str));

String attendanceModelToJson(AttendanceModel data) =>
    json.encode(data.toJson());

class AttendanceModel {
  AttendanceModel({
    this.success,
    this.message,
    this.data,
  });

  final bool success;
  final String message;
  final List<Datum> data;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
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
    this.blockId,
    this.classType,
    this.teacherId,
    this.departmentId,
    this.topicId,
    this.batchId,
    this.courseType,
    this.courseNameId,
    this.dayName,
    this.classRoom,
    this.classStartDate,
    this.classEndDate,
    this.classStartTime,
    this.classEndTime,
    this.activeStatus,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.orgId,
    this.lookupDataName,
    this.deptName,
    this.teacherName,
    this.topicName,
    this.courseName,
  });

  final int id;
  final int blockId;
  final int classType;
  final int teacherId;
  final int departmentId;
  final int topicId;
  final int batchId;
  final int courseType;
  final int courseNameId;
  final String dayName;
  final int classRoom;
  final DateTime classStartDate;
  final DateTime classEndDate;
  final DateTime classStartTime;
  final DateTime classEndTime;
  final int activeStatus;
  final int createdBy;
  final DateTime createdAt;
  final dynamic updatedBy;
  final dynamic updatedAt;
  final int orgId;
  final String lookupDataName;
  final String deptName;
  final String teacherName;
  final String topicName;
  final String courseName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? null,
        blockId: json["block_id"] ?? null,
        classType: json["class_type"] ?? null,
        teacherId: json["teacher_id"] ?? null,
        departmentId: json["department_id"] ?? null,
        topicId: json["topic_id"] == null ? null : json["topic_id"],
        batchId: json["batch_id"] ?? null,
        courseType: json["course_type"] ?? null,
        courseNameId: json["course_name_id"] ?? null,
        dayName: json["day_name"] ?? null,
        classRoom: json["class_room"] ?? null,
        classStartDate: json["class_start_date"] == null ? null :DateTime.parse(json["class_start_date"]),
        classEndDate: json["class_end_date"] == null ? null : DateTime.parse(json["class_end_date"]),
        classStartTime: json["class_start_time"] == null ? null : DateTime.parse(json["class_start_time"]),
        classEndTime: json["class_end_time"] == null ? null : DateTime.parse(json["class_end_time"]),
        activeStatus: json["active_status"] ?? null,
        createdBy: json["created_by"] == null ? null : json["created_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedBy: json["updated_by"] ?? null,
        updatedAt: json["updated_at"] ?? null,
        orgId: json["org_id"] ?? null,
        lookupDataName: json["LOOKUP_DATA_NAME"] ?? null,
        deptName: json["DEPT_NAME"] ?? null,
        teacherName: json["TEACHER_NAME"] ?? null,
        topicName: json["TOPIC_NAME"] ?? null,
        courseName: json["COURSE_NAME"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "block_id": blockId,
        "class_type": classType,
        "teacher_id": teacherId,
        "department_id": departmentId,
        "topic_id": topicId == null ? null : topicId,
        "batch_id": batchId,
        "course_type": courseType,
        "course_name_id": courseNameId,
        "day_name": dayName,
        "class_room": classRoom,
        "class_start_date": classStartDate.toIso8601String(),
        "class_end_date":
            classEndDate == null ? null : classEndDate.toIso8601String(),
        "class_start_time": classStartTime,
        "class_end_time": classEndTime,
        "active_status": activeStatus,
        "created_by": createdBy == null ? null : createdBy,
        "created_at": createdAt.toIso8601String(),
        "updated_by": updatedBy,
        "updated_at": updatedAt,
        "org_id": orgId,
        "LOOKUP_DATA_NAME": lookupDataName,
        "DEPT_NAME": deptName,
        "TEACHER_NAME": teacherName,
        "TOPIC_NAME": topicName,
        "COURSE_NAME": courseName,
      };
}
