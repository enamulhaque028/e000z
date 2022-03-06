// To parse this JSON data, do
//
//     final doctorChamberModel = doctorChamberModelFromJson(jsonString);

import 'dart:convert';

DoctorChamberModel doctorChamberModelFromJson(String str) =>
    DoctorChamberModel.fromJson(json.decode(str));

String doctorChamberModelToJson(DoctorChamberModel data) =>
    json.encode(data.toJson());

class DoctorChamberModel {
  DoctorChamberModel({
    this.message,
    this.objResponse,
  });

  final String message;
  final ObjResponse objResponse;

  factory DoctorChamberModel.fromJson(Map<String, dynamic> json) =>
      DoctorChamberModel(
        message: json["message"],
        objResponse: ObjResponse.fromJson(json["objResponse"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "objResponse": objResponse.toJson(),
      };
}

class ObjResponse {
  ObjResponse({
    this.chamberNo,
    this.doctorNo,
    this.instittuteNo,
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
    this.duration,
    this.payExpiry,
    this.aptLimit,
    this.needApr,
    this.aptPrfReq,
    this.aptPrfReqTime,
    this.payMethod,
    this.needRefFg,
    this.overReqFg,
    this.refExpiredDay,
    this.enteredBy,
    this.consultMediaNo,
    this.drConsultFeeList,
    this.consultTimeList,
  });

  final int chamberNo;
  final int doctorNo;
  final int instittuteNo;
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
  final int duration;
  final int payExpiry;
  final int aptLimit;
  final int needApr;
  final int aptPrfReq;
  final int aptPrfReqTime;
  final int payMethod;
  final int needRefFg;
  final int overReqFg;
  final int refExpiredDay;
  final int enteredBy;
  final int consultMediaNo;
  final List<DrConsultFeeList> drConsultFeeList;
  final List<ConsultTimeList> consultTimeList;

  factory ObjResponse.fromJson(Map<String, dynamic> json) => ObjResponse(
        chamberNo: json["chamberNo"] ?? null,
        doctorNo: json["doctorNo"] ?? null,
        instittuteNo: json["instittuteNo"] ?? null,
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
        duration: json["duration"] ?? null,
        payExpiry: json["payExpiry"] ?? null,
        aptLimit: json["aptLimit"] ?? null,
        needApr: json["needApr"] ?? null,
        aptPrfReq: json["aptPrfReq"] ?? null,
        aptPrfReqTime: json["aptPrfReqTime"] ?? null,
        payMethod: json["payMethod"] ?? null,
        needRefFg: json["needRefFg"] ?? null,
        overReqFg: json["overReqFg"] ?? null,
        refExpiredDay: json["refExpiredDay"] ?? null,
        enteredBy: json["enteredBy"] ?? null,
        consultMediaNo: json["consultMediaNo"] ?? null,
        drConsultFeeList: json["drConsultFeeList"] == null
            ? null
            : List<DrConsultFeeList>.from(json["drConsultFeeList"]
                .map((x) => DrConsultFeeList.fromJson(x))),
        consultTimeList: json["consultTimeList"] == null
            ? null
            : List<ConsultTimeList>.from(json["consultTimeList"]
                .map((x) => ConsultTimeList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chamberNo": chamberNo ?? null,
        "doctorNo": doctorNo ?? null,
        "instittuteNo": instittuteNo ?? null,
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
        "duration": duration ?? null,
        "payExpiry": payExpiry ?? null,
        "aptLimit": aptLimit ?? null,
        "needApr": needApr ?? null,
        "aptPrfReq": aptPrfReq ?? null,
        "aptPrfReqTime": aptPrfReqTime ?? null,
        "payMethod": payMethod ?? null,
        "needRefFg": needRefFg ?? null,
        "overReqFg": overReqFg ?? null,
        "refExpiredDay": refExpiredDay ?? null,
        "enteredBy": enteredBy ?? null,
        "consultMediaNo": consultMediaNo ?? null,
        "drConsultFeeList": drConsultFeeList == null
            ? null
            : List<dynamic>.from(drConsultFeeList.map((x) => x.toJson())),
        "consultTimeList": consultTimeList ?? null == null
            ? null
            : List<dynamic>.from(consultTimeList.map((x) => x.toJson())),
      };
}

class ConsultTimeList {
  ConsultTimeList({
    this.consultTimeNo,
    this.chamberNo,
    this.consultDayNo,
    this.maxSlot,
    this.visitStart,
    this.visitEnd,
  });

  final int consultTimeNo;
  final int chamberNo;
  final int consultDayNo;
  final int maxSlot;
  final String visitStart;
  final String visitEnd;

  factory ConsultTimeList.fromJson(Map<String, dynamic> json) =>
      ConsultTimeList(
        consultTimeNo: json["consultTimeNo"] ?? null,
        chamberNo: json["chamberNo"] ?? null,
        consultDayNo: json["consultDayNo"] ?? null,
        maxSlot: json["maxSlot"] ?? null,
        visitStart: json["visitStart"] ?? null,
        visitEnd: json["visitEnd"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "consultTimeNo": consultTimeNo ?? null,
        "chamberNo": chamberNo ?? null,
        "consultDayNo": consultDayNo ?? null,
        "maxSlot": maxSlot ?? null,
        "visitStart": visitStart ?? null,
        "visitEnd": visitEnd ?? null,
      };
}

class DrConsultFeeList {
  DrConsultFeeList({
    this.consultTimeNo,
    this.chamberNo,
    this.consultType,
    this.consultFee,
  });

  final int consultTimeNo;
  final int chamberNo;
  final int consultType;
  final double consultFee;

  factory DrConsultFeeList.fromJson(Map<String, dynamic> json) =>
      DrConsultFeeList(
        consultTimeNo: json["consultTimeNo"] ?? null,
        chamberNo: json["chamberNo"] ?? null,
        consultType: json["consultType"] ?? null,
        consultFee: json["consultFee"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "consultTimeNo": consultTimeNo ?? null,
        "chamberNo": chamberNo ?? null,
        "consultType": consultType ?? null,
        "consultFee": consultFee ?? null,
      };
}
