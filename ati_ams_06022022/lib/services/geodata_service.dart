import 'dart:convert';
import 'dart:developer';
import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/model/geodata_model.dart';
import 'package:http/http.dart' as http;

class GeoDataService {
  Future fetchGeoData(String geoGroupId) async {
    Map data = {"Geo_GROUP_ID": geoGroupId};
    var body = json.encode(data);
    String extUrl = 'geo_data';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = "http://192.168.0.89:8000/birdem-ams/api/geo_data";

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    // log(response.body);
    // log(body);
    if (response.statusCode == 200) {
      // log(response.body);
      print('Geodata Request Successful!!!');
      return geoDataModelFromJson(response.body);
    } else {
      log('Geodata Request failed!!!');
      // log(response.statusCode.toString());
      // return jsonDecode(response.body);
    }
  }
}
