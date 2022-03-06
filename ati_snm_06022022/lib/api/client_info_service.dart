import 'dart:convert';
import 'dart:developer';
import 'package:dil_app/config/common_const.dart';
import 'package:dil_app/model/client_info_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'db/db_provider.dart';

class ClientApiProvider {
  Future<List<ClientInfo>> getAllEmployees() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var saUserID = prefs.getString('saUserID');
    var employeeId = prefs.getString('employeeId') == "null"
        ? ""
        : prefs.getString('employeeId');
    var acpInfoID = prefs.getString('acpInfoID') == "null"
        ? ""
        : prefs.getString('acpInfoID');

    //Map data = {"CLIENTS_ID": clientsId};
    Map data = {
      "SAUSERS_ID": saUserID,
      "EMPLOYE_ID": employeeId,
      "ACPINFO_ID": acpInfoID,
    };
    var body = json.encode(data);
    log('clientWiseTicketList Body: $body');
    String extUrl = 'clientWiseTicketList';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = "http://192.168.0.89/ati-erp/api/clientWiseTicketList";
    http.Response response = await http.post(url, body: body);
    //debugPrint(response);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      // print(body);
      final List json = body;

      return json[0]["clientInfos"].map<ClientInfo>((employee) {
        print('Inserting $employee');
        DBProvider.db.createEmployee(ClientInfo.fromJson(employee));
      }).toList();
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
