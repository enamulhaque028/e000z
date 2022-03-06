// To parse this JSON data, do
//
//     final accountModel = accountModelFromJson(jsonString);

import 'dart:convert';

AccountModel accountModelFromJson(String str) =>
    AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
  AccountModel({
    this.success,
    this.result,
  });

  final bool success;
  final List<Result> result;

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        success: json["success"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.cltcpName,
    this.ccpMobile,
    this.cltcpemail,
    this.desigName,
    this.deprtName,
    this.clintName,
  });

  final String cltcpName;
  final String ccpMobile;
  final String cltcpemail;
  final String desigName;
  final String deprtName;
  final String clintName;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        cltcpName: json["CLTCP_NAME"],
        ccpMobile: json["CCP_MOBILE"],
        cltcpemail: json["CLTCPEMAIL"],
        desigName: json["DESIG_NAME"],
        deprtName: json["DEPRT_NAME"],
        clintName: json["CLINT_NAME"],
      );

  Map<String, dynamic> toJson() => {
        "CLTCP_NAME": cltcpName,
        "CCP_MOBILE": ccpMobile,
        "CLTCPEMAIL": cltcpemail,
        "DESIG_NAME": desigName,
        "DEPRT_NAME": deprtName,
        "CLINT_NAME": clintName,
      };
}
