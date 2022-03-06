import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:http_parser/http_parser.dart';

class PickImages extends StatefulWidget {
  final String imageType;
  static String pharmacyImgPath = '';
  static String visitingCardImgPath = '';
  static String otherImgPath = '';

  const PickImages({Key key, @required this.imageType}) : super(key: key);
  // static List base64ImageList = [];
  @override
  _PickImagesState createState() => _PickImagesState();
}

class _PickImagesState extends State<PickImages> {
  List<Object> images = [];
  Future<PickedFile> _imageFile;
  final picker = ImagePicker();

  Future _onAddImageClick(int index, int type) async {
    if (images != null)
      setState(() {
        // ignore: deprecated_member_use
        _imageFile = picker.getImage(
          source: type == 1 ? ImageSource.camera : ImageSource.gallery,
          imageQuality: 50,
        );
        getFileImage(index);
      });
  }

  void getFileImage(int index) async {
    _imageFile.then((file) async {
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      //var userCode = prefs.getString('userCode');
      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel();
        imageUpload.imageFile = File(file.path);
        // List<int> imageBytes = File(file.path).readAsBytesSync();
        widget.imageType == 'shop'
            ? PickImages.pharmacyImgPath = file.path
            : widget.imageType == 'card'
                ? PickImages.visitingCardImgPath = file.path
                : PickImages.otherImgPath = file.path;
        // print(PickImages.pharmacyImgPath);
        images.replaceRange(index, index + 1, [imageUpload]);

        //PickImages.base64ImageList = List();
        // PickImages.base64ImageList.add(base64Image);
        //log('Image Test $base64ImageList');

        //post image with additional informations
        // sendImage(
        //     base64Image.toString(), //post image to server
        //     SelectClient.mySelection['CLIENTS_ID'].toString(),
        //     SelectProject.mySelection['PROJECT_ID'].toString(),
        //     userCode.toString());
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      images.add("Add Image");
      // images.add("Add Image");
      // images.add("Add Image");
      // images.add("Add Image");
      // images.add("Add Image");
      // images.add("Add Image");
    });
  }

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            widget.imageType == 'shop'
                ? 'newPharmacyRequest.attatchmentTitleShop'.tr().toString()
                : widget.imageType == 'card'
                    ? 'newPharmacyRequest.attatchmentTitleCard'.tr().toString()
                    : 'newPharmacyRequest.attatchmentTitleOthers'
                        .tr()
                        .toString(),
            style: TextStyle(
              // color: cViolet,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Center(
          child: Container(
            width: 190,
            height: 170,
            child: GridView.count(
              shrinkWrap: true,
              // crossAxisCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 1,
              childAspectRatio: 1.4,
              children: List.generate(images.length, (index) {
                if (images[index] is ImageUploadModel) {
                  ImageUploadModel uploadModel = images[index];
                  // //base64 image
                  // List<int> imageBytes =
                  //     uploadModel.imageFile.readAsBytesSync();
                  // PickImages.base64Image = base64Encode(
                  //     imageBytes); //'base64Image' holds the base64 image string
                  return Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border:
                            Border.all(width: 1, color: Colors.transparent)),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: <Widget>[
                        Image.file(
                          uploadModel.imageFile,
                          fit: BoxFit.fill,
                          width: 300,
                          height: 300,
                        ),
                        Positioned(
                          right: 45,
                          top: 15,
                          child: InkWell(
                            child: Icon(
                              Icons.remove_circle,
                              size: 40,
                              color: Colors.red,
                            ),
                            onTap: () {
                              setState(() {
                                images.replaceRange(
                                    index, index + 1, ['Add Image']);
                              });
                            },
                          ),
                        ),
                        // ignore: deprecated_member_use
                        // RaisedButton(
                        //   child: Text('imgInfo'),
                        //   onPressed: () {
                        //     print(
                        //         "${uploadModel.imageFile.lengthSync() / 1024} KB"); //print image size in kb
                        //     print(uploadModel.imageFile.path); //print image path
                        //     // log(PickImages.base64Image);
                        //     uploadImage(File(uploadModel.imageFile.path));
                        //   },
                        // ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SafeArea(
                                  child: Container(
                                    child: new Wrap(
                                      children: <Widget>[
                                        new ListTile(
                                          leading: new Icon(Icons.photo_camera),
                                          title: new Text('Camera'),
                                          onTap: () {
                                            _onAddImageClick(index, 1);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        new ListTile(
                                            leading:
                                                new Icon(Icons.photo_library),
                                            title: new Text('Gallery'),
                                            onTap: () {
                                              _onAddImageClick(index, 2);
                                              Navigator.of(context).pop();
                                            }),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Text(widget.imageType == 'shop'
                            ? 'newPharmacyRequest.attatchmentUploadShop'
                                .tr()
                                .toString()
                            : widget.imageType == 'card'
                                ? 'newPharmacyRequest.attatchmentUploadCard'
                                    .tr()
                                    .toString()
                                : 'newPharmacyRequest.attatchmentUploadOthers'
                                    .tr()
                                    .toString())
                      ],
                    ),
                  );
                }
              }),
            ),
          ),
        ),
      ],
    );
  }
}

class ImageUploadModel {
  File imageFile;

  ImageUploadModel({
    this.imageFile,
  });
}
