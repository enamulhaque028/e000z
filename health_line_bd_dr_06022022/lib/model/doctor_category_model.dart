// To parse this JSON data, do
//
//     final doctorCategoryModel = doctorCategoryModelFromJson(jsonString);

import 'dart:convert';

DoctorCategoryModel doctorCategoryModelFromJson(String str) =>
    DoctorCategoryModel.fromJson(json.decode(str));

String doctorCategoryModelToJson(DoctorCategoryModel data) =>
    json.encode(data.toJson());

class DoctorCategoryModel {
  DoctorCategoryModel({
    this.message,
    this.listResponse,
  });

  final String message;
  final List<ListResponse> listResponse;

  factory DoctorCategoryModel.fromJson(Map<String, dynamic> json) =>
      DoctorCategoryModel(
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
    this.speciallityNo,
    this.speciality,
    this.doctorList,
  });

  final int speciallityNo;
  final String speciality;
  final List<DoctorList> doctorList;

  factory ListResponse.fromJson(Map<String, dynamic> json) => ListResponse(
        speciallityNo: json["speciallityNo"],
        speciality: json["speciality"],
        doctorList: List<DoctorList>.from(
            json["doctorList"].map((x) => DoctorList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "speciallityNo": speciallityNo,
        "speciality": speciality,
        "doctorList": List<dynamic>.from(doctorList.map((x) => x.toJson())),
      };
}

class DoctorList {
  DoctorList({
    this.doctorNo,
    this.drCode,
    this.doctorName,
    this.bmdcRegNo,
    this.degree,
    this.specialityNo,
    this.departmentNo,
    this.instituteNo,
    this.currentChember,
    this.onLineChamberNo,
    this.degreeOther,
    this.callingId,
    this.callingPw,
    this.callingUid,
    this.specialityName,
    this.departmentName,
    this.instituteName,
    this.uid,
    this.chamber,
    this.imgPath,
  });

  final int doctorNo;
  final String drCode;
  final String doctorName;
  final String bmdcRegNo;
  final String degree;
  final int specialityNo;
  final int departmentNo;
  final int instituteNo;
  final int currentChember;
  final int onLineChamberNo;
  final String degreeOther;
  final String callingId;
  final String callingPw;
  final String callingUid;
  final String specialityName;
  final String departmentName;
  final String instituteName;
  final int uid;
  final Chamber chamber;
  final String imgPath;

  factory DoctorList.fromJson(Map<String, dynamic> json) => DoctorList(
        doctorNo: json["doctorNo"] ?? null,
        drCode: json["drCode"] ?? null,
        doctorName: json["doctorName"] ?? null,
        bmdcRegNo: json["bmdcRegNo"] ?? null,
        degree: json["degree"] ?? null,
        specialityNo: json["specialityNo"] ?? null,
        departmentNo: json["departmentNo"] ?? null,
        instituteNo: json["instituteNo"] ?? null,
        currentChember: json["currentChember"] ?? null,
        onLineChamberNo: json["onLineChamberNo"] ?? null,
        degreeOther: json["degreeOther"] ?? null,
        callingId: json["callingId"] ?? null,
        callingPw: json["callingPw"] ?? null,
        callingUid: json["callingUid"] ?? null,
        specialityName: json["specialityName"] ?? null,
        departmentName: json["departmentName"] ?? null,
        instituteName: json["instituteName"] ?? null,
        uid: json["uid"] ?? null,
        chamber:
            json["chamber"] == null ? null : Chamber.fromJson(json["chamber"]),
        imgPath: json["imgPath"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "doctorNo": doctorNo ?? null,
        "drCode": drCode ?? null,
        "doctorName": doctorName ?? null,
        "bmdcRegNo": bmdcRegNo ?? null,
        "degree": degree ?? null,
        "specialityNo": specialityNo ?? null,
        "departmentNo": departmentNo ?? null,
        "instituteNo": instituteNo ?? null,
        "currentChember": currentChember ?? null,
        "onLineChamberNo": onLineChamberNo ?? null,
        "degreeOther": degreeOther ?? null,
        "callingId": callingId ?? null,
        "callingPw": callingPw ?? null,
        "callingUid": callingUid ?? null,
        "specialityName": specialityName ?? null,
        "departmentName": departmentName ?? null,
        "instituteName": instituteName ?? null,
        "uid": uid ?? null,
        "chamber": chamber == null ? null : chamber.toJson(),
        "imgPath": imgPath ?? null,
      };
}

class Chamber {
  Chamber({
    this.contactNo,
    this.otherInfo,
    this.sat,
    this.sun,
    this.mon,
    this.tue,
    this.wed,
    this.thu,
    this.fri,
    this.startTime,
    this.endTime,
    this.chamberName,
  });

  final String contactNo;
  final String otherInfo;
  final int sat;
  final int sun;
  final int mon;
  final int tue;
  final int wed;
  final int thu;
  final int fri;
  final String startTime;
  final String endTime;
  final String chamberName;

  factory Chamber.fromJson(Map<String, dynamic> json) => Chamber(
        contactNo: json["contactNo"] ?? null,
        otherInfo: json["otherInfo"] ?? null,
        sat: json["sat"] ?? null,
        sun: json["sun"] ?? null,
        mon: json["mon"] ?? null,
        tue: json["tue"] ?? null,
        wed: json["wed"] ?? null,
        thu: json["thu"] ?? null,
        fri: json["fri"] ?? null,
        startTime: json["startTime"] ?? null,
        endTime: json["endTime"] ?? null,
        chamberName: json["chamberName"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "contactNo": contactNo ?? null,
        "otherInfo": otherInfo ?? null,
        "sat": sat ?? null,
        "sun": sun ?? null,
        "mon": mon ?? null,
        "tue": tue ?? null,
        "wed": wed ?? null,
        "thu": thu ?? null,
        "fri": fri ?? null,
        "startTime": startTime ?? null,
        "endTime": endTime ?? null,
        "chamberName": chamberName ?? null,
      };
}
