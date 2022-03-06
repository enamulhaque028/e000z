import 'dart:convert';

List<GalleryModel> galleryModelFromJson(String str) => List<GalleryModel>.from(json.decode(str).map((x) => GalleryModel.fromJson(x)));

String galleryModelToJson(List<GalleryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GalleryModel {
  GalleryModel({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  final String? id;
  final String? author;
  final int? width;
  final int? height;
  final String? url;
  final String? downloadUrl;

  factory GalleryModel.fromJson(Map<String, dynamic> json) => GalleryModel(
        id: json["id"] ?? null,
        author: json["author"] ?? null,
        width: json["width"] ?? null,
        height: json["height"] ?? null,
        url: json["url"] ?? null,
        downloadUrl: json["download_url"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "id": id!,
        "author": author!,
        "width": width!,
        "height": height!,
        "url": url!,
        "download_url": downloadUrl!,
      };
}
