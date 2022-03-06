// To parse this JSON data, do
//
//     final activityModel = activityModelFromJson(jsonString);

import 'dart:convert';

ActivityModel activityModelFromJson(String str) =>
    ActivityModel.fromJson(json.decode(str));

String activityModelToJson(ActivityModel data) => json.encode(data.toJson());

class ActivityModel {
  ActivityModel({
    this.success,
    this.message,
    this.data,
  });

  final bool success;
  final String message;
  final List<Datum> data;

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
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
    this.activityAttendanceId,
    this.activity,
    this.datumTopicName,
    this.studentId,
    this.departmentId,
    this.courseId,
    this.courseTypeId,
    this.courseNameId,
    this.batchId,
    this.activityAuthorize,
    this.feedbackComments,
    this.presentAbsentStatus,
    this.date,
    this.durationStartTime,
    this.durationEndTime,
    this.activeStatus,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.orgId,
    this.lat,
    this.lng,
    this.blockPlaceChdId,
    this.placeDepartment,
    this.placeCourse,
    this.datumCourseType,
    this.batchNo,
    this.deptName,
    this.courseType,
    this.courseName,
    this.topicName,
    this.activityName,
    this.attendanceStatus,
  });

  final int activityAttendanceId;
  final int activity;
  final int datumTopicName;
  final int studentId;
  final int departmentId;
  final int courseId;
  final int courseTypeId;
  final int courseNameId;
  final int batchId;
  final String activityAuthorize;
  final String feedbackComments;
  final int presentAbsentStatus;
  final DateTime date;
  final String durationStartTime;
  final String durationEndTime;
  final int activeStatus;
  final int createdBy;
  final DateTime createdAt;
  final int updatedBy;
  final DateTime updatedAt;
  final int orgId;
  final double lat;
  final double lng;
  final int blockPlaceChdId;
  final int placeDepartment;
  final int placeCourse;
  final int datumCourseType;
  final String batchNo;
  final String deptName;
  final String courseType;
  final String courseName;
  final String topicName;
  final String activityName;
  final int attendanceStatus;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        activityAttendanceId: json["activity_attendance_id"] ?? null,
        activity: json["activity"] ?? null,
        datumTopicName: json["topic_name"] ?? null,
        studentId: json["student_id"] ?? null,
        departmentId: json["department_id"] ?? null,
        courseId: json["course_id"] ?? null,
        courseTypeId: json["course_type_id"] ?? null,
        courseNameId:
            json["course_name_id"] == null ? null : json["course_name_id"],
        batchId: json["batch_id"] ?? null,
        activityAuthorize: json["activity_authorize"] ?? '',
        feedbackComments: json["feedback_comments"] == null
            ? null
            : json["feedback_comments"],
        presentAbsentStatus: json["present_absent_status"] ?? null,
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        durationStartTime: json["duration_start_time"] ?? null,
        durationEndTime: json["duration_end_time"] ?? null,
        activeStatus: json["active_status"] ?? null,
        createdBy: json["created_by"] ?? null,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedBy: json["updated_by"] == null ? null : json["updated_by"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        orgId: json["org_id"] ?? null,
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
        blockPlaceChdId: json["block_place_chd_id"] == null
            ? null
            : json["block_place_chd_id"],
        placeDepartment:
            json["place_department"] == null ? null : json["place_department"],
        placeCourse: json["place_course"] == null ? null : json["place_course"],
        datumCourseType:
            json["course_type"] == null ? null : json["course_type"],
        batchNo: json["BATCH_NO"] ?? null,
        deptName: json["DEPT_NAME"] ?? null,
        courseType: json["COURSE_TYPE"] ?? null,
        courseName: json["COURSE_NAME"] ?? null,
        topicName: json["TOPIC_NAME"] ?? null,
        activityName: json["activity_name"] ?? null,
        attendanceStatus: json["attendance_status"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "activity_attendance_id": activityAttendanceId,
        "activity": activity,
        "topic_name": datumTopicName,
        "student_id": studentId,
        "department_id": departmentId,
        "course_id": courseId,
        "course_type_id": courseTypeId,
        "course_name_id": courseNameId == null ? null : courseNameId,
        "batch_id": batchId,
        "activity_authorize":
            activityAuthorize == null ? null : activityAuthorize,
        "feedback_comments": feedbackComments == null ? null : feedbackComments,
        "present_absent_status": presentAbsentStatus,
        "date": date.toIso8601String(),
        "duration_start_time": durationStartTime,
        "duration_end_time": durationEndTime,
        "active_status": activeStatus,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
        "updated_by": updatedBy == null ? null : updatedBy,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "org_id": orgId,
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
        "block_place_chd_id": blockPlaceChdId == null ? null : blockPlaceChdId,
        "place_department": placeDepartment == null ? null : placeDepartment,
        "place_course": placeCourse == null ? null : placeCourse,
        "course_type": datumCourseType == null ? null : datumCourseType,
        "BATCH_NO": batchNo,
        "DEPT_NAME": deptName,
        "COURSE_TYPE": courseType,
        "COURSE_NAME": courseName,
        "TOPIC_NAME": topicName,
        "activity_name": activityName,
        "attendance_status": attendanceStatus,
      };
}
