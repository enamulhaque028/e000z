import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/model/dropdown/department_model.dart';
import 'package:health_line_bd/model/dropdown/designation_model.dart';
import 'package:health_line_bd/model/dropdown/institution_model.dart';
import 'package:http/http.dart' as http;

class DropdownServices {
  Future<DesignationModel> fetchDesignation() async {
    String extUrl = 'doctor/get-all-designations';
    Uri url = Uri.parse(baseUrl + extUrl);

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      // log(response.body);
      return designationModelFromJson(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  Future<DepartmentModel> fetchDepartment() async {
    String extUrl = 'doctor/get-all-departments';
    Uri url = Uri.parse(baseUrl + extUrl);

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      // log(response.body);
      return departmentModelFromJson(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  Future<InstitutionModel> fetchInstitution() async {
    String extUrl = 'doctor/get-all-institutes';
    Uri url = Uri.parse(baseUrl + extUrl);

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      // log(response.body);
      return institutionModelFromJson(response.body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
