// To parse this JSON data, do
//
//     final geoDataModel = geoDataModelFromJson(jsonString);

import 'dart:convert';

GeoDataModel geoDataModelFromJson(String str) =>
    GeoDataModel.fromJson(json.decode(str));

String geoDataModelToJson(GeoDataModel data) => json.encode(data.toJson());

class GeoDataModel {
  GeoDataModel({
    this.success,
    this.message,
    this.data,
  });

  final bool success;
  final String message;
  final List<Datum> data;

  factory GeoDataModel.fromJson(Map<String, dynamic> json) => GeoDataModel(
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
    this.geoId,
    this.geoGroupId,
    this.lat,
    this.lng,
    this.isActive,
  });

  final int geoId;
  final GeoGroupId geoGroupId;
  final double lat;
  final double lng;
  final int isActive;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        geoId: json["GeoId"],
        geoGroupId: geoGroupIdValues.map[json["Geo_GROUP_ID"]],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "GeoId": geoId,
        "Geo_GROUP_ID": geoGroupIdValues.reverse[geoGroupId],
        "lat": lat,
        "lng": lng,
        "isActive": isActive,
      };
}

enum GeoGroupId { BIRDEM_01 }

final geoGroupIdValues = EnumValues({"BIRDEM_01": GeoGroupId.BIRDEM_01});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
