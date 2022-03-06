import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarImagePickerDialog extends StatefulWidget {
  final Function(String) updatePhoto;
  const AvatarImagePickerDialog({Key? key, required this.updatePhoto}) : super(key: key);

  @override
  _AvatarImagePickerDialogState createState() => _AvatarImagePickerDialogState();
}

class _AvatarImagePickerDialogState extends State<AvatarImagePickerDialog> {

  XFile? imageFile = null;
  String imagePath = '';
  final ImagePicker imagePicker = ImagePicker();

  void _openGallery(BuildContext context) async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile!;
      imagePath = pickedFile.path;
    });
    log(imagePath);
    widget.updatePhoto(imagePath);
    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
      imagePath = pickedFile.path;
    });
    log(imagePath);
    widget.updatePhoto(imagePath);
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
                _openGallery(context);
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
