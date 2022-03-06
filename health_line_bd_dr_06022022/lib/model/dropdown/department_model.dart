// To parse this JSON data, do
//
//     final departmentModel = departmentModelFromJson(jsonString);

import 'dart:convert';

DepartmentModel departmentModelFromJson(String str) =>
    DepartmentModel.fromJson(json.decode(str));

String departmentModelToJson(DepartmentModel data) =>
    json.encode(data.toJson());

class DepartmentModel {
  DepartmentModel({
    this.message,
    this.statusCode,
    this.listResponse,
  });

  final String message;
  final int statusCode;
  final List<DepartmentCategory> listResponse;

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      DepartmentModel(
        message: json["message"],
        statusCode: json["statusCode"],
        listResponse: List<DepartmentCategory>.from(
            json["listResponse"].map((x) => DepartmentCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "statusCode": statusCode,
        "listResponse": List<dynamic>.from(listResponse.map((x) => x.toJson())),
      };
}

class DepartmentCategory {
  DepartmentCategory({
    this.departmentId,
    this.departmentName,
    this.departmentNameBn,
    this.isActive,
    this.accessTo,
  });

  final int departmentId;
  final String departmentName;
  final String departmentNameBn;
  final int isActive;
  final int accessTo;

  factory DepartmentCategory.fromJson(Map<String, dynamic> json) =>
      DepartmentCategory(
        departmentId: json["departmentId"],
        departmentName: json["departmentName"],
        departmentNameBn:
            json["departmentNameBN"] == null ? null : json["departmentNameBN"],
        isActive: json["isActive"],
        accessTo: json["accessTo"],
      );

  Map<String, dynamic> toJson() => {
        "departmentId": departmentId,
        "departmentName": departmentName,
        "departmentNameBN": departmentNameBn == null ? null : departmentNameBn,
        "isActive": isActive,
        "accessTo": accessTo,
      };
}
