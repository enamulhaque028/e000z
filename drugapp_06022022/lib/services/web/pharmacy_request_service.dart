import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mediinfo/models/token.dart';

class PharmacyRequestService {
  Future sendRequest({
    @required String pharmacyName,
    @required String ownerName,
    @required String lisenceNo,
    @required String pharmacistNameAndRegNo,
    @required String mobileNo,
    @required String telephoneNo,
    @required String pharmacyAddress,
    @required String divisionName,
    @required String districtName,
    @required String pharmacyCategory,
    @required String latitude,
    @required String longitude,
    @required String altitude,
    @required String accuracy,
    @required String locationAddress,
    @required String recommendation,
    @required String pharmacyImgPath,
    @required String visitingCardImgPath,
    @required String otherImgPath,
  }) async {
    String token = await Token().getToken();
    String tokenType = await Token().getTokenType();

    // String extUrl = 'update_stud_info';
    // Uri url = Uri.parse(baseUrl + extUrl);
    // String url = "http://192.168.0.89:8000/birdem-ams/api/update_stud_info";

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$tokenType $token',
      // 'Cookie': 'JSESSIONID=64B9B5E9714C8640A7184AAB72BF5C97'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('http://192.168.0.73:8082/product-api/product/addRegister'));
    Map data = {
      'pharmacyName': pharmacyName,
      'ownerName': ownerName,
      'lisenceNo': lisenceNo,
      'pharmacistNameAndRegNo': pharmacistNameAndRegNo,
      'mobileNo': mobileNo,
      'telephoneNo': telephoneNo,
      'pharmacyAddress': pharmacyAddress,
      'divisionName': divisionName,
      'districtName': districtName,
      'pharmacyCategory': pharmacyCategory,
      'latitude': latitude,
      'longitude': longitude,
      'altitude': altitude,
      'accuracy': accuracy,
      'locationAddress': locationAddress,
      'recommendation': recommendation
    };

    var register = json.encode(data);
    request.fields.addAll({'register': register});
    pharmacyImgPath == ''
        ? Container()
        : request.files.add(await http.MultipartFile.fromPath(
            'pharmacyImgfile', pharmacyImgPath));
    visitingCardImgPath == ''
        ? Container()
        : request.files.add(await http.MultipartFile.fromPath(
            'visitingCardImgfile', visitingCardImgPath));
    otherImgPath == ''
        ? Container()
        : request.files.add(
            await http.MultipartFile.fromPath('otherImgfile', otherImgPath));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    log(request.fields.toString());
    if (response.statusCode == 201) {
      String responseBody = await response.stream.bytesToString();
      Map resp = json.decode(responseBody);
      log(responseBody);
      return resp;
    } else {
      log(response.reasonPhrase);
    }
  }
}
