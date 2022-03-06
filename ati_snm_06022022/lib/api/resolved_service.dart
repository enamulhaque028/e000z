import 'dart:convert';
import 'dart:async';
import 'package:dil_app/config/common_const.dart';
import 'package:dil_app/model/resolved_model.dart';
import 'package:http/http.dart' as http;

Future<Resolved> resolvedTicket(
    String cTICKETID, String tICKETRTG, String tRTGFDBKS) async {
  Map data = {
    "CTICKET_ID": cTICKETID,
    "TKTSTUS_ID": "9",
    "TICKET_RTG": tICKETRTG,
    "TRTG_FDBKS": tRTGFDBKS
  };
  var body = json.encode(data);
  String extUrl = 'updateClientWiseTicketListStatus';
  Uri url = Uri.parse(baseUrl + extUrl);
  //String url = 'http://192.168.0.89/ati-erp/api/updateClientWiseTicketListStatus';

  final http.Response response = await http.post(
    url,
    // headers: <String, String>{
    //   'Content-Type': 'application/json; charset=UTF-8',
    // },
    body: body,
  );
  print(response.body);
  print(body);

  if (response.statusCode == 200) {
    return Resolved.fromJson(
      jsonDecode(response.body),
    );
  } else {
    throw Exception('Failed to resolve ticket');
  }
}
