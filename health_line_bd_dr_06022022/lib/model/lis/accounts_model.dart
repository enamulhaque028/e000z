// To parse this JSON data, do
//
//     final accounts = accountsFromJson(jsonString);

import 'dart:convert';

Accounts accountsFromJson(String str) => Accounts.fromJson(json.decode(str));

String accountsToJson(Accounts data) => json.encode(data.toJson());

class Accounts {
  Accounts({
    this.pRetrnmsg1,
  });

  final List<PRetrnmsg1> pRetrnmsg1;

  factory Accounts.fromJson(Map<String, dynamic> json) => Accounts(
        pRetrnmsg1: List<PRetrnmsg1>.from(
            json["P_RETRNMSG1"].map((x) => PRetrnmsg1.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "P_RETRNMSG1": List<dynamic>.from(pRetrnmsg1.map((x) => x.toJson())),
      };
}

class PRetrnmsg1 {
  PRetrnmsg1({
    this.patientId,
    this.patIdTxt,
    this.patregDtm,
    this.patientNo,
    this.patientNm,
    this.sorgndrtxt,
    this.caldobTxt,
    this.calcptDob,
    this.caldobFmt,
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
    this.approvedfg,
  });

  final int patientId;
  final String patIdTxt;
  final String patregDtm;
  final String patientNo;
  final String patientNm;
  final String sorgndrtxt;
  final String caldobTxt;
  final String calcptDob;
  final String caldobFmt;
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
  final int approvedfg;

  factory PRetrnmsg1.fromJson(Map<String, dynamic> json) => PRetrnmsg1(
        patientId: json["patient_id"],
        patIdTxt: json["pat_id_txt"],
        patregDtm: json["patreg_dtm"],
        patientNo: json["patient_no"],
        patientNm: json["patient_nm"],
        sorgndrtxt: json["sorgndrtxt"] ?? '',
        caldobTxt: json["caldob_txt"],
        calcptDob: json["calcpt_dob"],
        caldobFmt: json["caldob_fmt"],
        patageTxt: json["patage_txt"],
        relgnName: json["relgn_name"],
        mstusName: json["mstus_name"],
        nationalid: json["nationalid"],
        nationalty: json["nationalty"],
        birthregno: json["birthregno"],
        bldgrpTxt: json["bldgrp_txt"] ?? '',
        pmobileNo: json["pmobile_no"] ?? '',
        prphoneNo: json["prphone_no"],
        ptemailNo: json["ptemail_no"] ?? '',
        occupation: json["occupation"],
        pasportNo: json["pasport_no"],
        ptAddress: json["pt_address"],
        photoLoca: json["photo_loca"] ?? '',
        patStatus: json["pat_status"],
        patRemark: json["pat_remark"],
        ptDtaudtm: json["pt_dtaudtm"],
        approvedfg: json["approvedfg"],
      );

  Map<String, dynamic> toJson() => {
        "patient_id": patientId,
        "pat_id_txt": patIdTxt,
        "patreg_dtm": patregDtm,
        "patient_no": patientNo,
        "patient_nm": patientNm,
        "sorgndrtxt": sorgndrtxt,
        "caldob_txt": caldobTxt,
        "calcpt_dob": calcptDob,
        "caldob_fmt": caldobFmt,
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
        "approvedfg": approvedfg,
      };
}
