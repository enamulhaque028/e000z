import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ImageUploadService {
  ImageUploadService({this.isNidSelected = false});
  final bool isNidSelected;

  static String fileDownloadUrl = '';
  static String nidDownloadUrl = '';

  Future uploadImage(File file, BuildContext context, String uploadUrl) async {
    //get DateTime for file name
    String getDateTime() {
      DateTime now = DateTime.now();
      String notificationDate = now.day.toString().padLeft(2, '0') +
          "" +
          now.month.toString().padLeft(2, '0') +
          "" +
          now.year.toString() +
          "" +
          now.hour.toString().padLeft(2, '0') +
          "" +
          now.minute.toString().padLeft(2, '0');
      return notificationDate;
    }

    String fileExt = "${file.path.split(".").last}";
    String fileName = isNidSelected == false
        ? 'AtiLis_${getDateTime()}_PI.$fileExt'
        : 'AtiLis_${getDateTime()}_NI.$fileExt';
    // print(fileName);
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    var request = http.MultipartRequest(
        'POST',
        // Uri.parse(
        //     'http://gpst.billingdil.com:8088/tourplan_ws/file/uploadFile'));
        Uri.parse(uploadUrl));
    request.files.add(await http.MultipartFile.fromPath('file', file.path,
        filename: fileName, contentType: MediaType("image", fileExt)));

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Map resp = json.decode(responseBody);
        log(responseBody);
        log('File Download Url: ${resp['fileDownloadUri']}');
        // ImageUploadService.fileDownloadUrl = resp['fileDownloadUri']
        //     .toString(); //set fileDownloadUrl to send in registration
        isNidSelected == false
            ? ImageUploadService.fileDownloadUrl = fileName
            : ImageUploadService.nidDownloadUrl = fileName;
        Navigator.of(context).pop();
      } else {
        log(response.reasonPhrase);
        Navigator.of(context).pop();
        CoolAlert.show(
          context: context,
          // width: 350,
          type: CoolAlertType.error,
          text: "Upload failed! Please upload again!",
        );
      }
    } catch (e) {
      log(e.toString());
      Navigator.of(context).pop();
      CoolAlert.show(
        context: context,
        // width: 350,
        type: CoolAlertType.error,
        text: "Upload failed! Please upload again!",
      );
      return null;
    }
  }
}
