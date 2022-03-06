import 'package:http/http.dart' as http;
import 'model.dart';

class Webservice {
  Future<DistrictModel> fetchDistricts() async {
    String url =
        "https://raw.githubusercontent.com/ezatechbd/data/master/new_pharma_req.json";

    final response = await http.get(url);
    if (response.statusCode == 200) {
      // log(response.body);
      return districtModelFromJson(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
