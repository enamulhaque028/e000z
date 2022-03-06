// To parse this JSON data, do
//
//     final favouriteListModel = blockAndFavListModelFromJson(jsonString);

import 'dart:convert';

BlockingAndFavListModel blockAndFavListModelFromJson(String str) => BlockingAndFavListModel.fromJson(json.decode(str));

String blockAndFavListModelToJson(BlockingAndFavListModel data) => json.encode(data.toJson());

class BlockingAndFavListModel {
    BlockingAndFavListModel({
        required this.user,
    });

    final User? user;

    factory BlockingAndFavListModel.fromJson(Map<String, dynamic> json) => BlockingAndFavListModel(
        user: User.fromJson(json["user"] ?? {}),
    );

    Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
    };
}

class User {
    User({
      required this.id,
      required this.favourite,
      required this.block,
    });

    final String? id;
    final List<Favourite>? favourite;
    final List<Favourite>? block;

    factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["_id"] ?? '',
      favourite: json["favourite"] == null ? [] : List<Favourite>.from(json["favourite"].map((x) => Favourite.fromJson(x))),
      block: json["block"] == null ? [] : List<Favourite>.from(json["block"].map((x) => Favourite.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id!,
        "favourite": List<dynamic>.from(favourite!.map((x) => x.toJson())),
        "block": List<dynamic>.from(block!.map((x) => x.toJson())),
    };
}

class Favourite {
    Favourite({
      required this.id,
      required this.name,
      required this.email,
      required this.gender,
      required this.country,
      required this.bio,
      required this.avatar,
      required this.gallery,
    });

    final String? id;
    final String? name;
    final String? email;
    final String? gender;
    final String? country;
    final String? bio;
    final String? avatar;
    final List<String>? gallery;

    factory Favourite.fromJson(Map<String, dynamic> json) => Favourite(
      id: json["_id"] ?? '',
      name: json["name"] ?? '',
      email: json["email"] ?? '',
      gender: json["gender"] ?? '',
      country: json["country"] ?? '',
      bio: json["bio"] ?? '',
      avatar: json["avatar"] ?? 'https://raw.githubusercontent.com/enamulhaque028/data/main/user.png',
      gallery: json["gallery"] == null ? [] : List<String>.from(json["gallery"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
      "_id": id!,
      "name": name!,
      "email": email!,
      "gender": gender!,
      "country": country!,
      "bio": bio!,
      "avatar": avatar!,
      "gallery": List<dynamic>.from(gallery!.map((x) => x)),
    };
}
