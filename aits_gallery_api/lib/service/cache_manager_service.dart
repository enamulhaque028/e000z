import 'dart:developer';
import 'package:aits_gallery/config/utils/api_list.dart';
import 'package:aits_gallery/model/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CacheManager {
  Future<List<GalleryModel>> cacheApiRespone(BuildContext context) async {
    List<GalleryModel> resp = [];
    try {
      final response = await http.get(
        Uri.parse(ApiList.photoList),
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        print(response.body);
        // SharedPref().setApiResponse(response.body);
        resp = galleryModelFromJson(response.body);
        return resp;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Data not found!")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      log(e.toString());
    }
    return resp;
  }

  //:::::::::::::::: alternative ::::::::::::::::::
  Future<List<GalleryModel>> fetchDetails() async {
    final response = await http.get(
        Uri.parse(ApiList.photoList),
      );
    if (response.statusCode == 200) {
      log(response.body.toString());
      return galleryModelFromJson(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
