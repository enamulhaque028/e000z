// To parse this JSON data, do
//
//     final institutionModel = institutionModelFromJson(jsonString);

import 'dart:convert';

InstitutionModel institutionModelFromJson(String str) =>
    InstitutionModel.fromJson(json.decode(str));

String institutionModelToJson(InstitutionModel data) =>
    json.encode(data.toJson());

class InstitutionModel {
  InstitutionModel({
    this.message,
    this.statusCode,
    this.listResponse,
  });

  final String message;
  final int statusCode;
  final List<InstitutionCategory> listResponse;

  factory InstitutionModel.fromJson(Map<String, dynamic> json) =>
      InstitutionModel(
        message: json["message"],
        statusCode: json["statusCode"],
        listResponse: List<InstitutionCategory>.from(
            json["listResponse"].map((x) => InstitutionCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "statusCode": statusCode,
        "listResponse": List<dynamic>.from(listResponse.map((x) => x.toJson())),
      };
}

class InstitutionCategory {
  InstitutionCategory({
    this.instituteId,
    this.instituteName,
    this.instituteTypeNo,
    this.address,
    this.accessTo,
    this.isActive,
    this.instituteNameBn,
  });

  final int instituteId;
  final String instituteName;
  final int instituteTypeNo;
  final String address;
  final int accessTo;
  final int isActive;
  final String instituteNameBn;

  factory InstitutionCategory.fromJson(Map<String, dynamic> json) =>
      InstitutionCategory(
        instituteId: json["instituteId"],
        instituteName: json["instituteName"],
        instituteTypeNo:
            json["instituteTypeNo"] == null ? null : json["instituteTypeNo"],
        address: json["address"] == null ? null : json["address"],
        accessTo: json["accessTo"] == null ? null : json["accessTo"],
        isActive: json["isActive"],
        instituteNameBn:
            json["instituteNameBN"] == null ? null : json["instituteNameBN"],
      );

  Map<String, dynamic> toJson() => {
        "instituteId": instituteId,
        "instituteName": instituteName,
        "instituteTypeNo": instituteTypeNo == null ? null : instituteTypeNo,
        "address": address == null ? null : address,
        "accessTo": accessTo == null ? null : accessTo,
        "isActive": isActive,
        "instituteNameBN": instituteNameBn == null ? null : instituteNameBn,
      };
}
