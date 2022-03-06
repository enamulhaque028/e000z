import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/services/delete_gallery_image_service.dart';
import 'package:swipe/services/upload_gallery_images_service.dart';
import 'package:swipe/widgets/multi_image_picker.dart';

class GalleryInfo extends StatefulWidget {
  final List<String> galleryPhotos;
  final Function(List<String>) onUploadGalleryImage;
  const GalleryInfo({
    Key? key,
    required this.galleryPhotos,
    required this.onUploadGalleryImage,
  }) : super(key: key);

  @override
  State<GalleryInfo> createState() => _GalleryInfoState();
}

class _GalleryInfoState extends State<GalleryInfo> {
  UploadGalleryImages uploadGalleryImages = new UploadGalleryImages();
  DeleteGalleryImage deleteGalleryImage = new DeleteGalleryImage();
  late List<String> galleryImageList = widget.galleryPhotos;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Container(
        // height: 200,
        width: size.width,
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(218, 227, 231, 1), width: 1),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.iconBackground,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/gallery.png', height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Gallery',
                      style: TextStyle(fontSize: 18, color: AppColor.secondaryTextColor),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  galleryImageList.isEmpty
                  ? Container(child: Text('No images found in your gallery!'))
                  : SizedBox(
                    height: 60,
                    width: size.width - 132,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: galleryImageList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Stack(
                            children: [
                              Image.network(
                                galleryImageList[index],
                                fit: BoxFit.cover,
                                height: 60,
                                width: 65,
                                errorBuilder: (context, object, stackTrace) {
                                  return Image.network(
                                    'https://raw.githubusercontent.com/enamulhaque028/data/main/user.png',
                                    fit: BoxFit.fill,
                                    height: 60,
                                    width: 65,
                                  );
                                },
                              ),
                              Positioned(
                                // top: 10,
                                right: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    // print(galleryImageList[index]);
                                    showDialog(
                                      context: context,
                                      builder: (context) => Center(child: CircularProgressIndicator(color: Color.fromRGBO(143, 148, 251, 1))),
                                    );
                                    deleteGalleryImage.deleteImage(imageUrl: galleryImageList[index]).then((value) {
                                      if (deleteGalleryImage.statusCode == 200) {
                                        setState(() {
                                          galleryImageList = List<String>.from((value['user']['gallery']));
                                          widget.onUploadGalleryImage(galleryImageList);
                                        });
                                        Navigator.of(context).pop();
                                        showModalBottomSheet(
                                          context: context,
                                          backgroundColor: AppColor.kBackground,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15.0),
                                              topRight: Radius.circular(15.0),
                                            ),
                                          ),
                                          builder: (context) {
                                            return Container(
                                              height: 150,
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.check_circle, size: 60, color: Colors.green),
                                                    Text(
                                                      'Deleted',
                                                      style: TextStyle(fontSize: 16, color: AppColor.primaryTextColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        Navigator.of(context).pop();
                                        CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.error,
                                          text: 'Delete failed! Try again',
                                        );
                                      }
                                    });
                                  },
                                  child: Icon(Icons.cancel_rounded, color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context)=>Center(child: CircularProgressIndicator(color: Color.fromRGBO(143, 148, 251, 1))),
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return MultiImagePickerDialog(
                              onUploadPhotos: (imagePath) {
                                uploadGalleryImages.uploadImages(imagePath: imagePath).then((value) {
                                  if (uploadGalleryImages.statusCode == 200) {
                                    setState(() {
                                      galleryImageList = List<String>.from((value['user']['gallery']));
                                      widget.onUploadGalleryImage(galleryImageList);
                                    });
                                    Navigator.of(context).pop();
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.success,
                                      text: 'Updated your gallery!',
                                    );
                                  } else {
                                    Navigator.of(context).pop();
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.error,
                                      text: 'Update failed! Try again',
                                    );
                                  }
                                });
                              },
                            );
                          },
                        );
                      },
                      child: Image.asset(
                        'assets/images/add_sq.png',
                        fit: BoxFit.cover,
                        height: 62,
                        width: 65,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
