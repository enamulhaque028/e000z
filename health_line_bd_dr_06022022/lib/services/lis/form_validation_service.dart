import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/model/lis/form_validation_model.dart';
import 'package:http/http.dart' as http;

class FormValidationService {
  Future fetchFormData() async {
    String extUrl = 'tab/sel/user/c';
    Uri url = Uri.parse(baseUrlLis + extUrl);
    // String url = "http://192.168.0.54:8088/ords/ordstest/tab/sel/user/c";

    final response = await http.get(url);
    if (response.statusCode == 200) {
      // log(response.body);
      return formValidationFromJson(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
