import 'dart:convert';
import 'dart:developer';
import 'dart:io';
//import 'package:dil_app/api/image_post_service.dart';
import 'package:dil_app/custom/custom_timeline_widget.dart';
//import 'package:dil_app/pages/ticketing/help/submit_issue/select_client/select_client.dart';
//import 'package:dil_app/pages/ticketing/help/submit_issue/select_project/select_project.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//import 'package:http/http.dart' as http;

class PickImages extends StatefulWidget {
  //static String base64Image;
  // ignore: deprecated_member_use
  static List<String> base64ImageList = [];
  @override
  _PickImagesState createState() => _PickImagesState();
}

class _PickImagesState extends State<PickImages> {
  // ignore: deprecated_member_use
  List<Object> images = List<Object>();
  Future<PickedFile> _imageFile;
  bool _isVisible = false;
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
        List<int> imageBytes = File(file.path).readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        print(base64Image);
        images.replaceRange(index, index + 1, [imageUpload]);

        //PickImages.base64ImageList = List();
        PickImages.base64ImageList.add(base64Image);
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

  void showImageBox() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _isVisible == true
            ? CustomTimeLine(height: width / 1.38)
            : CustomTimeLine(height: 50),
        Expanded(
          flex: 15,
          child: Column(
            children: <Widget>[
              Container(
                //padding: EdgeInsets.only(right: 5),
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    trailing: Icon(Icons.attachment),
                    title: Text('Attachments'),
                    onTap: () {
                      log(PickImages.base64ImageList.length.toString());
                      showImageBox();
                    },
                  ),
                ),
              ),
              Visibility(
                visible: _isVisible,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, right: 5.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        children: List.generate(images.length, (index) {
                          if (images[index] is ImageUploadModel) {
                            ImageUploadModel uploadModel = images[index];
                            // //base64 image
                            // List<int> imageBytes =
                            //     uploadModel.imageFile.readAsBytesSync();
                            // PickImages.base64Image = base64Encode(
                            //     imageBytes); //'base64Image' holds the base64 image string
                            return Card(
                              clipBehavior: Clip.antiAlias,
                              child: Stack(
                                children: <Widget>[
                                  Image.file(
                                    uploadModel.imageFile,
                                    fit: BoxFit.cover,
                                    width: 300,
                                    height: 300,
                                  ),
                                  Positioned(
                                    right: 5,
                                    top: 5,
                                    child: InkWell(
                                      child: Icon(
                                        Icons.remove_circle,
                                        size: 20,
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
                                  // RaisedButton(
                                  //   child: Text('imgInfo'),
                                  //   onPressed: () {
                                  //     print(
                                  //         "${uploadModel.imageFile.lengthSync() / 1024} KB"); //print image size in kb
                                  //     print(uploadModel
                                  //         .imageFile.path); //print image path
                                  //     log(PickImages.base64Image);
                                  //     print(images);
                                  //   },
                                  // ),
                                ],
                              ),
                            );
                          } else {
                            return Card(
                              child: IconButton(
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
                                                leading: new Icon(
                                                    Icons.photo_camera),
                                                title: new Text('Camera'),
                                                onTap: () {
                                                  _onAddImageClick(index, 1);
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              new ListTile(
                                                  leading: new Icon(
                                                      Icons.photo_library),
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
                            );
                          }
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
