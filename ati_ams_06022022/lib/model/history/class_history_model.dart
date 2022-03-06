// To parse this JSON data, do
//
//     final classHistoryModel = classHistoryModelFromJson(jsonString);

import 'dart:convert';

ClassHistoryModel classHistoryModelFromJson(String str) =>
    ClassHistoryModel.fromJson(json.decode(str));

String classHistoryModelToJson(ClassHistoryModel data) =>
    json.encode(data.toJson());

class ClassHistoryModel {
  ClassHistoryModel({
    this.success,
    this.message,
    this.data,
  });

  final bool success;
  final String message;
  final List<Datum> data;

  factory ClassHistoryModel.fromJson(Map<String, dynamic> json) =>
      ClassHistoryModel(
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
    this.datumCourseType,
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
    this.batchNo,
    this.deptName,
    this.courseType,
    this.courseName,
    this.teacherName,
    this.className,
    this.topicName,
    this.blockName,
    this.roomNo,
    this.attendanceStatus,
  });

  final int id;
  final int blockId;
  final int classType;
  final int teacherId;
  final int departmentId;
  final int topicId;
  final int batchId;
  final int datumCourseType;
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
  final String batchNo;
  final String deptName;
  final String courseType;
  final String courseName;
  final String teacherName;
  final String className;
  final String topicName;
  final String blockName;
  final String roomNo;
  final int attendanceStatus;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? null,
        blockId: json["block_id"] ?? null,
        classType: json["class_type"] ?? null,
        teacherId: json["teacher_id"] ?? null,
        departmentId: json["department_id"] ?? null,
        topicId: json["topic_id"] ?? null,
        batchId: json["batch_id"] ?? null,
        datumCourseType: json["course_type"] ?? null,
        courseNameId: json["course_name_id"] ?? null,
        dayName: json["day_name"] ?? null,
        classRoom: json["class_room"] ?? null,
        classStartDate: json["class_start_date"] == null
            ? json["class_start_date"]
            : DateTime.parse(json["class_start_date"]),
        classEndDate: json["class_end_date"] == null
            ? json["class_end_date"]
            : DateTime.parse(json["class_end_date"]),
        classStartTime: json["class_start_time"] == null
            ? json["class_start_time"]
            : DateTime.parse(json["class_start_time"]),
        classEndTime: json["class_end_time"] == null
            ? json["class_end_time"]
            : DateTime.parse(json["class_end_time"]),
        activeStatus: json["active_status"] ?? null,
        createdBy: json["created_by"] ?? null,
        createdAt: json["created_at"] == null
            ? json["created_at"]
            : DateTime.parse(json["created_at"]),
        updatedBy: json["updated_by"] ?? null,
        updatedAt: json["updated_at"] ?? null,
        orgId: json["org_id"] ?? null,
        batchNo: json["BATCH_NO"] ?? null,
        deptName: json["DEPT_NAME"] ?? null,
        courseType: json["COURSE_TYPE"] ?? null,
        courseName: json["COURSE_NAME"] ?? null,
        teacherName: json["TEACHER_NAME"] ?? null,
        className: json["CLASS_NAME"] ?? null,
        topicName: json["TOPIC_NAME"] ?? null,
        blockName: json["BLOCK_NAME"] ?? null,
        roomNo: json["room_no"] ?? null,
        attendanceStatus: json["attendance_status"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "block_id": blockId,
        "class_type": classType,
        "teacher_id": teacherId,
        "department_id": departmentId,
        "topic_id": topicId,
        "batch_id": batchId,
        "course_type": datumCourseType,
        "course_name_id": courseNameId,
        "day_name": dayName,
        "class_room": classRoom,
        "class_start_date": classStartDate.toIso8601String(),
        "class_end_date": classEndDate.toIso8601String(),
        "class_start_time": classStartTime.toIso8601String(),
        "class_end_time": classEndTime.toIso8601String(),
        "active_status": activeStatus,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
        "updated_by": updatedBy,
        "updated_at": updatedAt,
        "org_id": orgId,
        "BATCH_NO": batchNo,
        "DEPT_NAME": deptName,
        "COURSE_TYPE": courseType,
        "COURSE_NAME": courseName,
        "TEACHER_NAME": teacherName,
        "CLASS_NAME": className,
        "TOPIC_NAME": topicName,
        "BLOCK_NAME": blockName,
        "room_no": roomNo,
        "attendance_status": attendanceStatus,
      };
}
