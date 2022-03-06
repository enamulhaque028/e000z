import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:dil_app/config/common_const.dart';
import 'package:dil_app/config/sp_utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future createTicket(
    String ticketDescString,
    String ticketTitleString,
    String pROJTNAME,
    String pROJECTID,
    String cLIENTSID,
    String cOMPANYID,
    String tKTPRIID,
    String refctktId,
    List<String> attachment,
    String ticketPriorityString) async {

    /********************************** get sharedpreference values  ************************************/
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userCode = prefs.getString('userCode');
    String companyId = await SharedPref().geCompanyId();
    String cBranchId = await SharedPref().getCBranchId();
    String cobUnitId = await SharedPref().getCobUnitId();
    String ptgUnitId = await SharedPref().getPtgUnitId();
    getAttachment() {
      List images = [];
      for (int i = 0; i < attachment.length; i++) {
        images.add({"UserCode": userCode, "Attachment": attachment[i]});
      }
      return images;
    }

  Map data = {
    "clients": {"CLIENTS_ID": cLIENTSID, "COMPANY_ID": cOMPANYID},
    "projects": {"PROJECT_ID": pROJECTID, "PROJT_NAME": pROJTNAME},
    "ticketDescString": ticketDescString,
    "ticketMode": {"TR_MODE_ID": "6"},
    "ticketPriority": {"TKT_PRI_ID": tKTPRIID},
    "ticketTitle": {"refctkt_id": refctktId},
    "ticketTitleString": ticketTitleString,
    "ticketType": {"TR_TYPE_ID": "2"},
    "userCode": userCode,
    "ticketPriorityString": ticketPriorityString,
    "COMPANY_ID": companyId,
    "CBRANCH_ID": cBranchId,
    "COBUNIT_ID": cobUnitId,
    "PTGUNIT_ID": ptgUnitId,
    "TKTSTUS_ID": "1",
    "attatchments": getAttachment()
  };

  var body = json.encode(data);
  String extUrl = 'submitTicketAttachmentEmail';
  Uri url = Uri.parse(baseUrl + extUrl);
  //String url = 'http://192.168.0.89/ati-erp/api/submitTicket';
  log(body);

  final http.Response response = await http.post(url, body: body);
  if (response.statusCode == 200) {
    print(response.body);
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to submit');
  }
}
