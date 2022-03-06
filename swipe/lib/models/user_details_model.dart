// To parse this JSON data, do
//
//     final userDetailsModel = userDetailsModelFromJson(jsonString);

import 'dart:convert';

UserDetailsModel userDetailsModelFromJson(String str) =>
    UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) =>
    json.encode(data.toJson());

class UserDetailsModel {
  UserDetailsModel({
    required this.user,
    required this.celebrities,
  });

  final User? user;
  final List<User>? celebrities;

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsModel(
        user: User.fromJson(json["user"] ?? {}),
        celebrities: json["celebrities"] == null ? [] : List<User>.from(json["celebrities"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "celebrities": List<dynamic>.from(celebrities!.map((x) => x.toJson())),
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    required this.avatar,
    required this.bio,
    required this.country,
    required this.countryCode,
    required this.gender,
    required this.gallery,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? type;
  final String? avatar;
  final String? bio;
  final String? country;
  final String? countryCode;
  final String? gender;
  final List<String>? gallery;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] ?? null,
        name: json["name"] ?? null,
        email: json["email"] ?? null,
        type: json["type"] ?? null,
        avatar: json["avatar"] ?? 'https://raw.githubusercontent.com/enamulhaque028/data/main/user.png',
        bio: json["bio"] ?? null,
        country: json["country"] ?? null,
        countryCode: json["countryCode"] ?? null,
        gender: json["gender"] ?? null,
        gallery: json["gallery"] == null ? [] : List<String>.from(json["gallery"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id!,
        "name": name!,
        "email": email!,
        "type": type!,
        "avatar": avatar!,
        "bio": bio!,
        "country": country!,
        "countryCode": countryCode!,
        "gender": gender!,
        "gallery": List<dynamic>.from(gallery!.map((x) => x)),
      };
}