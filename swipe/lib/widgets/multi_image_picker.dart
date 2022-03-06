import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultiImagePickerDialog extends StatefulWidget {
  final Function(List<String>) onUploadPhotos;
  const MultiImagePickerDialog({Key? key, required this.onUploadPhotos}) : super(key: key);

  @override
  _MultiImagePickerDialogState createState() => _MultiImagePickerDialogState();
}

class _MultiImagePickerDialogState extends State<MultiImagePickerDialog> {

  XFile? imageFile = null;
  String imagePath = '';
  final ImagePicker imagePicker = ImagePicker();
  List<String>? multiPath = [];

  void _selectMultipleImages(BuildContext context) async {
    final selectedImages = await imagePicker.pickMultiImage();
    selectedImages!.forEach((image) {
      setState(() {
        multiPath!.add(image.path);
      });
    });
    print("Image List:" + multiPath![0]);
    widget.onUploadPhotos(multiPath!);
    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
      imagePath = pickedFile.path;
      multiPath!.add(imagePath);
    });
    log(imagePath);
    widget.onUploadPhotos(multiPath!);
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Choose option",
        style: TextStyle(color: Colors.blue),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Divider(height: 1, color: Colors.black),
            ListTile(
              onTap: () {
                _selectMultipleImages(context);
              },
              title: Text("Gallery"),
              leading: Icon(Icons.photo, color: Colors.blue),
            ),
            Divider(height: 1, color: Colors.black),
            ListTile(
              onTap: () {
                _openCamera(context);
              },
              title: Text("Camera"),
              leading: Icon(Icons.camera_alt, color: Colors.blue,),
            ),
          ],
        ),
      ),
    );
  }
}
