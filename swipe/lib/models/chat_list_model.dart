// To parse this JSON data, do
//
//     final chatListModel = chatListModelFromJson(jsonString);

import 'dart:convert';

ChatListModel chatListModelFromJson(String str) => ChatListModel.fromJson(json.decode(str));

String chatListModelToJson(ChatListModel data) => json.encode(data.toJson());

class ChatListModel {
    ChatListModel({
        required this.chats,
    });

    final List<Chat>? chats;

    factory ChatListModel.fromJson(Map<String, dynamic> json) => ChatListModel(
        chats: json["chats"] == null ? [] : List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "chats": List<dynamic>.from(chats!.map((x) => x.toJson())),
    };
}

class Chat {
    Chat({
        required this.id,
        required this.roomId,
        required this.userId,
        required this.type,
        required this.text,
        required this.seen,
        required this.time,
    });

    final String? id;
    final String? roomId;
    final String? userId;
    final String? type;
    final String? text;
    final List<dynamic>? seen;
    final DateTime? time;

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"] ?? '',
        roomId: json["roomId"] ?? '',
        userId: json["userId"] ?? '',
        type: json["type"] ?? '',
        text: json["text"] ?? '',
        seen: json["seen"] == null ? [] : List<dynamic>.from(json["seen"].map((x) => x)),
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id!,
        "roomId": roomId!,
        "userId": userId!,
        "type": type!,
        "text": text!,
        "seen": List<dynamic>.from(seen!.map((x) => x)),
        "time": time!.toIso8601String(),
    };
}
