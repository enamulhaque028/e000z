// To parse this JSON data, do
//
//     final districtModel = districtModelFromJson(jsonString);

import 'dart:convert';

DistrictModel districtModelFromJson(String str) =>
    DistrictModel.fromJson(json.decode(str));

String districtModelToJson(DistrictModel data) => json.encode(data.toJson());

class DistrictModel {
  DistrictModel({
    this.divisions,
    this.pharmacyCategory,
  });

  final List<Division> divisions;
  final List<PharmacyCategory> pharmacyCategory;

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
        divisions: List<Division>.from(
            json["divisions"].map((x) => Division.fromJson(x))),
        pharmacyCategory: List<PharmacyCategory>.from(
            json["pharmacyCategory"].map((x) => PharmacyCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "divisions": List<dynamic>.from(divisions.map((x) => x.toJson())),
        "pharmacyCategory":
            List<dynamic>.from(pharmacyCategory.map((x) => x.toJson())),
      };
}

class Division {
  Division({
    this.id,
    this.name,
    this.bnName,
    this.lat,
    this.long,
    this.districts,
  });

  final String id;
  final String name;
  final String bnName;
  final String lat;
  final String long;
  final List<District> districts;

  factory Division.fromJson(Map<String, dynamic> json) => Division(
        id: json["id"],
        name: json["name"],
        bnName: json["bn_name"],
        lat: json["lat"],
        long: json["long"],
        districts: List<District>.from(
            json["districts"].map((x) => District.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "bn_name": bnName,
        "lat": lat,
        "long": long,
        "districts": List<dynamic>.from(districts.map((x) => x.toJson())),
      };
}

class District {
  District({
    this.name,
    this.bnName,
    this.lat,
    this.long,
  });

  final String name;
  final String bnName;
  final String lat;
  final String long;

  factory District.fromJson(Map<String, dynamic> json) => District(
        name: json["name"],
        bnName: json["bn_name"],
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "bn_name": bnName,
        "lat": lat,
        "long": long,
      };
}

class PharmacyCategory {
  PharmacyCategory({
    this.name,
    this.id,
  });

  final String name;
  final int id;

  factory PharmacyCategory.fromJson(Map<String, dynamic> json) =>
      PharmacyCategory(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
