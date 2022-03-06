// To parse this JSON data, do
//
//     final designationModel = designationModelFromJson(jsonString);

import 'dart:convert';

DesignationModel designationModelFromJson(String str) =>
    DesignationModel.fromJson(json.decode(str));

String designationModelToJson(DesignationModel data) =>
    json.encode(data.toJson());

class DesignationModel {
  DesignationModel({
    this.message,
    this.statusCode,
    this.listResponse,
  });

  final String message;
  final int statusCode;
  final List<DesignationCategory> listResponse;

  factory DesignationModel.fromJson(Map<String, dynamic> json) =>
      DesignationModel(
        message: json["message"],
        statusCode: json["statusCode"],
        listResponse: List<DesignationCategory>.from(
            json["listResponse"].map((x) => DesignationCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "statusCode": statusCode,
        "listResponse": List<dynamic>.from(listResponse.map((x) => x.toJson())),
      };
}

class DesignationCategory {
  DesignationCategory({
    this.designationId,
    this.designationName,
    this.designationNameBn,
    this.isActive,
    this.accessTo,
  });

  final int designationId;
  final String designationName;
  final String designationNameBn;
  final int isActive;
  final int accessTo;

  factory DesignationCategory.fromJson(Map<String, dynamic> json) =>
      DesignationCategory(
        designationId: json["designationId"],
        designationName: json["designationName"],
        designationNameBn: json["designationNameBN"] == null
            ? null
            : json["designationNameBN"],
        isActive: json["isActive"],
        accessTo: json["accessTo"],
      );

  Map<String, dynamic> toJson() => {
        "designationId": designationId,
        "designationName": designationName,
        "designationNameBN":
            designationNameBn == null ? null : designationNameBn,
        "isActive": isActive,
        "accessTo": accessTo,
      };
}
