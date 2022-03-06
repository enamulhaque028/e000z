// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.pReturnmsg,
  });

  final List<PReturnmsg> pReturnmsg;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        pReturnmsg: List<PReturnmsg>.from(
            json["P_RETURNMSG"].map((x) => PReturnmsg.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "P_RETURNMSG": List<dynamic>.from(pReturnmsg.map((x) => x.toJson())),
      };
}

class PReturnmsg {
  PReturnmsg({
    this.patientId,
    this.patregDtm,
    this.patientNo,
    this.patientNm,
    this.sorgndrtxt,
    this.caldobTxt,
    this.calcptDob,
    this.patageTxt,
    this.relgnName,
    this.mstusName,
    this.nationalid,
    this.nationalty,
    this.birthregno,
    this.bldgrpTxt,
    this.pmobileNo,
    this.prphoneNo,
    this.ptemailNo,
    this.occupation,
    this.pasportNo,
    this.ptAddress,
    this.photoLoca,
    this.patStatus,
    this.patRemark,
    this.ptDtaudtm,
  });

  final int patientId;
  final String patregDtm;
  final String patientNo;
  final String patientNm;
  final String sorgndrtxt;
  final String caldobTxt;
  final String calcptDob;
  final dynamic patageTxt;
  final dynamic relgnName;
  final dynamic mstusName;
  final String nationalid;
  final dynamic nationalty;
  final dynamic birthregno;
  final String bldgrpTxt;
  final String pmobileNo;
  final dynamic prphoneNo;
  final String ptemailNo;
  final dynamic occupation;
  final String pasportNo;
  final String ptAddress;
  final String photoLoca;
  final String patStatus;
  final dynamic patRemark;
  final String ptDtaudtm;

  factory PReturnmsg.fromJson(Map<String, dynamic> json) => PReturnmsg(
        patientId: json["patient_id"] ?? '',
        patregDtm: json["patreg_dtm"] ?? '',
        patientNo: json["patient_no"] ?? '',
        patientNm: json["patient_nm"] ?? '',
        sorgndrtxt: json["sorgndrtxt"] ?? '',
        caldobTxt: json["caldob_txt"] ?? '',
        calcptDob: json["calcpt_dob"] ?? '',
        patageTxt: json["patage_txt"] ?? '',
        relgnName: json["relgn_name"] ?? '',
        mstusName: json["mstus_name"] ?? '',
        nationalid: json["nationalid"] ?? '',
        nationalty: json["nationalty"] ?? '',
        birthregno: json["birthregno"] ?? '',
        bldgrpTxt: json["bldgrp_txt"] ?? '',
        pmobileNo: json["pmobile_no"] ?? '',
        prphoneNo: json["prphone_no"] ?? '',
        ptemailNo: json["ptemail_no"] ?? '',
        occupation: json["occupation"] ?? '',
        pasportNo: json["pasport_no"] ?? '',
        ptAddress: json["pt_address"] ?? '',
        photoLoca: json["photo_loca"] ?? '',
        patStatus: json["pat_status"] ?? '',
        patRemark: json["pat_remark"] ?? '',
        ptDtaudtm: json["pt_dtaudtm"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "patient_id": patientId,
        "patreg_dtm": patregDtm,
        "patient_no": patientNo,
        "patient_nm": patientNm,
        "sorgndrtxt": sorgndrtxt,
        "caldob_txt": caldobTxt,
        "calcpt_dob": calcptDob,
        "patage_txt": patageTxt,
        "relgn_name": relgnName,
        "mstus_name": mstusName,
        "nationalid": nationalid,
        "nationalty": nationalty,
        "birthregno": birthregno,
        "bldgrp_txt": bldgrpTxt,
        "pmobile_no": pmobileNo,
        "prphone_no": prphoneNo,
        "ptemail_no": ptemailNo,
        "occupation": occupation,
        "pasport_no": pasportNo,
        "pt_address": ptAddress,
        "photo_loca": photoLoca,
        "pat_status": patStatus,
        "pat_remark": patRemark,
        "pt_dtaudtm": ptDtaudtm,
      };
}
