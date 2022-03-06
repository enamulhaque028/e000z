// import 'package:aits_gallery/config/utils/sp_utils.dart';
import 'package:aits_gallery/model/model.dart';
import 'package:aits_gallery/service/cache_manager_service.dart';
import 'package:flutter/material.dart';

class GalleryDataProvider with ChangeNotifier {
  List<GalleryModel> galleryData = [];
  bool loading = true;
  bool isVisible = true;

  void getGalleryData(BuildContext context) async {
    loading = true;
    // String? resp = await SharedPref().getApiResponse();
    galleryData = await CacheManager().cacheApiRespone(context);
    loading = false;
    notifyListeners();
  }

  void checkVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }
}
