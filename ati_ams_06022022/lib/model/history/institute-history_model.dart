// To parse this JSON data, do
//
//     final instituteHistoryModel = instituteHistoryModelFromJson(jsonString);

import 'dart:convert';

InstituteHistoryModel instituteHistoryModelFromJson(String str) =>
    InstituteHistoryModel.fromJson(json.decode(str));

String instituteHistoryModelToJson(InstituteHistoryModel data) =>
    json.encode(data.toJson());

class InstituteHistoryModel {
  InstituteHistoryModel({
    this.success,
    this.message,
    this.data,
  });

  final bool success;
  final String message;
  final List<Datum> data;

  factory InstituteHistoryModel.fromJson(Map<String, dynamic> json) =>
      InstituteHistoryModel(
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
    this.inistitute,
    this.attendanceStatus,
    this.date,
    this.submissionTime,
    this.submissionEndTime,
    this.deptName,
    this.courseName,
    this.session,
  });

  final int inistitute;
  final int attendanceStatus;
  final DateTime date;
  final String submissionTime;
  final String submissionEndTime;
  final String deptName;
  final String courseName;
  final String session;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        inistitute: json["inistitute"] ?? null,
        attendanceStatus: json["attendance_status"] ?? null,
        date:
            json["date"] == null ? json["date"] : DateTime.parse(json["date"]),
        submissionTime: json["submission_time"] ?? null,
        submissionEndTime: json["submission_end_time"] ?? null,
        deptName: json["DEPT_NAME,"] ?? null,
        courseName: json["COURSE_NAME"] ?? null,
        session: json["SESSION"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "inistitute": inistitute,
        "attendance_status": attendanceStatus,
        "date": date.toIso8601String(),
        "submission_time": submissionTime,
        "submission_end_time": submissionEndTime,
        "DEPT_NAME,": deptName,
        "COURSE_NAME": courseName,
        "SESSION": session,
      };
}
